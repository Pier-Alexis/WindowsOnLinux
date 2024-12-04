#!/bin/bash
echo "=== Renforcement du masquage de l'environnement Linux ==="
# Modifier /etc/os-release pour simuler Windows
echo "[1/5] Masquage de l'identité système..."
if [ -f /etc/os-release ]; then
    sudo cp /etc/os-release /etc/os-release.bak
    echo "PRETTY_NAME="Windows 10 Pro"" | sudo tee /etc/os-release
    echo "ID=windows" | sudo tee -a /etc/os-release
    echo "VERSION_ID=10" | sudo tee -a /etc/os-release
    echo "NAME="Microsoft Windows"" | sudo tee -a /etc/os-release
else
    echo "/etc/os-release introuvable, saut de cette étape."
fi
# Créer des alias pour simuler uname et lsb_release
echo "[2/5] Création d'alias pour masquer uname et lsb_release..."
echo "alias uname='echo Windows_NT'" >> ~/.bashrc
echo "alias lsb_release='echo "Microsoft Windows [Version 10.0.19044]"'" >> ~/.bashrc
source ~/.bashrc
# Modification des paramètres DXVK pour masquer les informations Linux
echo "[3/5] Modification des paramètres DXVK pour le masquage matériel..."
dxvk_conf="$HOME/.dxvk.conf"
echo "dxgi.customVendorId = 10DE" > $dxvk_conf
echo "dxgi.customDeviceId = 1B80" >> $dxvk_conf
echo "dxgi.fakeDriverVersion = 27.21.14.5671" >> $dxvk_conf
echo "Configuration DXVK ajustée pour les performances maximales."
# Finalisation
echo "Renforcement du masquage terminé ! Redémarrez votre terminal pour appliquer toutes les modifications."
