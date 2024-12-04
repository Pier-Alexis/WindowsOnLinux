#!/bin/bash
echo "=== Welcome to the WindowsOnLinux installation ==="
echo "=== Installing essentials Windows dependencies ==="
# Verification and installation of Wine
echo "[1/6] Verification and installation of Wine..."
if ! command -v wine &> /dev/null; then
    echo "Wine isn't install. Installing in progress..."
    sudo apt update
    sudo apt install --install-recommends wine64
    sudo apt install --install-recommends winetricks
    sudo dpkg --add-architecture i386 && sudo apt-get update && sudo apt-get install wine32:i386
    if ! command -v wine &> /dev/null; then
        echo "Error : The Wine installation have failed."
        exit 1
    fi
else
    echo "Wine is already installed."
fi
# Configuration of Wine
echo "[2/6] Configuration of Wine..."
winecfg <<EOF
[system]
os=Windows 10
EOF
# Installation of dependencies via winetricks
echo "[3/6] Installation of requires dependencies..."
winetricks -q vcrun2019 dotnet48 dxvk
# Complete installation of DirectX
echo "[4/6] Full installation of DirectX..."
winetricks -q d3dx9 d3dx10 d3dx11
winetricks -q dxvk
winetricks -q vcrun2019 dotnet48
# Installation des versions récentes de .NET
echo "[5/6] Installation of recents versions of .NET..."
latest_dotnet_url="https://dotnet.microsoft.com/en-us/download/dotnet/6.0/runtime"
wget "$latest_dotnet_url" -O dotnet_latest_installer.exe
wine dotnet_latest_installer.exe /quiet /install
# Vérification et finalisation
echo "[6/6] Verification of the installation..."
if wine --version &> /dev/null; then
    echo "Wine and others dependencies have been succesfully installed."
else
    echo "An error occurred during the installation."
fi
echo "Installation of dependencies finished !"
