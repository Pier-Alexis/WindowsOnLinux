#!/bin/bash
echo "=== Strengthening Linux environment masking ==="
# Modify /etc/os-release to simule Windows
echo "[1/5] Masking system identity..."
if [ -f /etc/os-release ]; then
    sudo cp /etc/os-release /etc/os-release.bak
    echo "PRETTY_NAME="Windows 10 Pro"" | sudo tee /etc/os-release
    echo "ID=windows" | sudo tee -a /etc/os-release
    echo "VERSION_ID=10" | sudo tee -a /etc/os-release
    echo "NAME="Microsoft Windows"" | sudo tee -a /etc/os-release
else
    echo "/etc/os-release not found, skipping this step..."
fi
# Create aliases to hide uname and lsb_release
echo "[2/5] Creating aliases to hide uname and lsb_release..."
echo "alias uname='echo Windows_NT'" >> ~/.bashrc
echo "alias lsb_release='echo "Microsoft Windows [Version 10.0.19044]"'" >> ~/.bashrc
source ~/.bashrc
# Modification of DXVK to hide Linux system and hardware
echo "[3/5] Changing DXVK settings for hardware masking..."
dxvk_conf="$HOME/.dxvk.conf"
echo "dxgi.customVendorId = 10DE" > $dxvk_conf
echo "dxgi.customDeviceId = 1B80" >> $dxvk_conf
echo "dxgi.fakeDriverVersion = 27.21.14.5671" >> $dxvk_conf
echo "DXVK configuration adjusted for maximum performance."
# Finsh
echo "Masking reinforcement completed! Restart your terminal to apply all changes."
