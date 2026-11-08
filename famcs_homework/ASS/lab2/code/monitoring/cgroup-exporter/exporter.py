# маленький экспортер cpu/памяти контейнеров для prometheus.
# cadvisor не видит контейнеры в docker desktop 29 (containerd), поэтому читаем cgroup напрямую:
#   /sys/fs/cgroup/docker/<id>/cpu.stat       -> usage_usec (сколько процессорного времени съел контейнер)
#   /sys/fs/cgroup/docker/<id>/memory.current -> сколько памяти занято сейчас
# имена контейнеров берём из docker api через сокет.
import http.client
import json
import os
import socket
from http.server import BaseHTTPRequestHandler, HTTPServer

CG = "/cg/docker"


class UnixConn(http.client.HTTPConnection):
    def __init__(self):
        super().__init__("localhost")

    def connect(self):
        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.sock.connect("/var/run/docker.sock")


def container_names():
    c = UnixConn()
    c.request("GET", "/containers/json")
    data = json.loads(c.getresponse().read())
    return {x["Id"]: x["Names"][0].lstrip("/") for x in data}


def read(path):
    with open(path) as f:
        return f.read()


def metrics():
    lines = [
        "# TYPE container_cpu_usage_seconds_total counter",
        "# TYPE container_memory_usage_bytes gauge",
    ]
    for cid, name in container_names().items():
        d = os.path.join(CG, cid)
        if not os.path.isdir(d):
            continue
        usec = next(int(l.split()[1]) for l in read(d + "/cpu.stat").splitlines() if l.startswith("usage_usec"))
        mem = int(read(d + "/memory.current"))
        lines.append(f'container_cpu_usage_seconds_total{{name="{name}"}} {usec / 1e6}')
        lines.append(f'container_memory_usage_bytes{{name="{name}"}} {mem}')
    return "\n".join(lines) + "\n"


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = metrics().encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; version=0.0.4")
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *args):
        pass


HTTPServer(("", 9101), Handler).serve_forever()
