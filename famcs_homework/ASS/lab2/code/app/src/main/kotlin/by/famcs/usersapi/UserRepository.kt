package by.famcs.usersapi

import org.springframework.jdbc.core.simple.JdbcClient
import org.springframework.stereotype.Repository
import java.time.OffsetDateTime

@Repository
class UserRepository(private val jdbc: JdbcClient) {

    // тот самый select * from users where id = $1
    fun findById(id: Long): User? =
        jdbc.sql("select * from users where id = ?")
            .param(id)
            .query { rs, _ ->
                User(
                    id = rs.getLong("id"),
                    username = rs.getString("username"),
                    email = rs.getString("email"),
                    firstName = rs.getString("first_name"),
                    lastName = rs.getString("last_name"),
                    city = rs.getString("city"),
                    birthDate = rs.getDate("birth_date").toLocalDate(),
                    createdAt = rs.getObject("created_at", OffsetDateTime::class.java),
                    bio = rs.getString("bio"),
                )
            }
            .optional()
            .orElse(null)
}
