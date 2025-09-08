# Scripts d'Administration pour Debian 🐧

## 🚀 `launch-all-containers.sh`

Ce script est un outil puissant pour gérer un environnement Docker composé de plusieurs services, chacun défini dans son propre fichier `docker-compose-*.yml`. Il automatise le processus de mise à jour et de lancement de l'ensemble de votre stack.

### ✨ Fonctionnalités

  * **Scan automatique** : Trouve tous les fichiers `docker-compose-*.yml` dans le répertoire spécifié.
  * **Mise à jour des images** : Avant de lancer un service, le script tente de "pull" la dernière version de l'image Docker correspondante.
  * **Lancement isolé** : Chaque fichier est traité comme un projet Docker Compose distinct, évitant les conflits de noms.
  * **Rapport clair** : Affiche un récapitulatif final indiquant quels services ont été mis à jour, lesquels étaient déjà à jour et ceux qui ont rencontré des erreurs.

### 📋 Utilisation

Rendez le script exécutable, puis lancez-le.

```bash
# Rendre le script exécutable
chmod +x launch-all-containers.sh

# Lancer les conteneurs dans le répertoire courant
./launch-all-containers.sh

# Lancer en mode verbeux pour plus de détails
./launch-all-containers.sh -v

# Cibler un répertoire spécifique
./launch-all-containers.sh /chemin/vers/vos/docker-compose
```

-----

## 🎨 `create_aliases.sh`

Ce script installe un ensemble complet d'alias et de fonctions `bash` pour rendre votre travail en ligne de commande plus rapide, plus efficace et plus agréable. Il sauvegarde automatiquement votre configuration existante avant toute modification.

### ✨ Fonctionnalités

  * **Installation "One-Shot"** : Exécutez le script une seule fois pour configurer votre environnement.
  * **Raccourcis Intuitifs** : Des centaines d'alias pour les commandes les plus courantes (`ll`, `dps`, `update`, `upgrade`...).
  * **Fonctions Puissantes** : Des mini-scripts comme `extract` pour décompresser n'importe quelle archive, `pskill` pour trouver et tuer des processus, ou `sysinfo` pour un aperçu rapide du système.
  * **Organisation Propre** : Tous les alias sont stockés dans le fichier `~/.bash_aliases`, laissant votre `~/.bashrc` propre.

### 📋 Utilisation

1.  **Exécutez le script** :
    ```bash
    ./create_aliases.sh
    ```
2.  **Rechargez votre session shell** pour que les alias soient pris en compte :
    ```bash
    source ~/.bashrc
    ```

### 💡 Quelques alias inclus

| Alias | Commande originale | Description |
| :--- | :--- | :--- |
| `ll` | `ls -alF` | Affiche une liste détaillée des fichiers. |
| `dpsa`| `docker ps -a` | Liste tous les conteneurs Docker (actifs et inactifs). |
| `upgrade`| `sudo apt update && sudo apt upgrade` | Met à jour entièrement le système. |
| `myip`| `curl -s ifconfig.me` | Affiche votre adresse IP publique. |
| `ealias`| `nano ~/.bash_aliases && source ~/.bashrc` | Ouvre le fichier d'alias pour l'éditer, puis le recharge. |
| **`sysinfo`** | (Fonction) | Affiche un résumé complet de l'état du système (IP, OS, CPU, RAM...). |
| **`extract <fichier>`** | (Fonction) | Extrait intelligemment n'importe quel type d'archive (`.zip`, `.tar.gz`, etc.). |
