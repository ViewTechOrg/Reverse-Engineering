#!/data/data/com.termux/files/usr/bin/bash
# Multi-decrypt payload dari banyak self-extracting script .sh
# Otomatis deteksi nama file dan simpan hasilnya

set -e

SKIP=50  # Baris awal payload terenkripsi

if [ $# -eq 0 ]; then
    echo "[!] Masukkan nama file target sebagai argumen"
    echo "    Contoh: bash decode.sh menu.sh ,ingin massal"
    echo "            bash decode.sh menu.sh manda.sh wal.sh lainya"
    exit 1
fi

for file in "$@"; do
    if [ ! -f "$file" ]; then
        echo "[!] File tidak ditemukan: $file"
        continue
    fi

    echo "[*] Memproses: $file"

    base=$(basename "$file" .sh)
    raw_payload="${base}_payload.gz"
    output_file="${base}_decrypted.sh"

    # Ekstrak payload terenkripsi
    tail -n +$SKIP "$file" > "$raw_payload"

    # Coba decompress
    if gzip -cd "$raw_payload" > "$output_file" 2>/dev/null; then
        echo "[✓] $file berhasil didekompresi ke $output_file"
        chmod +x "$output_file"
    else
        echo "[✗] Gagal decompress: $file (mungkin bukan gzip)"
        rm -f "$output_file"
    fi

    rm -f "$raw_payload"  # Hapus payload mentah
done
