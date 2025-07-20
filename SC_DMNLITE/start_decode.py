import os
import sys
import time
from itertools import cycle
import threading
sys.path.append(os.path.abspath('alat'))

def typewrite(text, delay=0.0):
    for c in text:
        sys.stdout.write(c)
        sys.stdout.flush()
        time.sleep(delay)
    print()

def clear():
    os.system('clear' if os.name == 'posix' else 'cls')

def loading_animation(text='Memuat menu...'):
    text = cycle(['|', '/', '-', '\\'])
    anim = False

    def run():
        while not stop:
            sys.stdout.write(f'\r{text} {next(anim)}')
            sys.stdout.flush()
            time.sleep(0.1)
    t = threading.Thread(target=run)
    t.start()
    time.sleep(3.0)
    anim = True
    t.join()

def banner():
    clear()
    banner_text = '\n╔═╗╔═╗╔═╗╦═╗╔═╗╔╦╗  ╔╦╗╔═╗╔═╗╔╦╗╔═╗╔╗╔╦╦ ╦╔╦╗\n╚═╗║╣ ║  ╠╦╝║╣  ║    ║║╠═╣║╣ ║║║║ ║║║║║║ ║║║║\n╚═╝╚═╝╚═╝╩╚═╚═╝ ╩   ═╩╝╩ ╩╚═╝╩ ╩╚═╝╝╚╝╩╚═╝╩ ╩\n::=========[ ☠ MENU UTAMA ☠ ]=========::\n'
    typewrite(banner_text)

def menu():
    options = ['[01] SUBFINDER        [16] ENKRIPSI GENERATOR', '[02] NMAP             [17] WORDLIST GENERATOR', '[03] WHOIS            [18] BRUTE FORCE IG', '[04] WHAT WEB         [19] MAC TRACKING', '[05] PING             [20] NO TELP TRACKING', '[06] EMAIL CRAW       [21] BITCOIN MONITORING', '[07] DIRB SCAN        [22] SPAM OTP + CALL + SMS', '[08] WIFI SCAN        [23] AUTO DEFACE WEBSITE', '[09] OSINT USERNAME   [24] SADAP VIA LINK', '[10] DOS ATTACK       [25] BING DORKING', '[11] VULN SCAN        ', '[12] DEVICE INFO      ', '[13] WEBSITE TRACKING ', '[14] IP TRACKING      ', '[15] CHECK HOST NET   ', 'ㅤ', '[00] EXIT', '[99] REPORT BUG', '[77] JOIN SALURAN']
    for line in options:
        typewrite(line, delay=0.0)

def run():
    while True:
        loading_animation()
        banner()
        menu()
        for c in '\n[?] Pilih Mek: ':
            sys.stdout.write(c)
            sys.stdout.flush()
            time.sleep(0.0)
        choice = input().strip()
        try:
            if choice in ['1', '01']:
                from subfinder import run as menu1_run
                menu1_run()
            else:  
                if choice in ['2', '02']:
                    from nmap import run as menu2_run
                    menu2_run()
                else:  
                    if choice in ['3', '03']:
                        from whos import run as menu3_run
                        menu3_run()
                    else:  
                        if choice in ['4', '04']:
                            from whatw import run as menu4_run
                            menu4_run()
                        else:  
                            if choice in ['5', '05']:
                                from pingz import run as menu5_run
                                menu5_run()
                            else:  
                                if choice in ['6', '06']:
                                    from craw import run as menu6_run
                                    menu6_run()
                                else:  
                                    if choice in ['7', '07']:
                                        from dirb import run as menu7_run
                                        menu7_run()
                                    else:  
                                        if choice in ['8', '08']:
                                            from wifi import run as menu8_run
                                            menu8_run()
                                        else:  
                                            if choice in ['9', '09']:
                                                from osint import run as menu9_run
                                                menu9_run()
                                            else:  
                                                if choice == '10':
                                                    from dos import run as menu10_run
                                                    menu10_run()
                                                else:  
                                                    if choice == '11':
                                                        print('\n[93mVIP Users Only😅[0m')
                                                    else:  
                                                        if choice == '12':
                                                            print('\n[93mVIP Users Only😅[0m')
                                                        else:  
                                                            if choice == '13':
                                                                print('\n[93mVIP Users Only😅[0m')
                                                            else:  
                                                                if choice == '14':
                                                                    print('\n[93mVIP Users Only😅[0m')
                                                                else:  
                                                                    if choice == '15':
                                                                        print('\n[93mVIP Users Only😅[0m')
                                                                    else:  
                                                                        if choice == '16':
                                                                            print('\n[93mVIP Users Only😅[0m')
                                                                        else:  
                                                                            if choice == '17':
                                                                                print('\n[93mVIP Users Only😅[0m')
                                                                            else:  
                                                                                if choice == '18':
                                                                                    print('\n[93mVIP Users Only😅[0m')
                                                                                else:  
                                                                                    if choice == '19':
                                                                                        print('\n[93mVIP Users Only😅[0m')
                                                                                    else:  
                                                                                        if choice == '20':
                                                                                            print('\n[93mVIP Users Only😅[0m')
                                                                                        else:  
                                                                                            if choice == '21':
                                                                                                print('\n[93mVIP Users Only😅[0m')
                                                                                            else:  
                                                                                                if choice == '22':
                                                                                                    print('\n[93mVIP Users Only😅[0m')
                                                                                                else:  
                                                                                                    if choice == '23':
                                                                                                        print('\n[93mVIP Users Only😅[0m')
                                                                                                    else:  
                                                                                                        if choice == '24':
                                                                                                            print('\n[93mVIP Users Only😅[0m')
                                                                                                        else:  
                                                                                                            if choice == '25':
                                                                                                                print('\n[93mVIP Users Only😅[0m')
                                                                                                            else:  
                                                                                                                if choice == '77':
                                                                                                                    from saluran import run as menu_saluran_run
                                                                                                                    menu_saluran_run()
                                                                                                                else:  
                                                                                                                    if choice == '99':
                                                                                                                        from whatsapp import run as menu_saya_run
                                                                                                                        menu_saya_run()
                                                                                                                    else:  
                                                                                                                        if choice == '66':
                                                                                                                            from owner import run as menu_owner_run
                                                                                                                            menu_owner_run()
                                                                                                                        else:  
                                                                                                                            if choice in ('0', '00'):
                                                                                                                                typewrite('\n[✓] Keluar dari menu utama...\n', delay=0.05)
                                                                                                                                return
                                                                                                                            typewrite('\n[!] Pilihan tidak dikenal. Ulangi...\n', delay=0.05)
                                                                                                                            time.sleep(1)
    except ModuleNotFoundError as e:
                                                                                                                            typewrite(f'\n[!] Modul tidak ditemukan: {e.name}\n', delay=0.05)
                                                                                                                            input('[ENTER untuk kembali]')
    except Exception as e:
        typewrite(f'\n[!] Terjadi error: {e}\n', delay=0.05)
        input('[ENTER untuk kembali]')
if __name__ == '__main__':
    run()
