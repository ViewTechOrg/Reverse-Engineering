import os
import time
import requests
from rich.console import Console
from rich.panel import Panel
from rich.text import Text
from fake_useragent import UserAgent

console = Console()

def rua():
    ua = UserAgent()
    return ua.random
    
def GC():
    url = 'https://www.instafollowerspro.com/api/web/v1.0/daily-free-coins.php'
    headers = {
        'authority': 'www.instafollowerspro.com',
        'accept': 'application/json, text/plain, */*',
        'accept-language': 'id-ID,id;q=0.9',
        'authorization': 'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOjUyOTIwNzIsImlhdCI6MTc0NzkzNjAzMSwiaXNzIjoiaW5zdGFmb2xsb3dlcnNwcm8uY29tIiwibmJmIjoxNzQ3OTM2MDMxLCJleHAiOjE3NTA1NjQwMzEsImVtYWlsIjoiZGl6Zmx5emVAZ21haWwuY29tIiwiY3NyZnRva2VuIjoiNDkzMGFkODQ2ZTMyOWEyYjcxNGRkZGMyNTcxOTIxZmQiLCJSb2xlIjoiVXNlciIsImZ1bGxOYW1lIjoiVW5rbm93biBOYW1lIn0.tcUxF_3NiYZcwm9yT5ceO550qCxceFFkk3P6grgr5mxb7p3fRn6YdzGQ3pDo3bf4yNnq-QDxjD9wBREv0FlMkQ',
        'content-type': 'application/json',
        'cookie': 'PHPSESSID=m0ajbni11947t2ne334mnabao5;',
        'origin': 'https://app.instafollowerspro.com',
        'referer': 'https://app.instafollowerspro.com/',
        'user-agent': rua(),
    }
    data = {"account_id": 5292072, "method": "get"}
    r = requests.post(url, headers=headers, json=data)
    return r.json().get("data", {}).get("total_coins", 0)

coins = GC()

def main():
    os.system("clear")
    os.system("xdg-open https://youtube.com/@dizflyze999?si=7MvFHwU1u76ZiFaV")
    time.sleep(5)
    console.print("""[bold white]
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣶⣾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⣶⣦⣤⣀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀.⣴⣶⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⣧⣼⠀⠀⠀⠀⣀⣴⣿⣿⣿⣿⣿⣿⣷⣦⣄⡀
⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⣿⣿⣿⣿⣿⣷⣦⣀⣾⣿⣿⣷⣀⣤⣿⣯⣿⣿⣿⣿⠟⠋⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⠿⠋⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀╭> [bold yellow]INSTAGRAM TOOLS FREE FOLOWER
⠀⠀⠀⠀⠀[bold white]╰─────> [bold green]DEVELOP [bold white]: [bold green]DIZFLYZE [bold white]<─────╮
    ⠀⠀⠀⠀⠀    [bold green]YOUTUBE [bold white]: [bold green]99DIZFLYZE999 [bold white]<╯
    """)

    panel_text = Text(f"YOUR COIN {coins} PLEASE CLAIM COIN TO UP FOLOWER", style="bold green")
    console.print(Panel(panel_text, title="INDOFOL PREMIUM", expand=False))

    input("╰────> ENTER TO CLAIM!")
    print()
    
def menu():
    console.print(f"[bold cyan]0500 [bold white]𝙲𝙾𝙸𝙽 IDR [bold green]15.000 [bold white]| [bold cyan]1000 [bold white]𝙲𝙾𝙸𝙽 IDR [bold green]25.000\n[bold cyan]1500 [bold white]𝙲𝙾𝙸𝙽 IDR [bold green]40.000 [bold white]| [bold cyan]2000 [bold white]𝙲𝙾𝙸𝙽 IDR [bold green]50.000\n[bold cyan]2500 [bold white]𝙲𝙾𝙸𝙽 IDR [bold green]65.000 [bold white]| [bold cyan]3000 [bold white]𝙲𝙾𝙸𝙽 IDR [bold green]75.000\n[bold cyan]4000 [bold white]𝙲𝙾𝙸𝙽 IDR [bold green]86.000[bold white] | [bold cyan]5000 [bold white]𝙲𝙾𝙸𝙽 IDR [bold green]99.000\n")
    time.sleep(10)
    claim_coin() 

def claim_coin():
    url = 'https://www.instafollowerspro.com/api/web/v1.0/daily-free-coins.php'
    headers = {
        'authorization': 'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOjUyOTIwNzIsImlhdCI6MTc0NzkzNjAzMSwiaXNzIjoiaW5zdGFmb2xsb3dlcnNwcm8uY29tIiwibmJmIjoxNzQ3OTM2MDMxLCJleHAiOjE3NTA1NjQwMzEsImVtYWlsIjoiZGl6Zmx5emVAZ21haWwuY29tIiwiY3NyZnRva2VuIjoiNDkzMGFkODQ2ZTMyOWEyYjcxNGRkZGMyNTcxOTIxZmQiLCJSb2xlIjoiVXNlciIsImZ1bGxOYW1lIjoiVW5rbm93biBOYW1lIn0.tcUxF_3NiYZcwm9yT5ceO550qCxceFFkk3P6grgr5mxb7p3fRn6YdzGQ3pDo3bf4yNnq-QDxjD9wBREv0FlMkQ',
        'content-type': 'application/json',
    }
    data = {"account_id": 5292072, "method": "claim"}
    res = requests.post(url, headers=headers, json=data)
    result = res.json()
    if result.get("status") == "success":
        console.print("\n[bold green]╭─── [bold white][ [bold yellow]INFO CLAIM [bold white]]\n[bold green]╰──> [bold cyan]+ [bold white]CLAIM SUCCESS")
    else:
        console.print("[bold green]╭─── [bold white][ [bold yellow]INFO CLAIM [bold white]]\n[bold green]╰──> [bold cyan]+ [bold red]LIMIT CLAIM : [white]Tidak ada coin gratis saat ini.")
        time.sleep(5)
        os.system("python3 proxy.py")
        
if __name__ == "__main__":
    main()
    menu()
