# osint_simplified.py
import os
import sys
import time
import requests
import json
from rich.console import Console
from rich import print as rprint
from rich.progress import track

try:
    from colorama import Fore, Style
except ImportError:
    os.system("pip install requests rich colorama")

from colorama import Fore, Style

console = Console()

SITES = {
    "GitHub": "https://github.com/{}",
    "Twitter": "https://twitter.com/{}",
    "Instagram": "https://www.instagram.com/{}",
    "TikTok": "https://www.tiktok.com/@{}",
    "Reddit": "https://www.reddit.com/user/{}",
    "Pinterest": "https://www.pinterest.com/{}",
    "Steam": "https://steamcommunity.com/id/{}",
    "Medium": "https://medium.com/@{}",
    "Replit": "https://replit.com/@{}",
    "CodePen": "https://codepen.io/{}",
    "Hackerrank": "https://www.hackerrank.com/{}",
    "Dev.to": "https://dev.to/{}",
    "Keybase": "https://keybase.io/{}",
    "GitLab": "https://gitlab.com/{}",
    "Blogger": "https://{}.blogspot.com",
    "Dribbble": "https://dribbble.com/{}",
    "Behance": "https://www.behance.net/{}",
    "Kaggle": "https://www.kaggle.com/{}",
    "Last.fm": "https://www.last.fm/user/{}",
    "500px": "https://500px.com/{}",
    "Spotify": "https://open.spotify.com/user/{}",
    "SoundCloud": "https://soundcloud.com/{}",
    "RiotGames": "https://na.op.gg/summoner/userName={}",
    "BuyMeACoffee": "https://www.buymeacoffee.com/{}",
    "TripAdvisor": "https://www.tripadvisor.com/Profile/{}",
    "Fiverr": "https://www.fiverr.com/{}",
    "Freelancer": "https://www.freelancer.com/u/{}",
    "Wattpad": "https://www.wattpad.com/user/{}",
    "Patreon": "https://www.patreon.com/{}",
    "Sketchfab": "https://sketchfab.com/{}",
    "DeviantArt": "https://www.deviantart.com/{}",
    "Gravatar": "https://en.gravatar.com/{}",
    "ProductHunt": "https://www.producthunt.com/@{}",
    "Flipboard": "https://flipboard.com/@{}",
    "About.me": "https://about.me/{}",
    "Disqus": "https://disqus.com/by/{}/",
    "Vimeo": "https://vimeo.com/{}",
    "Trello": "https://trello.com/{}",
    "MyAnimeList": "https://myanimelist.net/profile/{}",
    "Bandcamp": "https://{}.bandcamp.com",
    "Roblox": "https://www.roblox.com/user.aspx?username={}",
    "Snapchat": "https://www.snapchat.com/add/{}",
    "Quora": "https://www.quora.com/profile/{}",
    "Linktree": "https://linktr.ee/{}",
    "Giphy": "https://giphy.com/{}/",
    "Bitbucket": "https://bitbucket.org/{}/",
    "OpenSea": "https://opensea.io/{}",
    "ArtStation": "https://www.artstation.com/{}",
    "ReverbNation": "https://www.reverbnation.com/{}"
}

def banner():
    os.system("clear")
    ascii_banner = """
╔═╗╔═╗╔═╗╦═╗╔═╗╔╦╗  ╔╦╗╔═╗╔═╗╔╦╗╔═╗╔╗╔╦╦ ╦╔╦╗
╚═╗║╣ ║  ╠╦╝║╣  ║    ║║╠═╣║╣ ║║║║ ║║║║║║ ║║║║
╚═╝╚═╝╚═╝╩╚═╚═╝ ╩   ═╩╝╩ ╩╚═╝╩ ╩╚═╝╝╚╝╩╚═╝╩ ╩

::=========[ ☠ OSINT USERNAME ☠ ]=========::
    """.strip("\n")
    print(Fore.GREEN + ascii_banner + Style.RESET_ALL)

def check_username(username):
    results = {}

    for name, url in track(SITES.items(), description="[green]Mengecek username..."):
        full_url = url.format(username)
        try:
            response = requests.get(full_url, timeout=6)
            if response.status_code == 200:
                results[name] = {
                    "status": "Ditemukan",
                    "url": full_url
                }
            elif response.status_code == 404:
                results[name] = {
                    "status": "Tidak Ada",
                    "url": None
                }
            else:
                results[name] = {
                    "status": "Tidak Pasti",
                    "url": None
                }
        except:
            results[name] = {
                "status": "Error",
                "url": None
            }

    rprint(f"\n[bold green]Hasil Pencarian Username:[/bold green]\n")
    print(json.dumps(results, indent=4, ensure_ascii=False))

def run():
    while True:
        banner()
        username = console.input("[bold green]🔹 Masukkan username yang ingin dicari: [/bold green]").strip()
        print()
        check_username(username)
        console.input("\n[bold green]↩️ Tekan Enter untuk kembali [/bold green]")
        break

if __name__ == "__main__":
    run()
