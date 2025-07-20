import os
import time
import random
import requests
import socket

GREEN = '\033[92m'
RESET = '\033[0m'

def banner():
    os.system("clear")
    print(f"""{GREEN}
╔═╗╔═╗╔═╗╦═╗╔═╗╔╦╗  ╔╦╗╔═╗╔═╗╔╦╗╔═╗╔╗╔╦╦ ╦╔╦╗
╚═╗║╣ ║  ╠╦╝║╣  ║    ║║╠═╣║╣ ║║║║ ║║║║║║ ║║║║
╚═╝╚═╝╚═╝╩╚═╚═╝ ╩   ═╩╝╩ ╩╚═╝╩ ╩╚═╝╝╚╝╩╚═╝╩ ╩

::=========[ ☠ DIRB ☠ ]=========::
{RESET}""")

def spinner(teks, lama=3):
    print(f"{GREEN}{teks}", end="", flush=True)
    frames = ['|', '/', '-', '\\']
    end_time = time.time() + lama
    idx = 0
    while time.time() < end_time:
        print(f"\b{frames[idx % 4]}", end='', flush=True)
        idx += 1
        time.sleep(0.1)
    print(RESET)

def get_wordlist(mode='fast'):
    if mode == 'fast':
        return [
            "admin", "login", "dashboard", "config", "uploads", "images",
            "js", "css", "api", "backup", "db.php", "wp-admin",
            ".env", "robots.txt", "test", "phpinfo.php", "wp-content", "index.php"
        ]
    else:
        return [
            "admin", "login", "dashboard", "panel", "control", "manager", "webadmin", "administrator",
            "backend", "cp", "cpanel", "adminpanel", "sysadmin", "system", "management",
            "config", "configuration", "settings", "setup", "install", "update", "upgrade",
            "backup", "backups", "bak", "old", "temp", "tmp", "cache", "log", "logs",
            "uploads", "images", "img", "pictures", "photos", "media", "files", "downloads",
            "assets", "static", "public", "shared", "resources", "storage", "data", "database",
            "js", "javascript", "css", "styles", "fonts", "scripts", "include", "includes",
            "lib", "library", "vendor", "modules", "components", "plugins", "themes", "templates",
            "index.php", "index.html", "main.php", "home.php", "config.php", "config.inc.php",
            "db.php", "database.php", "settings.php", "wp-config.php", ".env", ".htaccess",
            "robots.txt", "sitemap.xml", "crossdomain.xml", "phpinfo.php", "test.php",
            "api", "rest", "json", "xml", "soap", "graphql", "oauth", "auth", "authentication",
            "user", "users", "account", "accounts", "profile", "profiles", "member", "members",
            "wp", "wordpress", "wp-admin", "wp-content", "wp-includes", "wp-login.php",
            "joomla", "administrator", "drupal", "magento", "phpmyadmin", "phpMyAdmin",
            "error.log", "access.log", "debug.log", "backup.zip", "backup.sql", "backup.tar",
            "backup.rar", "backup.db", "dump.sql", "backup_2023.zip", "old.zip", "archive.zip",
            "test", "testing", "dev", "development", "stage", "staging", "prod", "production",
            "demo", "sandbox", "secure", "private", "hidden", "secret", "confidential", "internal"
        ]

def dirb_scan(url, mode='fast'):
    wordlist = get_wordlist(mode)
    hasil = []

    spinner(f"🔍 Memulai scanning ({'Cepat' if mode=='fast' else 'Lengkap'})..")

    for word in wordlist:
        target = url.rstrip("/") + "/" + word
        try:
            res = requests.get(target, timeout=10)
            if res.status_code in [200, 301, 302, 403, 401]:
                hasil.append((target, res.status_code, len(res.content)))
        except:
            pass
        time.sleep(0.05 if mode == 'fast' else 0.1)

    print(f"\n{GREEN}📂 Hasil Scan:{RESET}")
    if hasil:
        for h in hasil:
            print(f"{GREEN}- {h[0]} | Status: {h[1]} | Ukuran: {h[2]} bytes{RESET}")
        try:
            os.makedirs("results", exist_ok=True)
            with open("results/hasil_scan.txt", "w") as f:
                for h in hasil:
                    f.write(f"{h[0]} - Status: {h[1]} - Ukuran: {h[2]} bytes\n")
            print(f"{GREEN}✓ Hasil disimpan di file: results/hasil_scan.txt{RESET}")
        except Exception as e:
            print(f"{GREEN}✗ Gagal menyimpan hasil scan: {e}{RESET}")
    else:
        print(f"{GREEN}✗ Tidak ada direktori atau file tersembunyi ditemukan.{RESET}")

def valid_url(url):
    try:
        if not url.startswith(('http://', 'https://')):
            return False
        socket.gethostbyname(url.replace('http://','').replace('https://','').split('/')[0])
        res = requests.get(url, timeout=3)
        return res.status_code < 500
    except:
        return False

def mulai():
    while True:
        banner()
        url = input(f"{GREEN}Masukkan URL target (cth: http://example.com): {RESET}").strip()
        if not valid_url(url):
            print(f"{GREEN}⛔ URL tidak valid atau tidak dapat dijangkau.{RESET}")
            time.sleep(2)
            continue

        mode_input = input(f"{GREEN}Y untuk Scan Cepat atau N untuk Scan Lengkap: {RESET}").strip().lower()
        if mode_input == "y":
            mode_scan = 'fast'
        elif mode_input == "n":
            mode_scan = 'full'
        else:
            print(f"{GREEN}Input tidak dikenali. Default ke Scan Cepat.{RESET}")
            mode_scan = 'fast'

        spinner("⏳ Wait Ya Cui....")
        dirb_scan(url, mode_scan)

        lagi = input(f"\n{GREEN}Ingin scan lagi? (y/n): {RESET}").lower()
        if lagi != "y":
            print(f"{GREEN}........!{RESET}")
            break

def run():
    mulai()

if __name__ == "__main__":
    run()
