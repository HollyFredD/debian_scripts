#!/bin/bash

# Script de lancement optimisé pour tous les docker-compose
# Usage: ./launch-all-containers.sh [-v] [directory]
#   -v : Mode verbeux (plus de détails)
#   directory : Répertoire à scanner (défaut: répertoire courant)

# Variables
VERBOSE=false
DIR="."
SUCCESS_COUNT=0
ERROR_COUNT=0
UNCHANGED_COUNT=0
SUCCESS_FILES=()
ERROR_FILES=()
UNCHANGED_FILES=()

# Fonction d'aide
show_help() {
    echo "Usage: $0 [-v] [-h] [directory]"
    echo ""
    echo "Options:"
    echo "  -v, --verbose    Mode verbeux avec plus de détails"
    echo "  -h, --help       Affiche cette aide"
    echo "  directory        Répertoire à scanner (défaut: répertoire courant)"
    echo ""
    echo "Exemples:"
    echo "  $0                    # Lance tous les docker-compose du répertoire courant"
    echo "  $0 -v                 # Mode verbeux"
    echo "  $0 /path/to/configs   # Lance les docker-compose du répertoire spécifié"
    echo "  $0 -v /path/to/configs # Mode verbeux avec répertoire spécifié"
}

# Fonction de log verbeux
log_verbose() {
    if [ "$VERBOSE" = true ]; then
        echo "$1"
    fi
}

# Fonction de log normal (toujours affiché)
log_info() {
    echo "$1"
}

# Fonction de log d'erreur
log_error() {
    echo "❌ ERREUR: $1" >&2
}

# Parse des arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -*)
            log_error "Option inconnue: $1"
            show_help
            exit 1
            ;;
        *)
            DIR="$1"
            shift
            ;;
    esac
done

# Vérification du répertoire
if [ ! -d "$DIR" ]; then
    log_error "Le répertoire '$DIR' n'existe pas"
    exit 1
fi

# Début du traitement
if [ "$VERBOSE" = true ]; then
    log_info "🔍 Recherche des fichiers docker-compose dans $DIR"
else
    log_info "🚀 Lancement et mise à jour des conteneurs..." # <--- MODIFICATION MINEURE (texte)
fi

# Comptage des fichiers disponibles
file_count=0
for file in "$DIR"/docker-compose*.yml; do
    [ -f "$file" ] && ((file_count++))
done

if [ $file_count -eq 0 ]; then
    log_error "Aucun fichier docker-compose*.yml trouvé dans $DIR"
    exit 1
fi

log_verbose "📋 $file_count fichier(s) docker-compose trouvé(s)"

# Traitement des fichiers
for file in "$DIR"/docker-compose*.yml; do
    # Vérifie que le fichier existe vraiment
    [ -f "$file" ] || continue

    # Génère un nom de projet unique basé sur le nom du fichier sans extension
    project_name=$(basename "$file" .yml)
    
    log_verbose "----------------------------------------"
    log_verbose "📦 Traitement de $file (projet: $project_name)"

    # --- MODIFICATION PRINCIPALE ---
    # Étape 1 : Forcer la mise à jour de l'image
    log_verbose "🔄 Vérification des mises à jour de l'image pour $project_name..."
    if ! docker compose -f "$file" --project-name "$project_name" pull > /dev/null 2>&1; then
        log_verbose "⚠️  Avertissement: Échec du pull pour $project_name. L'image locale sera utilisée."
    fi
    # --- FIN DE LA MODIFICATION PRINCIPALE ---

    # Étape 2 : Lancer le conteneur (maintenant avec l'image à jour)
    log_verbose "🚀 Lancement du conteneur pour $project_name..." # <--- MODIFICATION MINEURE (log)

    # Capture de la sortie docker compose
    if [ "$VERBOSE" = true ]; then
        # Mode verbeux : affiche tout
        if docker compose -f "$file" --project-name "$project_name" up -d --remove-orphans; then
            log_info "✅ $project_name: Succès"
            SUCCESS_FILES+=("$project_name")
            ((SUCCESS_COUNT++))
        else
            log_error "$project_name: Échec du lancement"
            ERROR_FILES+=("$project_name")
            ((ERROR_COUNT++))
        fi
    else
        # Mode silencieux : capture la sortie
        output=$(docker compose -f "$file" --project-name "$project_name" up -d --remove-orphans 2>&1)
        exit_code=$?
        
        if [ $exit_code -eq 0 ]; then
            # Vérifier si des conteneurs ont été modifiés
            if echo "$output" | grep -q "Started\|Created\|Recreated\|Pulled"; then # <--- MODIFICATION (ajout de "Pulled")
                echo "✅ $project_name"
                SUCCESS_FILES+=("$project_name")
                ((SUCCESS_COUNT++))
            else
                echo "⚪ $project_name (aucun changement)"
                UNCHANGED_FILES+=("$project_name")
                ((UNCHANGED_COUNT++))
            fi
        else
            echo "❌ $project_name"
            log_error "Détails: $output"
            ERROR_FILES+=("$project_name")
            ((ERROR_COUNT++))
        fi
    fi
done

# Récapitulatif final
echo ""
echo "📊 RÉCAPITULATIF"
echo "=================="
echo "🎯 Total traité: $((SUCCESS_COUNT + ERROR_COUNT + UNCHANGED_COUNT)) fichier(s)"
echo "✅ Succès (modifiés ou mis à jour): $SUCCESS_COUNT" # <--- MODIFICATION MINEURE (texte)
echo "❌ Erreurs: $ERROR_COUNT"
echo "⚪ Inchangés: $UNCHANGED_COUNT"

# Détails par catégorie
if [ ${#SUCCESS_FILES[@]} -gt 0 ]; then
    echo ""
    echo "✅ CONTENEURS MODIFIÉS OU MIS À JOUR:" # <--- MODIFICATION MINEURE (texte)
    printf "   • %s\n" "${SUCCESS_FILES[@]}"
fi

if [ ${#ERROR_FILES[@]} -gt 0 ]; then
    echo ""
    echo "❌ ERREURS:"
    printf "   • %s\n" "${ERROR_FILES[@]}"
fi

if [ ${#UNCHANGED_FILES[@]} -gt 0 ] && [ "$VERBOSE" = true ]; then
    echo ""
    echo "⚪ AUCUN CHANGEMENT:"
    printf "   • %s\n" "${UNCHANGED_FILES[@]}"
fi

# Code de sortie
if [ $ERROR_COUNT -gt 0 ]; then
    echo ""
    echo "⚠️  Le script s'est terminé avec des erreurs"
    exit 1
else
    echo ""
    echo "🎉 Tous les fichiers docker-compose ont été traités avec succès"
    exit 0
fi