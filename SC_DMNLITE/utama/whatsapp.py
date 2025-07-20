import os
import platform
import time

# Ganti link WhatsApp di sini
link_whatsapp = "https://wa.me/6285691909415?text=Halo%20Bang.%20[Pendapat+Tentang+Toolsnya]"

def buka_link(link):
    print(f"📲 Menuju Chat Pribadi Developer Daemonium")
    time.sleep(1)

    sistem = platform.system()
    
    if "termux" in os.getenv("PREFIX", "").lower():
        os.system(f"termux-open-url {link}")
    elif sistem == "Linux":
        os.system(f"xdg-open {link}")
    elif sistem == "Windows":
        os.system(f"start {link}")
    elif sistem == "Darwin":
        os.system(f"open {link}")
    else:
        try:
            import webbrowser
            webbrowser.open(link)
        except:
            print("❌ Gagal membuka link.")

def run():
    buka_link(link_whatsapp)

if __name__ == "__main__":
    run()
