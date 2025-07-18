import os
import time
from datetime import datetime
from rich.console import Console
from rich.text import Text
from rich.panel import Panel
from fake_useragent import UserAgent
import instaloader

console = Console()

def rua():
    ua = UserAgent()
    return ua.random

def GC():
    import requests
    url = 'https://www.instafollowerspro.com/api/web/v1.0/daily-free-coins.php'
    headers = {
        'authorization': 'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOjUyOTIwNzIsImlhdCI6MTc0NzkzNjAzMSwiaXNzIjoiaW5zdGFmb2xsb3dlcnNwcm8uY29tIiwibmJmIjoxNzQ3OTM2MDMxLCJleHAiOjE3NTA1NjQwMzEsImVtYWlsIjoiZGl6Zmx5emVAZ21haWwuY29tIiwiY3NyZnRva2VuIjoiNDkzMGFkODQ2ZTMyOWEyYjcxNGRkZGMyNTcxOTIxZmQiLCJSb2xlIjoiVXNlciIsImZ1bGxOYW1lIjoiVW5rbm93biBOYW1lIn0.tcUxF_3NiYZcwm9yT5ceO550qCxceFFkk3P6grgr5mxb7p3fRn6YdzGQ3pDo3bf4yNnq-QDxjD9wBREv0FlMkQ',
        'content-type': 'application/json',
        'user-agent': rua()
    }
    data = {"account_id": 5292072, "method": "get"}
    r = requests.post(url, headers=headers, json=data)
    return r.json().get("data", {}).get("total_coins", 0)

def get_info_insta(username):
    L = instaloader.Instaloader()
    try:
        profile = instaloader.Profile.from_username(L.context, username)
        followers = profile.followers
        following = profile.followees
        posts = profile.mediacount
        bio = profile.biography
        is_private = "Private" if profile.is_private else "Public"
        is_verified = "Terverifikasi" if profile.is_verified else "Tidak Terverifikasi"
        return followers, following, posts, bio, is_private, is_verified
    except:
        return 0, 0, 0, "-", "-", "-"

def logo():
    os.system("clear")
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

def main():
    logo()
    username = console.input("[bold green]╭─── [bold white][ [bold cyan]INPUT TARGET [bold white]]\n[bold green]╰> [bold yellow]USERNAME : [bold white]@ ")
    coins = GC()
    followers, following, posts, bio, is_private, is_verified = get_info_insta(username)
    jam = datetime.now().strftime("%H:%M:%S")
    time.sleep(2)
    console.print(f"""[bold white]
[bold cyan]╭───> [bold white]INFORMATION [bold cyan]<───╮
[bold white]+ COIN : [bold green]{coins}
[bold white]+ USER : [bold green]@ {username}
[bold white]+ TIME : [bold green]{jam}
[bold white]+ SEND : [bold green]Followers To @ {username}
[bold white]+ BOTS : [bold green]Indonesia
[bold white]+ FLWR : [bold green]{followers}
[bold white]+ IKTI : [bold green]{following}
[bold white]+ STAT : [bold red]Tidak cukup coin
[bold white]+ LINK : [bold green]https://www.instagram.com/@{username}
[bold white]+ POST : [bold green]{posts} Postingan
[bold white]+ DESK : [bold green]{bio}
[bold white]+ AKUN : [bold green]{is_private}
[bold white]+ VRIF : [bold green]{is_verified}
[bold white]+ INFO : [bold red]Kesalahan saat mengirim followers
[bold cyan]╰───> [bold white]THANKS GUYS [bold cyan]<───╯
""")

if __name__ == "__main__":
    main()
