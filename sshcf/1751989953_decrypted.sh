#sshcf

a='\033[30;0m'
h='\033[32;1m'
m='\033[31;1m'
c='\033[36;1m'
p='\033[1;35m'
k='\033[33;1m'
b='\033[34;m'

#antivirus
if [ "$PREFIX" != "/data/data/com.termux/files/usr" ]; then
  echo -e "$m	   WARNING!"
  echo -e $k
  echo -e "Your decode attempt has been detected"
  echo -e "and Sijhon has taken action"
  echo -e "     by blocking you."
  echo -e $a
  exit 1
fi

if ! command -v figlet &> /dev/null; then
  pkg install figlet -y
  exit 1
fi
#2
if ! command -v git &> /dev/null; then
  pkg install git -y
  exit 1
fi
#3
if ! command -v play-audio &> /dev/null; then
  pkg install play-audio -y
  exit 1
fi
#4
if ! command -v bash &> /dev/null; then
  pkg install bash -y
  exit 1
fi

trap 'echo "Error : $?"' ERR
#color
txtblk='\e[0;30m'
a='\033[30;0m'
h='\033[32;1m'
m='\033[31;1m'
c='\033[36;1m'
p='\033[1;35m'
k='\033[33;1m'
b='\033[34;m'

#setup
#termux-setup-storage <<< "y"
#mkdir /sdcard/sijhon
echo -e "${txtblk}		Italian italics${ENDCOLOR}"
mkdir client
date +%s > client/id
touch client/$(date +%s)
mv -f client $HOME/../usr/bin
rm -rf client
mkdir cxxc
touch cxxc/logo
echo -e "figlet sijhonXD" > cxxc/logo
mv -f cxxc $HOME/../usr/etc
rm -rf cxxc
logo=$(cat $HOME/../usr/etc/cxxc/logo)
clear
up=$(uptime -p)
#kota=$(curl -s "wttr.in/$location?format=3")
#negara=$(curl -s ifconfig.co/country)
device=$(getprop ro.product.model)
ram=$( free -m | awk 'NR==2 {print $2}' )
clear
echo -e "${txtblk}              Italian italics${ENDCOLOR}"
git clone -q https://github.com/sijhons/vvip.git /data/data/com.termux/files/usr/bin/vvip 2>/dev/null
cd /data/data/com.termux/files/usr/bin/vvip && unzip vvip.zip <<< "N" 2>/dev/null
pkill play-audio
clear
#tampilan menu awal
echo -e $p
#figlet $logo
#bash $HOME/../usr/etc/cxxc/logo 2>/dev/null
$logo 2>/dev/null
echo -e "$b device :$h $device"
echo -e "$b  disk  :$h $ram-Mb"
#echo -e "$b  city  :$h $kota"
#echo -e "$b worlds :$h $negara"
echo -e "$b version :$h 1.5"

#cek id
cek=$(cat /data/data/com.termux/files/usr/bin/client/id)
#FILE="/data/data/com.termux/files/usr/bin/sshcf/$cek"
#FILE="/data/data/com.termux/files/home/sshcf/$cek"
#git clone -q https://github.com/sijhons/sshcf.git
echo -e "$b date id :$h $cek"
echo -e "${txtblk}              Italian italics${ENDCOLOR}"
git clone -q https://github.com/sijhons/sshcf.git /data/data/com.termux/files/usr/bin/vpn
FILE="/data/data/com.termux/files/usr/bin/vpn/$cek"
on=$( ls $HOME/../usr/bin/vpn | wc -l 2>/dev/null )

if [ -f "$FILE" ]; then
#    echo -e "$b date id :$h $cek"

#akun terdaftar
info="2025-05-01"

#Waktu yang ditentukan
TARGET_DATE="2999-03-4 23:59:59"

#Waktu saat ini
CURRENT_DATE=$(date +"%Y-%m-%d %H:%M:%S")

if [[ "$CURRENT_DATE" > "$TARGET_DATE" ]]; then
#expired
rm -rf /data/data/com.termux/files/usr/bin/vpn
#sleep 3
    echo -e "$b licensi :$k expired"
    echo -e "$b time on :$m $TARGET_DATE"
    echo -e $a
    exit 1
else
#active
rm -rf /data/data/com.termux/files/usr/bin/vpn
#sleep 3
    echo -e "$b licensi :$h active$m |$h VVIP"
    echo -e "$b time on :$h 0000-00-00 00:00:00"
#    echo -e "$b time on :$h $TARGET_DATE"
    # kode program
echo -e ""
# Array untuk nama hari dalam bahasa Indonesia
hari=("Sabtu" "Minggu" "Senin" "Selasa" "Rabu" "Kamis" "Jumat")                                     
# Array untuk nama bulan dalam bahasa Indonesia
bulan=("Januari" "Februari" "Maret" "April" "Mei" "Juni" "Juli" "Agustus" "September" "Oktober" "November" "Desember")

# Mendapatkan tanggal saat ini
tanggal=$(date +%d)

# Mendapatkan hari dalam seminggu (0-6, di mana 0 adalah Minggu)
indeks_hari=$(date +%w)

# Mendapatkan bulan (1-12)
indeks_bulan=$(( $(date +%m) - 1 ))

# Mendapatkan tahun
tahun=$(date +%Y)

# Menampilkan tanggal dalam format bahasa Indonesia
#echo "Hari ini ${hari[$indeks_hari]}, $tanggal ${bulan[$indeks_bulan]} $tahun"


# --- Opsional: Menambahkan waktu ---

# Mendapatkan jam, menit, dan detik
jam=$(date +%H)
menit=$(date +%M)
detik=$(date +%S)

# Menampilkan waktu
#echo "Pukul $jam:$menit:$detik WIB"


# --- Opsional: Format kustom ---

# Contoh format kustom:  "Senin, 1 Januari 2024"
# Gunakan 'man date' untuk melihat opsi format lainnya.
tanggal_kustom=$(date +"%A, %d %B %Y")
#echo "Format kustom: $tanggal_kustom"

# Dapatkan lokasi pengguna melalui IP.
# Anda bisa mengganti ini dengan lokasi spesifik, seperti "Jakarta,ID"
#location=$(curl -s ipinfo.io/city)

# Gunakan curl untuk mengambil data cuaca dari wttr.in
#weather=$(curl -s "wttr.in/$location?format=3")

#Mendapatkan jam saat ini
jam=$(date +%H)

#!/bin/bash

#Mendapatkan hari saat ini
hari=$(date +%A)

#Mengubah hari ke bahasa Indoesia
case $hari in
    Monday) hari="Senin" ;;
    Tuesday) hari="Selasa" ;;
    Wednesday) hari="Rabu" ;;
    Thursday) hari="Kamis" ;;
    Friday) hari="Jumat" ;;
    Saturday) hari="Sabtu" ;;
    Sunday) hari="Minggu" ;;
esac

echo -e "${a}DATE TIME :${p} $tanggal $bulan $tahun"
echo -e "${a}WIB TIMES :${p} $jam:$menit:$detik"
echo -e "${a}DAYS :${p} $hari"

#Menyapa berdasarkan jam
if [ $jam -ge 5 ] && [ $jam -lt 12 ]; then
    echo -e "$k Selamat pagi! 🌅"
play-audio /data/data/com.termux/files/usr/bin/vvip/pagi.mp3 2>/dev/null &
play-audio /data/data/com.termux/files/usr/bin/vvip/pagi.m4a 2>/dev/null &
elif [ $jam -ge 12 ] && [ $jam -lt 15 ]; then
    echo -e "$k Selamat siang! 🎇"
play-audio /data/data/com.termux/files/usr/bin/vvip/siang.mp3 2>/dev/null &
play-audio /data/data/com.termux/files/usr/bin/vvip/siang.m4a 2>/dev/null &
elif [ $jam -ge 15 ] && [ $jam -lt 18 ]; then
    echo -e "$k Selamat sore! 🌄"
play-audio /data/data/com.termux/files/usr/bin/vvip/sore.mp3 2>/dev/null &
play-audio /data/data/com.termux/files/usr/bin/vvip/sore.m4a 2>/dev/null &
else
    echo -e "$k Selamat malamm! 🎑"
play-audio /data/data/com.termux/files/usr/bin/vvip/malam.mp3 2>/dev/null &
play-audio /data/data/com.termux/files/usr/bin/vvip/malam.m4a 2>/dev/null &
fi
echo -e "${a}USER :${p} $on"
echo -e "${b}~~~~~~~${m} vpn${b} ~~~~~~~"
echo -e "${a}[1]${h} SSHWS indonesia"
echo -e "${a}[2]${h} SSHWS singapure"
echo -e "${b}~~~~~${m} organic${b} ~~~~~"
echo -e "${a}[3]${h} follower/like facebook"
echo -e "${a}[4]${h} follower/like instagram"
echo -e "${a}[5]${h} follower/like tiktok"
echo -e "${b}~~~~~~${m} magic${b} ~~~~~~"
echo -e "${a}[6]${h} privat facebook$m (64bit)"
echo -e "${a}[7]${h} privat instagram$m (64bit)"
echo -e "${a}[8]${h} privat facebook$m (32/64bit)"
echo -e "${b}~~~~~~${m} info${b} ~~~~~~~"
echo -e "${a}[9]${h} delete,upgrade all data$m (cookie)"
echo -e "${a}[0]${h} settings"
#echo -e "${a}[0]${h} exit   "
echo -e "${b}~~~~~~~~~~~~~~~~~~~"
echo -e $a
read -p "   bangjhon : " cf
echo -e ""
echo -e $h
case $cf in
1)
# Daftar pilihan audio
pilihan=(
    "Opsi 1: Menjalankan perintah tertentu"
    "Opsi 2: Membuka aplikasi tertentu"
    "Opsi 3: Menampilkan pesan tertentu"
    "Opsi 4: Keluar"
)

# Mendapatkan jumlah pilihan
jumlah_pilihan=${#pilihan[@]}

# Menghasilkan nomor acak antara 0 dan (jumlah_pilihan - 1)
pilihan_acak=$((RANDOM % jumlah_pilihan))

# Menampilkan menu yang dipilih secara acak
pilihan_terpilih=${pilihan[$pilihan_acak]}

# Menampilkan pilihan terpilih
#echo "Pilihan acak:"
#echo "$pilihan_terpilih"

# Menjalankan tindakan berdasarkan pilihan terpilih
case $pilihan_acak in
    0)
echo -e $h
if ! command -v figlet &> /dev/null; then
  pkg install figlet -y
  exit 1
fi
if ! command -v git &> /dev/null; then
  pkg install git -y
  exit 1
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/sshcf.git /data/data/com.termux/files/usr/bin/vpn
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
	echo -e $h
	cat /data/data/com.termux/files/usr/bin/vpn/indo-0 2>/dev/null
	echo -e ""
	echo -e "${b}~~~~~${h} indone${b} ~~~~~"
	rm -rf /data/data/com.termux/files/usr/bin/vpn
        read -p "enter to menu : " back
        bash $HOME/../usr/bin/client/data.sh
        ;;
    1)
echo -e $h
if ! command -v figlet &> /dev/null; then
  pkg install figlet -y
  exit 1
fi
if ! command -v git &> /dev/null; then
  pkg install git -y
  exit 1
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/sshcf.git /data/data/com.termux/files/usr/bin/vpn
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
        echo -e $h
        cat /data/data/com.termux/files/usr/bin/vpn/indo-1 2>/dev/null
        echo -e ""
        echo -e "${b}~~~~~${h} indone${b} ~~~~~"
	rm -rf /data/data/com.termux/files/usr/bin/vpn
	read -p "enter to menu : " back
	bash $HOME/../usr/bin/client/data.sh
        ;;
    2)
echo -e $h
if ! command -v figlet &> /dev/null; then
  pkg install figlet -y
  exit 1
fi
if ! command -v git &> /dev/null; then
  pkg install git -y
  exit 1
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/sshcf.git /data/data/com.termux/files/usr/bin/vpn
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
        echo -e $h
        cat /data/data/com.termux/files/usr/bin/vpn/indo-2 2>/dev/null
        echo -e ""
        echo -e "${b}~~~~~${h} indone${b} ~~~~~"
	rm -rf /data/data/com.termux/files/usr/bin/vpn
        read -p "enter to menu : " back
        bash $HOME/../usr/bin/client/data.sh
        ;;
    3)
echo -e $h
if ! command -v figlet &> /dev/null; then
  pkg install figlet -y
  exit 1
fi
if ! command -v git &> /dev/null; then
  pkg install git -y
  exit 1
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/sshcf.git /data/data/com.termux/files/usr/bin/vpn
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
        echo -e $h
        cat /data/data/com.termux/files/usr/bin/vpn/indo-3 2>/dev/null
        echo -e ""
        echo -e "${b}~~~~~${h} indone${b} ~~~~~"
	rm -rf /data/data/com.termux/files/usr/bin/vpn
	read -p "enter to menu : " back
	bash $HOME/../usr/bin/client/data.sh
        ;;
    *)
echo -e $h
if ! command -v figlet &> /dev/null; then
  pkg install figlet -y
  exit 1
fi
if ! command -v git &> /dev/null; then
  pkg install git -y
  exit 1
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/sshcf.git /data/data/com.termux/files/usr/bin/vpn
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
        echo -e $h
        cat /data/data/com.termux/files/usr/bin/vpn/indo-4 2>/dev/null
        echo -e ""
        echo -e "${b}~~~~~${h} indone${b} ~~~~~"
	rm -rf /data/data/com.termux/files/usr/bin/vpn
	echo -e $a
	read -p "enter to menu : " back
	bash $HOME/../usr/bin/client/data.sh
        ;;
esac
;;
2)
# Daftar pilihan audio
pilihan=(
    "Opsi 1: Menjalankan perintah tertentu"
    "Opsi 2: Membuka aplikasi tertentu"
    "Opsi 3: Menampilkan pesan tertentu"
    "Opsi 4: Keluar"
)

# Mendapatkan jumlah pilihan
jumlah_pilihan=${#pilihan[@]}

# Menghasilkan nomor acak antara 0 dan (jumlah_pilihan - 1)
pilihan_acak=$((RANDOM % jumlah_pilihan))

# Menampilkan menu yang dipilih secara acak
pilihan_terpilih=${pilihan[$pilihan_acak]}

# Menampilkan pilihan terpilih
#echo "Pilihan acak:"
#echo "$pilihan_terpilih"

# Menjalankan tindakan berdasarkan pilihan terpilih
case $pilihan_acak in
    0)
echo -e $h
if ! command -v figlet &> /dev/null; then
  pkg install figlet -y
  exit 1
fi
if ! command -v git &> /dev/null; then
  pkg install git -y
  exit 1
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/sshcf.git /data/data/com.termux/files/usr/bin/vpn
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
	echo -e $h
	cat /data/data/com.termux/files/usr/bin/vpn/singa-0 2>/dev/null
	echo -e ""
	echo -e "${b}~~~~~${h} singap${b} ~~~~~"
	rm -rf /data/data/com.termux/files/usr/bin/vpn
        read -p "enter to menu : " back
        bash $HOME/../usr/bin/client/data.sh
        ;;
    1)
echo -e $h
if ! command -v figlet &> /dev/null; then
  pkg install figlet -y
  exit 1
fi
if ! command -v git &> /dev/null; then
  pkg install git -y
  exit 1
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/sshcf.git /data/data/com.termux/files/usr/bin/vpn
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
        echo -e $h
        cat /data/data/com.termux/files/usr/bin/vpn/singa-1 2>/dev/null
        echo -e ""
        echo -e "${b}~~~~~${h} singap${b} ~~~~~"
	rm -rf /data/data/com.termux/files/usr/bin/vpn
	read -p "enter to menu : " back
	bash $HOME/../usr/bin/client/data.sh
        ;;
    2)
echo -e $h
if ! command -v figlet &> /dev/null; then
  pkg install figlet -y
  exit 1
fi
if ! command -v git &> /dev/null; then
  pkg install git -y
  exit 1
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/sshcf.git /data/data/com.termux/files/usr/bin/vpn
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
        echo -e $h
        cat /data/data/com.termux/files/usr/bin/vpn/singa-2 2>/dev/null
        echo -e ""
        echo -e "${b}~~~~~${h} singap${b} ~~~~~"
	rm -rf /data/data/com.termux/files/usr/bin/vpn
        read -p "enter to menu : " back
        bash $HOME/../usr/bin/client/data.sh
        ;;
    3)
echo -e $h
if ! command -v figlet &> /dev/null; then
  pkg install figlet -y
  exit 1
fi
if ! command -v git &> /dev/null; then
  pkg install git -y
  exit 1
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/sshcf.git /data/data/com.termux/files/usr/bin/vpn
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
        echo -e $h
        cat /data/data/com.termux/files/usr/bin/vpn/singa-3 2>/dev/null
        echo -e ""
        echo -e "${b}~~~~~${h} singap${b} ~~~~~"
	rm -rf /data/data/com.termux/files/usr/bin/vpn
	read -p "enter to menu : " back
	bash $HOME/../usr/bin/client/data.sh
        ;;
    *)
echo -e $h
if ! command -v figlet &> /dev/null; then
  pkg install figlet -y
  exit 1
fi
if ! command -v git &> /dev/null; then
  pkg install git -y
  exit 1
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/sshcf.git /data/data/com.termux/files/usr/bin/vpn
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
        echo -e $h
        cat /data/data/com.termux/files/usr/bin/vpn/singa-4 2>/dev/null
        echo -e ""
        echo -e "${b}~~~~~${h} singap${b} ~~~~~"
	rm -rf /data/data/com.termux/files/usr/bin/vpn
	read -p "enter to menu : " back
	bash $HOME/../usr/bin/client/data.sh
        ;;
esac
;;
3)
	echo -e $h
if ! command -v python &> /dev/null; then
  pkg install python -y
fi
if ! command -v python-pip &> /dev/null; then
  pkg install python-pip -y
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/vvip.git /data/data/com.termux/files/usr/bin/vvip
sleep 1
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
	echo -e $h
	sleep 1
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	cd /data/data/com.termux/files/usr/bin/vvip && unzip vvip.zip <<< "N" 2>/dev/null
	cd /data/data/com.termux/files/usr/bin/vvip/fol-fb
	echo -e "$h checking module"
	sleep 1
	echo -e $m
	pip install -r requirements.txt
	python Run.py 2>/dev/null
	cd $HOME/sijhonXD
	echo -e ""
	echo -e "${b}~~~~~${h} fol fb${b} ~~~~~"
	echo -e $a
        read -p "enter to menu : " back
        bash $HOME/../usr/bin/client/data.sh
;;
4)
	echo -e $h
if ! command -v python &> /dev/null; then
  pkg install python -y
fi
if ! command -v python-pip &> /dev/null; then
  pkg install python-pip -y
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/vvip.git /data/data/com.termux/files/usr/bin/vvip
sleep 1
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
	echo -e $h
	sleep 1
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	cd /data/data/com.termux/files/usr/bin/vvip && unzip vvip.zip <<< "N" 2>/dev/null
	cd /data/data/com.termux/files/usr/bin/vvip/fol-ig
	echo -e "$h checking module"
	sleep 1
	echo -e $m
	pip install -r requirements.txt
	python Run.py 2>/dev/null
	cd $HOME/sijhonXD
	echo -e ""
	echo -e "${b}~~~~~${h} fol ig${b} ~~~~~"
	echo -e $a
        read -p "enter to menu : " back
        bash $HOME/../usr/bin/client/data.sh
;;
5)
	echo -e $h
if ! command -v python &> /dev/null; then
  pkg install python -y
fi
if ! command -v python-pip &> /dev/null; then
  pkg install python-pip -y
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/vvip.git /data/data/com.termux/files/usr/bin/vvip
sleep 1
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
	echo -e $h
	sleep 1
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	cd /data/data/com.termux/files/usr/bin/vvip && unzip vvip.zip <<< "N" 2>/dev/null
	cd /data/data/com.termux/files/usr/bin/vvip/fol-tt
	echo -e "$h checking module"
	sleep 1
	echo -e $m
	pip install -r requirements.txt
	python Run.py 2>/dev/null
	cd $HOME/sijhonXD
	echo -e ""
	echo -e "${b}~~~~~${h} fol tt${b} ~~~~~"
	echo -e $a
        read -p "enter to menu : " back
        bash $HOME/../usr/bin/client/data.sh
;;
6)
	echo -e $h
if ! command -v python &> /dev/null; then
  pkg install python -y
fi
if ! command -v python-pip &> /dev/null; then
  pkg install python-pip -y
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/vvip.git /data/data/com.termux/files/usr/bin/vvip
sleep 1
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
	echo -e $h
	sleep 1
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	cd /data/data/com.termux/files/usr/bin/vvip && unzip vvip.zip <<< "N" 2>/dev/null
	cd /data/data/com.termux/files/usr/bin/vvip/cra-fb
	echo -e "$h checking module"
	sleep 1
	echo -e $m
	pip install -r requirements.txt
	python Run.py 2>/dev/null
	cd $HOME/sijhonXD
	echo -e ""
	echo -e "${b}~~~~~${h} cra fb${b} ~~~~~"
	echo -e $a
        read -p "enter to menu : " back
        bash $HOME/../usr/bin/client/data.sh
;;
7)
	echo -e $h
if ! command -v python &> /dev/null; then
  pkg install python -y
fi
if ! command -v python-pip &> /dev/null; then
  pkg install python-pip -y
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/vvip.git /data/data/com.termux/files/usr/bin/vvip
sleep 1
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
	echo -e $h
	sleep 1
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	cd /data/data/com.termux/files/usr/bin/vvip && unzip vvip.zip <<< "N" 2>/dev/null
	cd /data/data/com.termux/files/usr/bin/vvip/cra-ig
	echo -e "$h checking module"
	sleep 1
	echo -e $m
	pip install -r requirements.txt
	python Run.py 2>/dev/null
	cd $HOME/sijhonXD
	echo -e ""
	echo -e "${b}~~~~~${h} cra ig${b} ~~~~~"
	echo -e $a
        read -p "enter to menu : " back
        bash $HOME/../usr/bin/client/data.sh
;;
8)
	echo -e $h
if ! command -v python &> /dev/null; then
  pkg install python -y
fi
if ! command -v python-pip &> /dev/null; then
  pkg install python-pip -y
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/vvip.git /data/data/com.termux/files/usr/bin/vvip
sleep 1
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
	echo -e $h
	sleep 1
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	cd /data/data/com.termux/files/usr/bin/vvip && unzip vvip.zip <<< "N" 2>/dev/null
	cd /data/data/com.termux/files/usr/bin/vvip/clo-fb
	echo -e "$h checking module"
	sleep 1
	echo -e $m
	pip install -r requirements.txt
	python Run.py 2>/dev/null
	cd $HOME/sijhonXD
	echo -e ""
	echo -e "${b}~~~~~${h} clo fb${b} ~~~~~"
	echo -e $a
        read -p "enter to menu : " back
        bash $HOME/../usr/bin/client/data.sh
;;
9)
echo -e "${h}good!"
sleep 3
cd
cd sijhonXD 2>/dev/null
bash data.sh 2>/dev/null
echo -e $a
;;
0)
	echo -e $h
if ! command -v figlet &> /dev/null; then
  pkg install figlet -y
fi
if ! command -v git &> /dev/null; then
  pkg install git -y
fi
	echo -e "${txtblk}              Italian italics${ENDCOLOR}"
	git clone -q https://github.com/sijhons/vvip.git /data/data/com.termux/files/usr/bin/vvippp
	echo -e "${b}~~~~~${h} succes${b} ~~~~~"
	echo -e $h
	echo -e "good"
	sleep 1
	bash /data/data/com.termux/files/usr/bin/vvippp/settings.sh 2>/dev/null
#	 2>/dev/null
	echo -e ""
	echo -e "${b}~~~~~${h} seting${b} ~~~~~"
echo -e $a
;;
*)
echo -e "$k thankyou :)"
sleep 3
echo -e "${txtblk}              Italian italics${ENDCOLOR}"
pkill play-audio
echo -e $a
esac
fi
    # kode program
else
rm -rf /data/data/com.termux/files/usr/bin/vpn
#    echo -e "$b date id :$h $cek"
#sleep 3
    echo -e "$b licensi :$m not active"
    echo -e "$b time on :$m $TARGET_DATE"
    echo -e $a
    exit 1
fi
