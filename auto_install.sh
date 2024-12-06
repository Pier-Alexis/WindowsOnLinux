#!/bin/bash

echo "=== Starting Auto Installation of WindowsOnLinux ==="
echo "Unzipping file..."
sudo apt update
sudo apt-get install unzip
echo "Creating directories..."
sudo mkdir -p /opt/WindowsOnLinux
echo "Setting up permissions..."
sudo chmod 755 /opt/WindowsOnLinux
sudo chmod -R 755 /opt/WindowsOnLinux
echo "Copying zip archive..."
sudo unzip v1.0.0 -d /opt/WindowsOnLinux
echo "Installing dependencies..."
sudo chmod +x /opt/WindowsOnLinux/install_dependencies.sh
cd /opt/WindowsOnLinux
./install_dependencies.sh
echo "Configuring MIME for WindowsOnLinux..."
sudo cp /opt/WindowsOnLinux/WindowsOnLinux.desktop /usr/share/applications/
sudo update-desktop-database
sudo update-mime-database /usr/share/mime
sudo chmod +x /opt/WindowsOnLinux/configure_mime.sh
cd /opt/WindowsOnLinux
./configure_mime.sh
echo "Running post-install configuration..."
cd /opt/WindowsOnLinux
./enhanced_mask_environment.sh
wine /opt/WindowsOnLinux/dotnet_latest_installer.exe

# Finalization
echo "=== Auto Installation of WindowsOnLinux completed ==="
echo "=== To use WindowsOnLinux please open an exe or msi file ==="
