import os
import shutil

# Warna
GREEN = '\033[92m'
RESET = '\033[0m'

# Auto Installer
def auto_install():
    try:
        import requests
    except ImportError:
        os.system("pip install requests")
    os.system("pkg install -y curl > /dev/null 2>&1")

# Banner ASCII
def banner():
    os.system("clear")
    print(f"""{GREEN}

╔═╗╔═╗╔═╗╦═╗╔═╗╔╦╗  ╔╦╗╔═╗╔═╗╔╦╗╔═╗╔╗╔╦╦ ╦╔╦╗
╚═╗║╣ ║  ╠╦╝║╣  ║    ║║╠═╣║╣ ║║║║ ║║║║║║ ║║║║
╚═╝╚═╝╚═╝╩╚═╚═╝ ╩   ═╩╝╩ ╩╚═╝╩ ╩╚═╝╝╚╝╩╚═╝╩ ╩

  ::=========[ ☠ SUBFINDER ☠ ]=========::
{RESET}""")

# Fungsi mencari subdomain
def find_subdomains(domain):
    print(f"\n{GREEN}[+] Mencari subdomain untuk: {domain}{RESET}\n")

    try:
        url = f"https://api.hackertarget.com/hostsearch/?q={domain}"
        import requests
        response = requests.get(url)

        if "error" in response.text.lower():
            print(f"{GREEN}[!] Gagal mengambil data: {response.text.strip()}{RESET}")
            return

        lines = response.text.strip().split('\n')
        found = [line.split(',')[0] for line in lines if domain in line]

        if found:
            print(f"{GREEN}[✓] Subdomain ditemukan:{RESET}\n")
            for sub in sorted(set(found)):
                print(f"{GREEN}{sub}{RESET}")
        else:
            print(f"{GREEN}[!] Tidak ada subdomain ditemukan.{RESET}")

    except Exception as e:
        print(f"{GREEN}[!] Terjadi kesalahan: {e}{RESET}")

# Fungsi utama
def run():
    auto_install()
    banner()
    domain = input(f"{GREEN}Masukkan domain target: {RESET}")
    find_subdomains(domain)
    input(f"\n{GREEN}Tekan Enter untuk kembali...{RESET}")

# Jika dijalankan langsung
if __name__ == "__main__":
    run()
