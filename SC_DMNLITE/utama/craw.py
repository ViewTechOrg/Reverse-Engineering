import re
import os
import time
import requests
import random
import json
import socket
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse

try:
    import requests, bs4
except ImportError:
    os.system("pip install requests beautifulsoup4")

GREEN = '\033[92m'
RESET = '\033[0m'

def show_banner():
    os.system("clear")
    banner = r"""
╔═╗╔═╗╔═╗╦═╗╔═╗╔╦╗  ╔╦╗╔═╗╔═╗╔╦╗╔═╗╔╗╔╦╦ ╦╔╦╗
╚═╗║╣ ║  ╠╦╝║╣  ║    ║║╠═╣║╣ ║║║║ ║║║║║║ ║║║║
╚═╝╚═╝╚═╝╩╚═╚═╝ ╩   ═╩╝╩ ╩╚═╝╩ ╩╚═╝╝╚╝╩╚═╝╩ ╩

::=========[ ☠ EMAIL CRAW ☠ ]=========::
   """
    print(f"{GREEN}{banner}{RESET}")

def spinner(teks, lama=3):
    frames = ['|', '/', '-', '\\']
    end_time = time.time() + lama
    idx = 0
    print(f"{GREEN}{teks}", end="", flush=True)
    while time.time() < end_time:
        print(f"\b{frames[idx % 4]}", end='', flush=True)
        idx += 1
        time.sleep(0.1)
    print(RESET)

def crawl_recursive(url, depth=2, visited=None):
    if visited is None:
        visited = set()
    if depth == 0 or url in visited:
        return ''
    visited.add(url)
    konten = ''
    try:
        headers = {'User-Agent': random_user_agent()}
        response = requests.get(url, timeout=5, headers=headers)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')
        konten += soup.get_text()
        for link in soup.find_all('a', href=True):
            full_url = urljoin(url, link['href'])
            if urlparse(full_url).netloc == urlparse(url).netloc:
                konten += crawl_recursive(full_url, depth-1, visited)
    except:
        pass
    return konten

def extract_emails(text):
    pattern = r"[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+"
    return list(set(re.findall(pattern, text)))

def print_emails_json(emails):
    print(f"{GREEN}\n📧 EMAIL DITEMUKAN (JSON FORMAT):{RESET}")
    print(GREEN + json.dumps({"emails": emails}, indent=4) + RESET)

def simpan_hasil(emails):
    os.makedirs("results", exist_ok=True)
    path = "results/Crawler.txt"
    with open(path, "a") as f:
        for email in emails:
            f.write(email + "\n")
    return path

def email_stats(emails):
    domain_count = {}
    for email in emails:
        domain = email.split('@')[-1]
        domain_count[domain] = domain_count.get(domain, 0) + 1
    return domain_count

def tampilkan_statistik(stats):
    print(f"\n{GREEN}📊 Statistik Email per Domain:{RESET}")
    print(GREEN + json.dumps(stats, indent=4) + RESET)

def random_user_agent():
    agents = [
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
        "Mozilla/5.0 (X11; Ubuntu; Linux x86_64)",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)",
        "Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X)",
        "Mozilla/5.0 (Linux; Android 10)",
        "Mozilla/5.0 (Windows NT 6.1; Win64; x64)"
    ]
    return random.choice(agents)

def valid_url(url):
    try:
        parsed = urlparse(url)
        if not parsed.scheme:
            url = "http://" + url
        socket.gethostbyname(parsed.netloc or parsed.path)
        test = requests.get(url, timeout=3)
        return True
    except:
        return False

def main():
    show_banner()

    while True:
        url = input(f"{GREEN}Masukkan URL target: {RESET}").strip()
        if not url.startswith("http"):
            url = "http://" + url

        print(f"{GREEN}🔎 Memvalidasi URL...{RESET}")
        spinner("  ⏳", 2)

        if not valid_url(url):
            print(f"{GREEN}⛔ URL tidak valid atau tidak dapat dijangkau.{RESET}\n")
            continue

        # Input kedalaman halaman
        while True:
            try:
                depth = int(input(f"{GREEN}Masukkan kedalaman halaman (contoh: 2): {RESET}"))
                if depth <= 0:
                    print(f"{GREEN}Kedalaman harus lebih dari 0!{RESET}")
                    continue
                print(f"{GREEN}⚠️ Semakin Banyak Jumlah Halaman, Semakin Lama Prosesnya!{RESET}")
                break
            except ValueError:
                print(f"{GREEN}Masukkan angka yang valid!{RESET}")

        print(f"{GREEN}✅ URL valid. Memulai crawling hingga kedalaman {depth}...{RESET}")
        spinner("  🔄 Crawling & Ekstraksi...", 3)

        teks = crawl_recursive(url, depth=depth)
        emails = extract_emails(teks)

        print(f"{GREEN}✅ Berhasil mendapatkan {len(emails)} email{RESET}\n")

        if emails:
            print_emails_json(emails)
            file = simpan_hasil(emails)
            stats = email_stats(emails)
            tampilkan_statistik(stats)
            print(f"{GREEN}📁 Hasil disimpan di: {file}{RESET}")
        else:
            print(f"{GREEN}Tidak ada email ditemukan.{RESET}")

        lanjut = input(f"\n{GREEN}Enter untuk cari lagi atau ketik 'e' untuk kembali ke menu utama: {RESET}")
        if lanjut.lower() == 'e':
            break

def run():
    try:
        main()
    except KeyboardInterrupt:
        print(f"\n{GREEN}Dibatalkan oleh pengguna.{RESET}")

if __name__ == "__main__":
    run()
