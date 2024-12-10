#!/bin/bash

echo "=== Uninstalling WindowsOnLinux ==="

# Step 1: Remove WindowsOnLinux directory
echo "[1/3] Removing WindowsOnLinux files and directories..."
if [ -d "/opt/WindowsOnLinux" ]; then
    sudo rm -rf /opt/WindowsOnLinux
    echo "WindowsOnLinux files removed."
else
    echo "WindowsOnLinux directory not found."
fi

# Step 2: Remove MIME configurations
echo "[2/3] Removing MIME configurations..."
sudo rm -f /usr/share/applications/WindowsOnLinux.desktop
sudo update-desktop-database
sudo update-mime-database /usr/share/mime
echo "MIME configurations removed."

# Step 3: Uninstall dependencies (optional)
read -p "Do you want to remove Wine and other dependencies? (y/n): " choice
if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    echo "Uninstalling dependencies..."
    sudo apt remove --purge -y wine wine64 winetricks
    sudo apt autoremove -y
    echo "Dependencies uninstalled."
else
    echo "Skipping dependency removal."
fi

echo "=== Uninstallation of WindowsOnLinux completed ==="
