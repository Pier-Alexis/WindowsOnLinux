#!/bin/bash

echo "=== Automatic Installation of WindowsOnLinux ==="

# Decompression of ZIP file
echo "[1/5] Unzipping..."
unzip v1.0.1 -d ./WindowsOnLinux
cd ./WindowsOnLinux || exit 1

# Attribute permissions
echo "[2/5] Configuring permissions..."
for script in *.sh; do
    chmod +x "$script"
done

# Installation of dependencies
echo "[3/5] Installation of dependencies..."
./install_dependencies.sh

# Mask linux environment
echo "[4/5] Hiding Linux environment..."
./enhanced_mask_environment.sh

# Configuration of MIME associations
echo "[5/5] Configuration of MIME associations..."
./configure_mime.sh

# Finalisation
echo "Installation Completed ! !"
echo "You can now use WindowsOnLinux by opening a .exe or .msi file, or launch the WindowsOnLinux Manager to configure :"
echo "./ultimate_windows_manager.sh"
