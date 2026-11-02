import argparse
import json
import time
import uuid

from confluent_kafka import Consumer


def percentile(sorted_values, p):
    idx = min(len(sorted_values) - 1, int(len(sorted_values) * p / 100))
    return sorted_values[idx]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--topic", required=True)                # куда стрим-приложение пишет обработанные события
    parser.add_argument("--idle-timeout", type=int, default=15)  # сколько секунд тишины = поток закончился
    parser.add_argument("--max-wait", type=int, default=600)     # на всякий случай - общий предел ожидания
    args = parser.parse_args()

    consumer = Consumer({
        "bootstrap.servers": "localhost:9092",
        "group.id": f"measure-{uuid.uuid4()}",  # каждый замер - новая группа, чтобы не мешали старые смещения
        "auto.offset.reset": "latest",          # читаем только то, что придёт после старта замера
    })
    consumer.subscribe([args.topic])

    latencies = []
    first_recv = last_recv = None
    start = time.time()

    while time.time() - start < args.max_wait:
        msg = consumer.poll(1.0)
        if msg is None:
            # если уже что-то получали и давно тишина - замер окончен
            if last_recv is not None and time.time() - last_recv > args.idle_timeout:
                break
            continue
        if msg.error():
            continue

        recv_ms = int(time.time() * 1000)
        event = json.loads(msg.value())
        # end-to-end: от отправки producer'ом до получения результата здесь
        latencies.append(recv_ms - event["produce_ts"])
        if first_recv is None:
            first_recv = time.time()
        last_recv = time.time()

    consumer.close()

    if not latencies:
        print("ничего не пришло")
        return

    latencies.sort()
    duration = max(last_recv - first_recv, 1e-9)
    print(f"events={len(latencies)}")
    print(f"throughput={len(latencies) / duration:.0f} events/s")
    print(f"latency_ms p50={percentile(latencies, 50)} p95={percentile(latencies, 95)} "
          f"p99={percentile(latencies, 99)} max={latencies[-1]}")


if __name__ == "__main__":
    main()
