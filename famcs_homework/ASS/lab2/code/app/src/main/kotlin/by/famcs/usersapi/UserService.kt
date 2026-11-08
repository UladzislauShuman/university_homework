package by.famcs.usersapi

import io.micrometer.core.instrument.Counter
import io.micrometer.core.instrument.MeterRegistry
import io.micrometer.core.instrument.Timer
import org.slf4j.LoggerFactory
import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.data.redis.core.StringRedisTemplate
import org.springframework.stereotype.Service
import tools.jackson.databind.json.JsonMapper
import java.time.Duration
import java.util.concurrent.ThreadLocalRandom

@ConfigurationProperties("app.cache")
data class CacheProps(
    val enabled: Boolean = true,
    val ttl: Duration = Duration.ofMinutes(30),
    val ttlJitter: Double = 0.1,
)

@Service
class UserService(
    private val repo: UserRepository,
    private val redis: StringRedisTemplate,
    private val json: JsonMapper,
    private val props: CacheProps,
    registry: MeterRegistry,
) {
    private val log = LoggerFactory.getLogger(javaClass)

    // счётчики попаданий / промахов / ошибок redis
    private val hits = Counter.builder("users.cache").tag("result", "hit").register(registry)
    private val misses = Counter.builder("users.cache").tag("result", "miss").register(registry)
    private val errors = Counter.builder("users.cache").tag("result", "error").register(registry)

    // сколько времени уходит на поход в базу и в redis
    private val dbTimer = Timer.builder("users.db.query").register(registry)
    private val cacheTimer = Timer.builder("users.cache.get").register(registry)

    init {
        log.info("cache enabled = {}", props.enabled)
    }

    fun getUser(id: Long): User? {
        // базовый сценарий: всегда в базу
        if (!props.enabled) return loadFromDb(id)

        val key = "user:$id"

        // 1. сначала смотрим в кэш
        val cached = try {
            cacheTimer.recordCallable { redis.opsForValue().get(key) }
        } catch (e: Exception) {
            // redis лежит или не ответил за timeout -> работаем напрямую с базой
            errors.increment()
            return loadFromDb(id)
        }

        if (cached != null) {
            hits.increment()
            return json.readValue(cached, User::class.java)
        }

        // 2. промах: читаем из базы
        misses.increment()
        val user = loadFromDb(id) ?: return null

        // 3. кладём в кэш, чтобы следующий запрос за этим id попал в redis
        try {
            redis.opsForValue().set(key, json.writeValueAsString(user), ttlWithJitter())
        } catch (e: Exception) {
            errors.increment()
        }
        return user
    }

    private fun loadFromDb(id: Long): User? = dbTimer.recordCallable { repo.findById(id) }

    // ttl +- jitter, чтобы ключи, положенные одновременно, не протухли в одну секунду
    private fun ttlWithJitter(): Duration {
        val k = 1 + ThreadLocalRandom.current().nextDouble(-props.ttlJitter, props.ttlJitter)
        return Duration.ofMillis((props.ttl.toMillis() * k).toLong())
    }
}
