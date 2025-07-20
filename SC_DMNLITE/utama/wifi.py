import os
import subprocess
import time
import shutil
import json
import math
from datetime import datetime
from rich.console import Console
from rich.progress import track
from rich import print

console = Console()
CONFIG_PATH = "config.json"

def auto_install():
    pkgs = ['termux-api']
    for pkg in pkgs:
        if shutil.which(pkg) is None:
            os.system(f"pkg install {pkg} -y > /dev/null 2>&1")
    try:
        import rich
    except ImportError:
        os.system("pip install rich")

def waktu_scan():
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")

def get_wifi_info():
    try:
        result = subprocess.check_output(['termux-wifi-scaninfo']).decode()
        data = json.loads(result)
        if isinstance(data, list):
            return data
        else:
            return []
    except:
        return []

def estimasi_jarak(freq, level):
    try:
        exp = (27.55 - (20 * math.log10(freq)) + abs(level)) / 20.0
        return round(pow(10, exp), 1)
    except:
        return "?"

def keamanan_keterangan(cap):
    if "WPA2" in cap or "WPA" in cap:
        return "WPA/WPA2"
    elif "WEP" in cap:
        return "WEP"
    elif "ESS" in cap:
        return "Open"
    return "Tidak diketahui"

def deteksi_channel(freq):
    if 2412 <= freq <= 2484:
        return "2.4GHz"
    elif 5170 <= freq <= 5825:
        return "5GHz"
    return "?"

def loading_bar():
    console.print("\n[green]⏳ Memindai jaringan WiFi...[/green]")
    for _ in track(range(30), description="[green]Scanning[/green]"):
        time.sleep(0.02)

def banner():
    os.system("clear")
    ascii_art = r"""
╔═╗╔═╗╔═╗╦═╗╔═╗╔╦╗  ╔╦╗╔═╗╔═╗╔╦╗╔═╗╔╗╔╦╦ ╦╔╦╗
╚═╗║╣ ║  ╠╦╝║╣  ║    ║║╠═╣║╣ ║║║║ ║║║║║║ ║║║║
╚═╝╚═╝╚═╝╩╚═╚═╝ ╩   ═╩╝╩ ╩╚═╝╩ ╩╚═╝╝╚╝╩╚═╝╩ ╩

::=========[ ☠ WIFI SCAN ☠ ]=========::
    """
    print(f"[green]{ascii_art}[/green]")
def simpan_config():
    config = {"last_scan": waktu_scan()}
    with open(CONFIG_PATH, "w") as f:
        json.dump(config, f)

def export_data(wifi_list):
    waktu = datetime.now().strftime("%Y%m%d_%H%M%S")
    json_file = f"scan_report_{waktu}.json"
    with open(json_file, "w") as js:
        json.dump(wifi_list, js, indent=2)
    console.print(f"\n[green]✅ Data berhasil diekspor ke:[/green] [bold]{json_file}[/bold]")

def wifi_scanx():
    auto_install()
    simpan_config()

    while True:
        banner()
        console.print(f"[green]Waktu Scan : {waktu_scan()}[/green]")
        loading_bar()

        wifi_raw = get_wifi_info()

        if not wifi_raw:
            print("[green]❌ Tidak ada jaringan terdeteksi.[/green]")
        else:
            hasil = []
            for i, wifi in enumerate(wifi_raw, 1):
                freq = wifi.get("frequency", 0)
                level = wifi.get("level", -999)
                data = {
                    "No": i,
                    "SSID": wifi.get("ssid", "<Hidden>"),
                    "BSSID": wifi.get("bssid", "❔"),
                    "Frequency (MHz)": freq,
                    "CenterFreq0": wifi.get("centerFreq0", "-"),
                    "CenterFreq1": wifi.get("centerFreq1", "-"),
                    "Channel Band": deteksi_channel(freq),
                    "Signal Level (dBm)": level,
                    "Channel Width": wifi.get("channelWidth", "-"),
                    "Timestamp": wifi.get("timestamp", "-"),
                    "Keamanan": keamanan_keterangan(wifi.get("capabilities", "")),
                    "Capabilities": wifi.get("capabilities", ""),
                    "Estimasi Jarak (m)": estimasi_jarak(freq, level),
                    "Venue": wifi.get("venueName", "-"),
                    "Operator": wifi.get("operatorFriendlyName", "-"),
                    "RTT Responder": wifi.get("is80211mcResponder", False),
                    "Password": "❌ Tidak tersedia (Android tidak menyimpan)"
                }
                hasil.append(data)

            print(f"[green]{json.dumps(hasil, indent=2)}[/green]")

        console.print("[green]\n➤ Pilihan: [E]xport, [R]escan, [Q]uit[/green]")
        inp = input(">> ").lower()
        if inp == "e":
            export_data(hasil)
        elif inp == "r":
            continue
        elif inp == "q":
            break
        else:
            break

def run():
    wifi_scanx()

if __name__ == "__main__":
    run()
