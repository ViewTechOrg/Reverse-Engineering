import os
import time
import platform
import subprocess
import threading
import sys

# Auto Installer
def auto_install():
    try:
        import colorama
    except ImportError:
        os.system('pip install colorama')
    try:
        os.system('pkg install -y inetutils > /dev/null 2>&1')  # Untuk Termux
    except:
        pass

auto_install()
from colorama import init, Fore
init(autoreset=True)

# Banner ASCII
def banner():
    os.system("clear" if os.name != "nt" else "cls")
    print(Fore.GREEN + r'''
╔═╗╔═╗╔═╗╦═╗╔═╗╔╦╗  ╔╦╗╔═╗╔═╗╔╦╗╔═╗╔╗╔╦╦ ╦╔╦╗
╚═╗║╣ ║  ╠╦╝║╣  ║    ║║╠═╣║╣ ║║║║ ║║║║║║ ║║║║
╚═╝╚═╝╚═╝╩╚═╚═╝ ╩   ═╩╝╩ ╩╚═╝╩ ╩╚═╝╝╚╝╩╚═╝╩ ╩

::=========[ ☠ PING ☠ ]=========::
    ''')
# Fungsi ping dalam thread dengan sisipan info ENTER
def ping_thread(target, stop_flag):
    command = ["ping", target]
    try:
        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True)
        count = 0
        while not stop_flag[0]:
            line = process.stdout.readline()
            if not line:
                break
            print(Fore.GREEN + line.strip())
            count += 1
            if count % 5 == 0:
                print(Fore.GREEN + "⇨ Tekan ENTER 2x untuk menghentikan dan kembali...\n")
        process.terminate()
    except Exception as e:
        print(Fore.RED + f"[!] Error: {e}")

# Fungsi ping realtime + Enter 2 kali stop
def ping_site(target):
    print(Fore.GREEN + f"\n[✓] Mulai Ping ke: {target}")
    print(Fore.GREEN + "[⇆] Tekan ENTER 2x untuk menghentikan dan kembali ke menu.\n")

    stop_flag = [False]
    thread = threading.Thread(target=ping_thread, args=(target, stop_flag))
    thread.start()

    try:
        count = 0
        while True:
            input_str = input()
            if input_str.strip() == "":
                count += 1
                if count == 2:
                    stop_flag[0] = True
                    break
            else:
                count = 0
        thread.join()
    except KeyboardInterrupt:
        stop_flag[0] = True
        thread.join()
        print(Fore.GREEN + "\n[!] Dihentikan oleh pengguna.")

# Fungsi utama
def run():
    banner()
    try:
        target = input(Fore.GREEN + "\n[?] Masukkan domain website: ")
        if not target.strip():
            print(Fore.RED + "[!] Input tidak boleh kosong.")
            return
        ping_site(target)
    finally:
        input(Fore.GREEN + "\n[↩] Tekan Enter untuk kembali...")

# Jalankan langsung
if __name__ == "__main__":
    run()
