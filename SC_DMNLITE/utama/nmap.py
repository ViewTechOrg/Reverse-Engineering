import os
import time
from colorama import Fore, init
from urllib.parse import urlparse

# Auto Installer
try:
    from colorama import Fore
except:
    os.system("pip install colorama")

try:
    os.system("nmap -h > /dev/null 2>&1")
except:
    os.system("pkg install nmap -y")

init(autoreset=True)

def banner():
    print(Fore.GREEN + r"""
╔═╗╔═╗╔═╗╦═╗╔═╗╔╦╗  ╔╦╗╔═╗╔═╗╔╦╗╔═╗╔╗╔╦╦ ╦╔╦╗
╚═╗║╣ ║  ╠╦╝║╣  ║    ║║╠═╣║╣ ║║║║ ║║║║║║ ║║║║
╚═╝╚═╝╚═╝╩╚═╚═╝ ╩   ═╩╝╩ ╩╚═╝╩ ╩╚═╝╝╚╝╩╚═╝╩ ╩

::=========[ ☠ MENU NMAP ☠ ]=========::
""")

def sanitize_target(raw):
    raw = raw.strip()
    if raw.startswith("http://") or raw.startswith("https://"):
        parsed = urlparse(raw)
        return parsed.hostname
    if "/" in raw:
        return raw.split("/")[0]
    return raw

def run_nmap(command):
    os.system("clear")
    print(Fore.GREEN + f"\n[~] Menjalankan: {command}\n")
    os.system(command)
    input(Fore.GREEN + "\n[ ENTER untuk kembali ke menu... ]")

def run():
    while True:
        os.system("clear")
        banner()
        print(Fore.GREEN + """
[01] Scan cepat (ping)
[02] Scan port tertentu
[03] Scan semua port
[04] Scan versi service
[05] Scan top 1000 port
[06] Scan TCP Connect
[07] Ping scan subnet (ex: 192.168.1.0/24)
[08] List IP/domain (tanpa scan)
[09] Scan tanpa DNS resolution
[10] Scan dan simpan ke file teks

[00] Kembali ke menu utama
""")
        pilih = input(Fore.GREEN + "[?] Pilih opsi > ")

        if pilih == "1":
            target = sanitize_target(input(Fore.GREEN + "Target IP/Domain: "))
            run_nmap(f"nmap -sn {target}")
        elif pilih == "2":
            target = sanitize_target(input(Fore.GREEN + "Target: "))
            port = input(Fore.GREEN + "Port (contoh: 22,80): ")
            run_nmap(f"nmap -p {port} {target}")
        elif pilih == "3":
            target = sanitize_target(input(Fore.GREEN + "Target: "))
            run_nmap(f"nmap -p- {target}")
        elif pilih == "4":
            target = sanitize_target(input(Fore.GREEN + "Target: "))
            run_nmap(f"nmap -sV {target}")
        elif pilih == "5":
            target = sanitize_target(input(Fore.GREEN + "Target: "))
            run_nmap(f"nmap --top-ports 1000 {target}")
        elif pilih == "6":
            target = sanitize_target(input(Fore.GREEN + "Target: "))
            run_nmap(f"nmap -sT {target}")
        elif pilih == "7":
            subnet = sanitize_target(input(Fore.GREEN + "Subnet (ex: 192.168.1.0/24): "))
            run_nmap(f"nmap -sn {subnet}")
        elif pilih == "8":
            target = sanitize_target(input(Fore.GREEN + "Domain/IP: "))
            run_nmap(f"nmap -sL {target}")
        elif pilih == "9":
            target = sanitize_target(input(Fore.GREEN + "Target: "))
            run_nmap(f"nmap -n {target}")
        elif pilih == "10":
            target = sanitize_target(input(Fore.GREEN + "Target: "))
            run_nmap(f"nmap -oN hasil.txt {target}")
        elif pilih == "00":
            print(Fore.GREEN + "\n[!] Kembali ke menu utama...\n")
            time.sleep(1)
            break
        else:
            input(Fore.GREEN + "\n[!] Pilihan tidak valid. ENTER untuk ulangi...")

if __name__ == "__main__":
    try:
        run()
        print(Fore.GREEN + "\n[✓] Sesi Nmap selesai. Terima kasih!\n")
    except KeyboardInterrupt:
        print(Fore.GREEN + "\n[!] Dihentikan oleh pengguna.\n")
