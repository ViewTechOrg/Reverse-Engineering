import os
import time
import sys

def clear():
    os.system('clear')

def saluran():
    clear()
    print("[\033[1;31m!\033[0m]\033[1;33m Follow Chanel Whatsapp Arby-Hex\033[0m")
    time.sleep(2)

    url = "https://whatsapp.com/channel/0029VbBLBZ80lwgrRDEnyV0v"

    if "termux" in os.getenv("PREFIX", "").lower():
        os.system(f"termux-open-url '{url}'")
    elif platform.system() == "Linux":
        os.system(f"xdg-open '{url}'")
    elif platform.system() == "Windows":
        os.system(f"start {url}")
    elif platform.system() == "Darwin":
        os.system(f"open {url}")
    else:
        import webbrowser
        webbrowser.open(url)

def report_bug():
    print("[\033[1;31m!\033[0m]\033[1;33m MENUJU TELEGRAM ARBY-HEX\033[0m")
    time.sleep(2)

    url = "https://t.me/ArbyHex"

    if "termux" in os.getenv("PREFIX", "").lower():
        os.system(f"termux-open-url '{url}'")
    elif platform.system() == "Linux":
        os.system(f"xdg-open '{url}'")
    elif platform.system() == "Windows":
        os.system(f"start {url}")
    elif platform.system() == "Darwin":
        os.system(f"open {url}")
    else:
        import webbrowser
        webbrowser.open(url)

def final_proses():
    print("""\033[1:31m
╭─────────────────────╮
│╔═╗╦ ╦╔═╗╔═╗╔═╗╔═╗╔╦╗│
│╚═╗║ ║║  ║  ║╣ ║╣  ║║│
│╚═╝╚═╝╚═╝╚═╝╚═╝╚═╝═╩╝│\033[0m
│\033[1;32m  Code By Arby-Hex\033[0m   │
╰─────────────────────╯

[\033[1;31m!\033[0m]\033[1;33m JALANKAN COMMAND\033[0m \033[1;32msource ~/.bashrc\033[0m
""")

def hacker_theme():
    print("[\033[1;31m01\033[0m]\033[1;33m HACKER \033[0m")
    print("[\033[1;31m02\033[0m]\033[1;33m FSOCIETY\033[0m")
    print("[\033[1;31m03\033[0m]\033[1;33m ANONYMOUS\033[0m")
    print("[\033[1;31m04\033[0m]\033[1;33m CAT HACKER\033[0m")
    print("[\033[1;31m05\033[0m]\033[1;33m ARAB HACKER\033[0m")
    print("")
    print("[\033[1;31m00\033[0m]\033[1;33m EXIT MENU HACKER THEME\033[0m")

def anime_theme():
    print("[\033[1;31m01\033[0m]\033[1;33m GOJO CUTE\033[0m")
    print("[\033[1;31m02\033[0m]\033[1;33m ONE PIECE\033[0m")
    print("[\033[1;31m03\033[0m]\033[1;33m KEN KANEKI\033[0m")
    print("[\033[1;31m04\033[0m]\033[1;33m GOJO V2\033[0m")
    print("[\033[1;31m05\033[0m]\033[1;33m AMATERASU\033[0m")
    print("")
    print("[\033[1;31m00\033[0m]\033[1;33m EXIT MENU ANIME THEME\033[0m")
def grafiti_theme():
    print("[\033[1;31m01\033[0m]\033[1;33m BLACKHAT\033[0m")
    print("[\033[1;31m02\033[0m]\033[1;33m GHOST\033[0m")
    print("[\033[1;31m03\033[0m]\033[1;33m HACKERS\033[0m")
    print("[\033[1;31m04\033[0m]\033[1;33m RED SKULL\033[0m")
    print("[\033[1;31m05\033[0m]\033[1;33m XCRYPTER\033[0m")
    print("")
    print("[\033[1;31m00\033[0m]\033[1;33m EXIT MENU GRAFITI THEME\033[0m")

def banner():
    time.sleep(1)
    clear()
    print("╭─────────────────────────────────────────────╮")
    print("│ \033[1;31m•\033[1;33m•\033[1;32m•\033[0m                                         │")
    print("│    \033[1;31m╔╦╗╔═╗╦═╗╔╦╗╦ ╦═╗ ╦  ╔╦╗╦ ╦╔═╗╔╦╗╔═╗\033[0m     │")
    print("│    \033[1;31m ║ ║╣ ╠╦╝║║║║ ║╔╩╦╝   ║ ╠═╣║╣ ║║║║╣ \033[0m     │")
    print("│    \033[1;31m ╩ ╚═╝╩╚═╩ ╩╚═╝╩ ╚═   ╩ ╩ ╩╚═╝╩ ╩╚═╝\033[0m     │")
    print("│           [\033[1;31m!\033[0m]\033[1;33m Code By Arby-Hex\033[0m              │")
    print("│                                             │")
    print("╰─────────────────────────────────────────────╯")
    print("\033[0m")

def banner_hacker():
    clear()
    print("╭─────────────────────────────────────────────╮")
    print("│ \033[1;31m•\033[1;33m•\033[1;32m•\033[0m                                         │")
    print("│    \033[1;31m╔╦╗╔═╗╦═╗╔╦╗╦ ╦═╗ ╦  ╔╦╗╦ ╦╔═╗╔╦╗╔═╗\033[0m     │")
    print("│    \033[1;31m ║ ║╣ ╠╦╝║║║║ ║╔╩╦╝   ║ ╠═╣║╣ ║║║║╣ \033[0m     │")
    print("│    \033[1;31m ╩ ╚═╝╩╚═╩ ╩╚═╝╩ ╚═   ╩ ╩ ╩╚═╝╩ ╩╚═╝\033[0m     │")
    print("│          [\033[1;31m!\033[0m]\033[1;33m MENU TEMA HACKING\033[0m              │")
    print("│                                             │")
    print("╰─────────────────────────────────────────────╯")
    print("\033[0m")

def banner_anime():
    clear()
    print("╭─────────────────────────────────────────────╮")
    print("│ \033[1;31m•\033[1;33m•\033[1;32m•\033[0m                                         │")
    print("│    \033[1;31m╔╦╗╔═╗╦═╗╔╦╗╦ ╦═╗ ╦  ╔╦╗╦ ╦╔═╗╔╦╗╔═╗\033[0m     │")
    print("│    \033[1;31m ║ ║╣ ╠╦╝║║║║ ║╔╩╦╝   ║ ╠═╣║╣ ║║║║╣ \033[0m     │")
    print("│    \033[1;31m ╩ ╚═╝╩╚═╩ ╩╚═╝╩ ╚═   ╩ ╩ ╩╚═╝╩ ╩╚═╝\033[0m     │")
    print("│          [\033[1;31m!\033[0m]\033[1;33m MENU TEMA ANIME\033[0m                │")
    print("│                                             │")
    print("╰─────────────────────────────────────────────╯")
    print("\033[0m")

def banner_grafiti():
    clear()
    print("╭─────────────────────────────────────────────╮")
    print("│ \033[1;31m•\033[1;33m•\033[1;32m•\033[0m                                         │")
    print("│    \033[1;31m╔╦╗╔═╗╦═╗╔╦╗╦ ╦═╗ ╦  ╔╦╗╦ ╦╔═╗╔╦╗╔═╗\033[0m     │")
    print("│    \033[1;31m ║ ║╣ ╠╦╝║║║║ ║╔╩╦╝   ║ ╠═╣║╣ ║║║║╣ \033[0m     │")
    print("│    \033[1;31m ╩ ╚═╝╩╚═╩ ╩╚═╝╩ ╚═   ╩ ╩ ╩╚═╝╩ ╩╚═╝\033[0m     │")
    print("│          [\033[1;31m!\033[0m]\033[1;33m MENU TEMA GRAFITI\033[0m              │")
    print("│                                             │")
    print("╰─────────────────────────────────────────────╯")
    print("\033[0m")

def run_hacker():
    banner_hacker()
    hacker_theme()

    pilihan = input("\n\033[1;31m>> ")

    if pilihan == "01" or pilihan == "1":
        os.system("bash Data/HACKER/hacker1.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "02" or pilihan == "2":
        os.system("bash Data/HACKER/fsociety.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "03" or pilihan == "3":
        os.system("bash Data/HACKER/anonymous.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "04" or pilihan == "4":
        os.system("bash Data/HACKER/cathacker.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "05" or pilihan == "5":
        os.system("bash Data/HACKER/hackerarab.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "00":
        print("\n\033[1;31m[!]\033[0m KELUAR...\033[1;31m!\033[0m")
        time.sleep(1)
        return
    else:
        print("PILIH YANG BENER\n\033[1;31m!\033[0m")
        time.sleep(1)

    input("\n\033[1;32mTEKAN ENTER UNTUK KEMBALI KE MENU\033[0m...")
    run_hacker()

def run_grafiti():
    banner_grafiti()
    grafiti_theme()

    pilihan = input("\n\033[1;31m>> ")

    if pilihan == "01" or pilihan == "1":
        os.system("bash Data/GRAFITI/blackhat.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "02" or pilihan == "2":
        os.system("bash Data/GRAFITI/ghost.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "03" or pilihan == "3":
        os.system("bash Data/GRAFITI/hacker.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "04" or pilihan == "4":
        os.system("bash Data/GRAFITI/redskull.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "05" or pilihan == "5":
        os.system("bash Data/GRAFITI/xcrypter.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "00":
        print("\n\033[1;31m[!]\033[0m KELUAR...\033[1;31m!\033[0m")
        time.sleep(1)
        return
    else:
        print("PILIH YANG BENER\n\033[1;31m!\033[0m")
        time.sleep(1)

    input("\n\033[1;32mTEKAN ENTER UNTUK KEMBALI KE MENU\033[0m...")
    run_grafiti()

def run_anime():
    banner_anime()
    anime_theme()

    pilihan = input("\n\033[1;31m>> ")

    if pilihan == "01" or pilihan == "1":
        os.system("bash Data/ANIME/gojo.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "02" or pilihan == "2":
        os.system("bash Data/ANIME/onepiece.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "03" or pilihan == "3":
        os.system("bash Data/ANIME/kenkaneki.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "04" or pilihan == "4":
        os.system("bash Data/ANIME/gojov2.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "05" or pilihan == "5":
        os.system("bash Data/ANIME/amaterasu.sh")
        clear()
        final_proses()
        exit()
    elif pilihan == "00":
        print("\n\033[1;31m[!]\033[0m KELUAR...\033[1;31m!\033[0m")
        time.sleep(1)
        return
    else:
        print("PILIH YANG BENER\n\033[1;31m!\033[0m")
        time.sleep(1)

    input("\n\033[1;32mTEKAN ENTER UNTUK KEMBALI KE MENU\033[0m...")
    run_anime()

def run():
    banner()
    print("[\033[1;31m01\033[0m]\033[1;33m HACKER THEME\033[0m")
    print("[\033[1;31m02\033[0m]\033[1;33m ANIME THEME\033[0m")
    print("[\033[1;31m03\033[0m]\033[1;33m GRAFITI THEME\033[0m")
    print("[\033[1;31m04\033[0m]\033[1;33m REPORT BUG\033[0m")
    print("[\033[1;31m05\033[0m]\033[1;33m KELUAR\033[0m")

    pilihan = input("\n\033[1;31m>> ")

    if pilihan == "01" or pilihan == "1":
        run_hacker()
    elif pilihan == "02" or pilihan == "2":
        run_anime()
    elif pilihan == "03" or pilihan == "3":
        run_grafiti()
    elif pilihan == "04" or pilihan == "4":
        report_bug()
    elif pilihan == "05" or pilihan == "5":
        print("\n\033[1;31m[!]\033[0m KELUAR...\033[1;31m!\033[0m")
        time.sleep(1)
        exit()
    else:
        print("PILIH YANG BENER\n\033[1;31m!\033[0m")
        time.sleep(1)

    input("\n\033[1;32mTEKAN ENTER UNTUK KEMBALI KE MENU\033[0m...")
    run()

def run_utama():
    saluran()
    banner()
    print("[\033[1;31m01\033[0m]\033[1;33m HACKER THEME\033[0m")
    print("[\033[1;31m02\033[0m]\033[1;33m ANIME THEME\033[0m")
    print("[\033[1;31m03\033[0m]\033[1;33m GRAFITI THEME\033[0m")
    print("[\033[1;31m04\033[0m]\033[1;33m REPORT BUG\033[0m")
    print("[\033[1;31m05\033[0m]\033[1;33m KELUAR\033[0m")

    pilihan = input("\n\033[1;31m>> ")

    if pilihan == "01" or pilihan == "1":
        run_hacker()
    elif pilihan == "02" or pilihan == "2":
        run_anime()
    elif pilihan == "03" or pilihan == "3":
        run_grafiti()
    elif pilihan == "04" or pilihan == "4":
        report_bug()
    elif pilihan == "05" or pilihan == "5":
        print("\n\033[1;31m[!]\033[0m KELUAR...\033[1;31m!\033[0m")
        time.sleep(1)
        exit()
    else:
        print("PILIH YANG BENER\n\033[1;31m!\033[0m")
        time.sleep(1)

    input("\n\033[1;32mTEKAN ENTER UNTUK KEMBALI KE MENU\033[0m...")
    run()

if __name__ == "__main__":
    run_utama()

