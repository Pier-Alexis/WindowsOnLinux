#!/bin/bash
echo "=== Ultimate Enhanced Windows On Linux Manager ==="

function show_menu() {
    echo "Choisissez une option :"
    echo "1. Configurer l'environnement complet (masquage, dépendances, anti-triche)"
    echo "2. Lancer un jeu ou une application Windows"
    echo "3. Gérer les DLL et dépendances"
    echo "4. Modifier les configurations avancées (DXVK, Wine, Registre)"
    echo "5. Configurer l'association MIME pour .exe et .msi"
    echo "6. Diagnostiquer un jeu ou une application"
    echo "7. Quitter"
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
    read -p "Votre choix : " main_choice
    case $main_choice in
        1) setup_environment ;;
        2) launch_application ;;
        5) configure_mime ;;
        6) diagnose_application ;;
        7) echo "Fermeture du gestionnaire." ; exit 0 ;;
        *) echo "Option invalide. Veuillez réessayer." ;;
    esac
done
