#!/bin/bash

echo "=== Ultimate Windows On Linux Manager ==="

# Fonction to configure Fortnite
function setup_fortnite_proton() {
    echo "=== Configuration of an minimal Proton environment for Fortnite ==="

    # Creating needed repository
    echo "[1/4] Creation of repository..."
    mkdir -p ~/proton_fortnite/prefix
    export WINEPREFIX=~/proton_fortnite/prefix

    # Installation of DXVK
    echo "[2/4] Downloading and installating DXVK for Fortnite..."
    mkdir -p ~/proton_fortnite/dxvk
    wget https://github.com/doitsujin/dxvk/releases/download/v2.0/dxvk-2.0.tar.gz -O ~/proton_fortnite/dxvk/dxvk.tar.gz
    tar -xvf ~/proton_fortnite/dxvk/dxvk.tar.gz -C ~/proton_fortnite/dxvk

    # Installation of dependencies via winetricks
    echo "[3/4] Installation of dependencies via winetricks"
    winetricks -q vcrun2019 dxvk

    # Creating of a launch script for Fortnite
    echo "[4/4] Creating of a launch script for Fortnite"
    cat <<EOF > ~/proton_fortnite/launch_fortnite.sh
#!/bin/bash
export WINEPREFIX=~/proton_fortnite/prefix
export WINEDEBUG=-all
export DXVK_HUD=1

# Launch Fortnite via Epic Games Launcher
wine ~/.wine/drive_c/Program\\ Files/Epic\\ Games/Launcher/Portal/Binaries/Win64/EpicGamesLauncher.exe

EOF

    chmod +x ~/proton_fortnite/launch_fortnite.sh
    echo "=== Configuration terminée ! Utilisez ~/proton_fortnite/launch_fortnite.sh pour lancer Fortnite ==="
}

function show_menu() {
    echo "Choose an option :"
    echo "2. Launch a game or a Windows Application"
    echo "3. Manage DLL and dependencies"
    echo "4. Modify advanced configuration (DXVK, Wine)"
    echo "6. Diagnostic an application or a game"
    echo "1. Setup Fortnite"
    echo "7. Exit"
}

function setup_environment() {
    echo "Configuration de l'environnement complet..."
    ./install_dependencies.sh
    echo "Environnement configuré avec succès !"
}

function launch_application() {
    read -p "Entrez le chemin complet du fichier .exe ou .msi : " file_path
    if [[ "$file_path" == *.msi ]]; then
        ./install_msi.sh "$file_path" /i
    elif [[ "$file_path" == *.exe ]]; then
        wine "$file_path"
    else
        echo "Format de fichier non pris en charge : $file_path"
    fi
}

function configure_mime() {
    echo "Configuration des associations MIME pour .exe et .msi..."
    ./configure_mime.sh
    echo "Associations MIME configurées avec succès !"
}

function diagnose_application() {
    read -p "Entrez le chemin complet du fichier .exe ou .msi : " file_path
    echo "Lancement du diagnostic pour $file_path..."
    WINEDEBUG=+all wine "$file_path" &> wine_diagnostic.log
    echo "Diagnostic terminé. Rapport enregistré dans wine_diagnostic.log"
}

while true; do
    show_menu
    read -p "Your choice : " main_choice
    case $main_choice in
        1) setup_fortnite_proton ;;
        2) launch_application ;;
        6) diagnose_application ;;
        7) echo "Fermeture du gestionnaire." ; exit 0 ;;
        *) echo "Option invalide. Veuillez réessayer." ;;
    esac
done
