#!/bin/bash
echo "=== Installation des dépendances Windows essentielles ==="
# Vérification et installation de Wine
echo "[1/6] Vérification et installation de Wine..."
if ! command -v wine &> /dev/null; then
    echo "Wine n'est pas installé. Installation en cours..."
    sudo apt update
    sudo apt install -y wine wine64 winetricks
    if ! command -v wine &> /dev/null; then
        echo "Erreur : L'installation de Wine a échoué."
        exit 1
    fi
else
    echo "Wine est déjà installé."
fi
# Configuration de Wine
echo "[2/6] Configuration de Wine..."
winecfg <<EOF
[system]
os=Windows 10
EOF
# Installation des dépendances via winetricks
echo "[3/6] Installation des bibliothèques et frameworks requis..."
winetricks -q vcrun2019 dotnet48 dxvk
# Installation de DirectX complet
echo "[4/6] Installation de DirectX complet..."
winetricks -q d3dx9 d3dx10 d3dx11
# Installation des versions récentes de .NET
echo "[5/6] Installation des versions récentes de .NET..."
latest_dotnet_url="https://dotnet.microsoft.com/en-us/download/dotnet/6.0/runtime"
wget "$latest_dotnet_url" -O dotnet_latest_installer.exe
wine dotnet_latest_installer.exe /quiet /install
# Vérification et finalisation
echo "[6/6] Vérification de l'installation..."
if wine --version &> /dev/null; then
    echo "Wine et les dépendances ont été installés avec succès."
else
    echo "Une erreur est survenue pendant l'installation."
fi
echo "Installation des dépendances terminée !"
