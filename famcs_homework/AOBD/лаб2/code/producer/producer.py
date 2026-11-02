import argparse
import json
import random
import time

from confluent_kafka import Producer

EVENT_TYPES = ["view", "click", "add_to_cart", "purchase"]


def now_ms():
    return int(time.time() * 1000)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--topic", default="events")
    parser.add_argument("--rate", type=int, default=50)          # событий в секунду, 0 - без ограничения
    parser.add_argument("--duration", type=int, default=60)      # сколько секунд слать
    parser.add_argument("--users", type=int, default=6)          # сколько разных ключей (пользователей)
    parser.add_argument("--late-share", type=float, default=0.05)      # доля событий, пришедших с опозданием
    parser.add_argument("--very-late-share", type=float, default=0.01) # доля сильно опоздавших
    parser.add_argument("--steady", action="store_true")         # все пользователи активны всё время, без пауз
    args = parser.parse_args()

    # localhost:9092 - внешний вход брокера (см. kafka-cluster/docker-compose.yml)
    producer = Producer({"bootstrap.servers": "localhost:9092", "linger.ms": 5})

    users = [f"user_{i}" for i in range(1, args.users + 1)]
    # у каждого пользователя чередуются активность и пауза - так появляются сессии
    active_until = {u: 0 for u in users}
    idle_until = {u: 0 for u in users}

    start = time.time()
    sent = 0
    while time.time() - start < args.duration:
        now = time.time()

        if args.steady:
            active = users
        else:
            for u in users:
                if now >= active_until[u] and now >= idle_until[u]:
                    # пауза закончилась - новый период активности 10-30 с
                    active_until[u] = now + random.uniform(10, 30)
                    # за ним пауза 20-40 с, больше разрыва сессии
                    idle_until[u] = active_until[u] + random.uniform(20, 40)
            active = [u for u in users if now < active_until[u]]

        # сколько событий уже должно было уйти к этому моменту при заданной частоте
        target = sent + 1000 if args.rate == 0 else int((now - start) * args.rate)
        while sent < target and active:
            produce_ts = now_ms()  # момент отправки - от него потом считаем задержку

            r = random.random()
            if r < args.very_late_share:
                delay = random.randint(30_000, 60_000)
            elif r < args.very_late_share + args.late_share:
                delay = random.randint(3_000, 8_000)
            else:
                delay = random.randint(0, 500)

            user = random.choice(active)
            event = {
                "user_id": user,
                "event_type": random.choice(EVENT_TYPES),
                "event_time": produce_ts - delay,
                "produce_ts": produce_ts,
            }
            # все события одного пользователя попадают в одну партицию
            try:
                producer.produce(args.topic, key=user, value=json.dumps(event))
            except BufferError:
                # если локальная очередь producer'а забита, то подождём, пока часть уйдёт, и пробуем снова
                producer.poll(0.1)
                continue
            sent += 1
            producer.poll(0)

        time.sleep(0.005)

    producer.flush()  # дождаться, пока всё реально уйдёт в брокер
    elapsed = time.time() - start
    print(f"sent={sent} seconds={elapsed:.1f} rate={sent / elapsed:.0f}/s")


if __name__ == "__main__":
    main()
