#!/bin/bash
echo "=== .msi Files Manager (Microsoft Installer) ==="
if [ "$#" -lt 1 ]; then
    echo "Usage : ./install_msi.sh <path_to_file.msi> [options]"
    echo "Common options :"
    echo "  /i : Install a package."
    echo "  /x : Uninstall a package."
    echo "  /quiet : Silent installation."
    exit 1
fi
FILE="$1"
OPTIONS="${@:2}"
if [ ! -f "$FILE" ]; then
    echo "Error : file not found - $FILE"
    exit 1
fi
echo "Starting installation via msiexec..."
wine msiexec $OPTIONS /package "$FILE"
if [ $? -eq 0 ]; then
    echo "Installation succesfully done for $FILE."
else
    echo "An error occurred during installation. Check the logs."
fi
