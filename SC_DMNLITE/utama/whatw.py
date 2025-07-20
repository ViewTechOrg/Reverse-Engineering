import os
import requests
from bs4 import BeautifulSoup

H = '\033[92m'
R = '\033[0m'

banner = f"""{H}
╔═╗╔═╗╔═╗╦═╗╔═╗╔╦╗  ╔╦╗╔═╗╔═╗╔╦╗╔═╗╔╗╔╦╦ ╦╔╦╗
╚═╗║╣ ║  ╠╦╝║╣  ║    ║║╠═╣║╣ ║║║║ ║║║║║║ ║║║║
╚═╝╚═╝╚═╝╩╚═╚═╝ ╩   ═╩╝╩ ╩╚═╝╩ ╩╚═╝╝╚╝╩╚═╝╩ ╩

::=========[ ☠ WHAT WEB? ☠ ]=========::
{R}"""

def auto_install():
    try:
        import requests, bs4
    except:
        print(f"{H}[•] Menginstal module...{R}")
        os.system("pip install requests bs4")

def scan_website():
    os.system("clear")
    print(banner)
    target = input(f"{H}[?] Masukkan URL target (contoh: https://example.com): {R}").strip().replace(" ", "")
    if not target.startswith("http"):
        target = "http://" + target

    try:
        res = requests.get(target, timeout=6)
        html = res.text.lower()
        headers = res.headers
    except Exception as e:
        print(f"{H}[!] Gagal mengakses target:{R} {e}")
        input(f"{H}[↩] Tekan Enter untuk kembali...{R}")
        return

    print(f"\n{H}[✓] TARGET: {target}{R}")
    print(f"{H}[*] Status: {res.status_code}")
    print(f"[*] Server: {headers.get('Server', '-')}")
    print(f"[*] X-Powered-By: {headers.get('X-Powered-By', '-')}")
    print(f"[*] Content-Type: {headers.get('Content-Type', '-')}{R}")

    # Cek meta generator
    soup = BeautifulSoup(html, 'html.parser')
    generator = soup.find('meta', attrs={"name": "generator"})
    if generator and generator.get('content'):
        print(f"{H}[*] CMS (meta generator): {generator['content']}{R}")

    # Cek direktori & file khas
    paths = {
        "WordPress": "/wp-content/",
        "Joomla Admin": "/administrator/",
        "Drupal Core": "/core/",
        "Readme": "/readme.html",
        "License": "/license.txt",
        "ChangeLog": "/CHANGELOG.txt",
        "Admin Panel": "/admin/"
    }
    found = []
    for name, path in paths.items():
        try:
            r = requests.get(target + path, timeout=4)
            if r.status_code == 200:
                found.append(name)
        except:
            continue

    if found:
        print(f"\n{H}[✓] Jejak CMS / File Ditemukan:{R}")
        for f in found:
            print(f"{H} - {f}{R}")
    else:
        print(f"{H}[-] Tidak ditemukan file khas CMS.{R}")

    # Cek keyword dalam HTML
    keywords = {
        "Laravel": "laravel",
        "CodeIgniter": "codeigniter",
        "Drupal": "drupal",
        "Joomla": "joomla"
    }
    hits = []
    for key, value in keywords.items():
        if value in html:
            hits.append(key)

    if hits:
        print(f"\n{H}[✓] Framework Terdeteksi (dari HTML):{R}")
        for h in hits:
            print(f"{H} - {h}{R}")

    input(f"\n{H}[↩] Tekan Enter untuk kembali...{R}")

def run():
    auto_install()
    scan_website()

if __name__ == "__main__":
    run()
