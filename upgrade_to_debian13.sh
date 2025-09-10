#!/bin/bash

# Script pour mettre à niveau Debian 12 (Bookworm) vers Debian 13 (Trixie)
# À n'utiliser que sur un système propre et après une sauvegarde complète.

# Étape 0 : Vérifier si le script est lancé en tant que root
if [ "$(id -u)" -ne 0 ]; then
  echo "Ce script doit être exécuté en tant que root. Utilisez 'sudo ./nom_du_script.sh'" >&2
  exit 1
fi

# Arrête le script si une commande échoue
set -e

echo "--- Étape 1/5 : Mise à jour complète de Debian 12 (Bookworm) ---"
apt update
apt upgrade -y
apt full-upgrade -y
apt autoremove -y

echo "--- Étape 2/5 : Modification des sources APT pour Debian 13 (Trixie) ---"
# Remplace toutes les occurrences de 'bookworm' par 'trixie' dans les listes de sources
sed -i 's/bookworm/trixie/g' /etc/apt/sources.list
# Fait de même pour les fichiers additionnels dans sources.list.d
for file in /etc/apt/sources.list.d/*.list; do
  if [ -f "$file" ]; then
    sed -i 's/bookworm/trixie/g' "$file"
  fi
done

echo "--- Étape 3/5 : Mise à jour de la liste des paquets depuis les nouvelles sources ---"
apt update

echo "--- Étape 4/5 : Lancement de la mise à niveau vers Debian 13 ---"
# Lance d'abord une mise à niveau simple, puis une mise à niveau complète qui gère les nouvelles dépendances
apt upgrade -y
apt full-upgrade -y

echo "--- Étape 5/5 : Nettoyage des paquets obsolètes ---"
apt autoremove -y

echo ""
echo "🚀 La mise à niveau vers Debian 13 (Trixie) est terminée !"
echo "Un redémarrage est fortement recommandé pour finaliser l'opération."
echo "Veuillez redémarrer votre système avec la commande : reboot"

exit 0
