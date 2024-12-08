#!/bin/bash

echo "=== Ultimate Windows On Linux Manager ==="

# Path to store the last opened .exe file
LAST_EXE_FILE="/opt/WindowsOnLinux/last_exe.log"
LAST_MSI_FILE="/opt/WindowsOnLinux/last_msi.log"

# Ensure the log files exist
for file in "$LAST_EXE_FILE" "$LAST_MSI_FILE"; do
    if [ ! -f "$file" ]; then
        sudo touch "$file"
        sudo chmod 666 "$file"
    fi
done

# Function to open a Windows executable (.exe)
function open_last_exe() {
    local exe_path="$1"
    if [ -z "$exe_path" ]; then
        exe_path=$(cat "$LAST_EXE_FILE" 2>/dev/null)
        if [ -z "$exe_path" ]; then
            zenity --error --text="No last .exe file found. Please select a file."
            return 1
        fi
    fi
    wine "$exe_path"
    echo "$exe_path" | sudo tee "$LAST_EXE_FILE" > /dev/null
    zenity --info --text="File '$exe_path' executed successfully."
}

# Function to open a Windows installer (.msi)
function open_last_msi() {
    local msi_path="$1"
    if [ -z "$msi_path" ]; then
        msi_path=$(cat "$LAST_MSI_FILE" 2>/dev/null)
        if [ -z "$msi_path" ]; then
            zenity --error --text="No last .msi file found. Please select a file."
            return 1
        fi
    fi
    wine msiexec /i "$msi_path"
    echo "$msi_path" | sudo tee "$LAST_MSI_FILE" > /dev/null
    zenity --info --text="File '$msi_path' installed successfully."
}

# Function to select and open a file
function select_file() {
    local file_type="$1"
    local selected_file=$(zenity --file-selection --title="Select a $file_type file")
    if [ -z "$selected_file" ]; then
        zenity --error --text="No file selected."
        return 1
    fi
    case "$file_type" in
        exe) open_last_exe "$selected_file" ;;
        msi) open_last_msi "$selected_file" ;;
    esac
}

function setup_steam_with_proton() {
    echo "=== Installation and configuration of Steam with Proton ==="
    echo "[1/3] Installation of Steam..."
    if ! command -v steam &> /dev/null; then
        sudo apt update
        sudo apt install -y steam
        sudo apt install gamemode
        sudo apt update
        sudo apt upgrade
    else
        echo "Steam is already installed."
        sudo apt update
        sudo apt upgrade
    fi
    
    echo "[2/3] Installation of Proton-GE..."
    mkdir -p /opt/WindowsOnLinux/compatibilitytools.d
    proton_ge_url="https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton7-42/GE-Proton7-42.tar.gz"
    wget "$proton_ge_url" -O ~/proton-ge.tar.gz
    tar -xzf ~/proton-ge.tar.gz -C /opt/WindowsOnLinux/compatibilitytools.d
    
    echo "[3/3] Configuration of Steam to use Proton-GE..."
    mkdir -p /opt/WindowsOnLinux/steam/steam/steamapps/compatdata
    echo "Proton-GE installed /opt/WindowsOnLinux/compatibilitytools.d"
    echo "=== Installation et configuration de Steam avec Proton terminées ! ==="
    echo "Redémarrez Steam et configurez les jeux pour utiliser Proton-GE dans les propriétés."

# Function to show the main menu
function show_graphical_menu() {
    local choice=$(zenity --list \
        --title="Windows On Linux Manager" \
        --column="Action" \
        "Setup Fortnite" \
        "Install a .exe file" \
        "Install a .msi file" \
        "Diagnose an application" \
        "Setup Steam with Proton" \
        "Exit")

    case "$choice" in
        "Install a .exe file") select_file "exe" ;;
        "Install a .msi file") select_file "msi" ;;
        "Diagnose an application") diagnose_application ;;
        "Setup Steam with Proton") setup_steam_with_proton ;;
        "Exit") zenity --info --text="Exiting the Manager."; exit 0 ;;
        *) zenity --error --text="Invalid selection." ;;
    esac
}

# Keep showing the graphical menu
while true; do
    show_graphical_menu
done
