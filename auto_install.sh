#!/bin/bash

echo "=== Starting Auto Installation of WindowsOnLinux ==="
echo "Unzipping file..."
sudo apt update
sudo apt-get install unzip
echo "Creating directories..."
sudo mkdir -p /opt/WindowsOnLinux
echo "Setting up permissions..."
# Ensure /opt/WindowsOnLinux exists
sudo mkdir -p /opt/WindowsOnLinux
sudo chmod 755 /opt/WindowsOnLinux
# Unzip directly into the target directory
unzip v1.0.3-2.0.zip -d /opt/WindowsOnLinux
if [ ! -f /opt/WindowsOnLinux/install_dependencies.sh ]; then
    echo "Error: Required files are missing in /opt/WindowsOnLinux. Installation aborted."
    exit 1
fi
if [! -f /opt/WindowsOnLinux/configure_mime.sh ]; then
    echo "Error: Required files are missing ! Path : /opt/WindowsOnLinux. Installation aborted"
    exit 1
fi

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
# dotnet is include in the v1.0.0 release. IF NOT USE PLEASE DELETE THIS LINE
wine /opt/WindowsOnLinux/dotnet_latest_installer.exe

# Finalization
echo "=== Auto Installation of WindowsOnLinux completed ==="
echo "=== To use WindowsOnLinux please open an exe or msi file ==="
