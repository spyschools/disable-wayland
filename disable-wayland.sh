#!/bin/bash
# Script disable Wayland di Kali Linux Xfce/GDM
# Tested on Kali Linux 2025

set -e

echo "[INFO] Mengecek display manager..."

# Cek apakah pakai LightDM
if systemctl list-units --type=service | grep -q lightdm; then
    echo "[INFO] LightDM terdeteksi, mengubah konfigurasi..."
    sudo mkdir -p /etc/lightdm
    if [ -f /etc/lightdm/lightdm.conf ]; then
        sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.bak
    fi

    # Tambah/ubah konfigurasi untuk pakai Xorg
    sudo bash -c 'cat > /etc/lightdm/lightdm.conf <<EOF
[Seat:*]
user-session=xfce
greeter-session=lightdm-gtk-greeter
xserver-command=X -retro
EOF'
    echo "[OK] Wayland dinonaktifkan untuk LightDM (Xfce)."

# Cek apakah pakai GDM
    if [ -f /etc/gdm3/custom.conf ]; then
        sudo cp /etc/gdm3/custom.conf /etc/gdm3/custom.conf.bak
        sudo sed -i 's/^#WaylandEnable=true/WaylandEnable=false/' /etc/gdm3/custom.conf
        sudo sed -i 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
    else
        echo "[ERROR] File /etc/gdm3/custom.conf tidak ditemukan."
        exit 1
    fi
    echo "[OK] Wayland dinonaktifkan untuk GDM."
    sudo sed -i 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
    echo "[OK] Wayland dinonaktifkan untuk GDM."

else
    echo "[WARNING] Tidak menemukan LightDM atau GDM. Periksa display manager lain."
    exit 1
fi

echo "[INFO] Selesai! Silakan reboot untuk menerapkan perubahan."
