import os
import sys
from datetime import datetime

def install_requirements():
    try:
        import whois
        if not hasattr(whois, 'whois'):
            raise ImportError
    except:
        print("\033[92m[!] Tungguin aja cui ini lagi proses penginstalan bahan yang dibutuhkan...\033[0m")
        os.system("pip uninstall -y whois")
        os.system("pip install python-whois")

    if sys.platform.startswith("linux") or sys.platform == "darwin":
        if os.system("command -v pkg > /dev/null 2>&1") == 0:
            os.system("pkg install python -y > /dev/null 2>&1")

def banner():
    os.system("clear" if os.name == "posix" else "cls")
    print("\033[92m")
    print(r"""
╔═╗╔═╗╔═╗╦═╗╔═╗╔╦╗  ╔╦╗╔═╗╔═╗╔╦╗╔═╗╔╗╔╦╦ ╦╔╦╗
╚═╗║╣ ║  ╠╦╝║╣  ║    ║║╠═╣║╣ ║║║║ ║║║║║║ ║║║║
╚═╝╚═╝╚═╝╩╚═╚═╝ ╩   ═╩╝╩ ╩╚═╝╩ ╩╚═╝╝╚╝╩╚═╝╩ ╩

::=========[ ☠ WHOIS ☠ ]=========::
    """)
def format_value(value):
    if not value or value == 'None':
        return None
    elif isinstance(value, list):
        cleaned = [str(i).strip() for i in value if i]
        return ', '.join(cleaned)
    elif isinstance(value, datetime):
        return value.strftime('%Y-%m-%d %H:%M:%S')
    else:
        return str(value).strip()

def display_paragraph(data):
    lines = []
    for key, value in data.items():
        formatted = format_value(value)
        if formatted:
            lines.append(f"{key.replace('_', ' ').capitalize()}: {formatted}")
    paragraph = "\n\n".join(lines)
    print(f"\033[92m{paragraph}\033[0m")

def main():
    try:
        import whois
        banner()
        domain = input("\033[92m[?] Masukkan nama domain (contoh: google.com): \033[0m")
        print("\n\033[92m[+] Mengambil informasi WHOIS...\033[0m\n")
        data = whois.whois(domain)
        display_paragraph(data)

    except Exception as e:
        print(f"\n\033[91m[!] Terjadi kesalahan: {e}\033[0m")

    input("\n\033[92m[⇲] Tekan ENTER untuk kembali...\033[0m")

def run():
    install_requirements()
    main()

if __name__ == "__main__":
    run()
              
