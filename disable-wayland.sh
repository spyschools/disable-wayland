#!/bin/bash
# Script disable Wayland di Kali Linux XFCE

echo "[INFO] Mengecek Display Manager yang aktif..."
DM=$(cat /etc/X11/default-display-manager 2>/dev/null)

if [[ "$DM" == *"gdm3"* ]]; then
    echo "[INFO] Terdeteksi GDM3, memodifikasi /etc/gdm3/custom.conf..."
    sudo sed -i 's/^#WaylandEnable=true/WaylandEnable=false/' /etc/gdm3/custom.conf
    sudo sed -i 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf

    if ! grep -q "WaylandEnable=false" /etc/gdm3/custom.conf; then
        echo "WaylandEnable=false" | sudo tee -a /etc/gdm3/custom.conf >/dev/null
    fi

    echo "[OK] Wayland berhasil dinonaktifkan di GDM3."
    echo "Silakan restart GDM atau reboot: sudo systemctl restart gdm3"

elif [[ "$DM" == *"lightdm"* ]]; then
    echo "[INFO] Terdeteksi LightDM."
    echo "[OK] LightDM tidak menggunakan Wayland (sudah pakai Xorg secara default)."

else
    echo "[WARNING] Tidak bisa mendeteksi Display Manager dengan pasti."
    echo "Isi /etc/X11/default-display-manager: $DM"
fi

echo "[INFO] Session type sekarang: $XDG_SESSION_TYPE"
