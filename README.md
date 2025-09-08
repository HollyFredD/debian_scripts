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

### 💡 Liste des aliases

Bien sûr. Voici la liste exhaustive de tous les alias et fonctions définis dans le script `create_aliases.sh`, classés par catégorie pour plus de clarté.

---

### 📂 Navigation et Listage

| Alias | Commande | Description |
| :--- | :--- | :--- |
| `ll` | `ls -alF` | Liste détaillée, incluant les fichiers cachés et les types. |
| `la` | `ls -A` | Liste tous les fichiers, y compris les cachés (sauf `.` et `..`). |
| `l` | `ls -CF` | Liste simple en colonnes. |
| `ls` | `ls --color=auto` | Active les couleurs pour la commande `ls`. |
| `lh` | `ls -lh` | Liste avec des tailles de fichiers lisibles (Ko, Mo, Go). |
| `lt` | `ls -lt` | Liste les fichiers triés par date de modification. |
| `ltr` | `ls -ltr` | Liste les fichiers triés par date (du plus ancien au plus récent). |
| `lsize` | `ls -lSh` | Liste les fichiers triés par taille (du plus grand au plus petit). |
| `tree` | `tree -C` | Affiche l'arborescence des répertoires avec des couleurs. |
| `..` | `cd ..` | Remonte d'un répertoire. |
| `...` | `cd ../..` | Remonte de deux répertoires. |
| `....` | `cd ../../..` | Remonte de trois répertoires. |
| `.....` | `cd ../../../..`| Remonte de quatre répertoires. |
| `cd..` | `cd ..` | Remonte d'un répertoire (pour les habitudes Windows). |
| `back` | `cd -` | Retourne au répertoire précédent. |
| `home` | `cd ~` | Va au répertoire personnel. |

---

### 📄 Gestion des Fichiers

| Alias | Commande | Description |
| :--- | :--- | :--- |
| `cp` | `cp -iv` | Copie des fichiers en mode interactif (demande confirmation) et verbeux. |
| `mv` | `mv -iv` | Déplace des fichiers en mode interactif et verbeux. |
| `rm` | `rm -Iv` | Supprime des fichiers avec une confirmation (important pour éviter les erreurs). |
| `mkdir` | `mkdir -pv` | Crée des répertoires, y compris les parents, et affiche le résultat. |
| `rmdir` | `rmdir -v` | Supprime des répertoires vides en mode verbeux. |
| `df` | `df -h` | Affiche l'utilisation des disques avec des tailles lisibles. |
| `du` | `du -h` | Affiche la taille des fichiers/dossiers du répertoire courant. |
| `duf` | `du -sh *` | Affiche la taille totale de chaque fichier/dossier du répertoire courant. |
| `free` | `free -h` | Affiche l'utilisation de la mémoire vive (RAM) et du swap. |

---

### ✍️ Éditeurs

| Alias | Commande | Description |
| :--- | :--- | :--- |
| `nano` | `nano -W` | Lance l'éditeur Nano. |
| `vi` | `vim` | Lance l'éditeur Vim. |
| `svi` | `sudo vi` | Ouvre Vim avec les droits superutilisateur. |
| `snano` | `sudo nano` | Ouvre Nano avec les droits superutilisateur. |

---

### ⚙️ Système et Processus

| Alias | Commande | Description |
| :--- | :--- | :--- |
| `ps` | `ps auxf` | Affiche les processus en cours avec une arborescence. |
| `psg` | `ps aux \| grep`| Cherche un processus par son nom. |
| `top` | `htop` ou `top` | Lance `htop` (si installé), sinon `top` pour un monitoring interactif. |
| `mem` | `free -h && ...`| Affiche l'utilisation de la RAM et les 10 processus les plus gourmands. |
| `cpu` | `ps aux \| ...` | Affiche les 10 processus qui consomment le plus de CPU. |
| `ports` | `netstat -tulanp`| Affiche tous les ports ouverts et les connexions actives. |
| `listening`| `netstat -tulpn`| N'affiche que les ports en écoute (services). |
| `services` | `systemctl ...` | Liste tous les services `systemd` actuellement actifs. |

---

### 📦 Gestion des Paquets (APT)

| Alias | Commande | Description |
| :--- | :--- | :--- |
| `update` | `sudo apt update`| Met à jour la liste des paquets disponibles. |
| `upgrade` | `sudo apt update && sudo apt upgrade` | Met à jour la liste des paquets ET installe les mises à jour. |
| `search` | `apt search` | Cherche un paquet dans les dépôts. |
| `install` | `sudo apt install`| Installe un paquet. |
| `remove` | `sudo apt remove`| Supprime un paquet. |
| `autoremove` | `sudo apt autoremove`| Supprime les dépendances inutiles. |
| `clean` | `sudo apt clean && sudo apt autoclean` | Nettoie le cache des paquets téléchargés. |
| `policy` | `apt policy` | Affiche les informations sur un paquet (version installée, etc.). |
| `show` | `apt show` | Affiche les détails d'un paquet. |

---

### 🌐 Réseau

| Alias | Commande | Description |
| :--- | :--- | :--- |
| `myip` | `curl -s ifconfig.me` | Affiche votre adresse IP publique. |
| `localip` | `hostname -I` | Affiche votre adresse IP locale. |
| `ping` | `ping -c 5` | Envoie 5 pings à une adresse. |
| `fastping` | `ping -c 100 -i 0.2` | Envoie 100 pings très rapidement. |
| `wget` | `wget -c` | Télécharge un fichier en permettant de reprendre le téléchargement. |
| `curl` | `curl -w "\n"` | Utilise `curl` et ajoute un retour à la ligne à la fin. |

---

### 🐳 Docker

| Alias | Commande | Description |
| :--- | :--- | :--- |
| `dps` | `docker ps` | Liste les conteneurs actifs. |
| `dpsa` | `docker ps -a` | Liste tous les conteneurs (actifs et arrêtés). |
| `di` | `docker images` | Liste les images Docker locales. |
| `dex` | `docker exec -it`| Exécute une commande dans un conteneur en mode interactif. |
| `dlog` | `docker logs` | Affiche les logs d'un conteneur. |
| `dstop` | `docker stop` | Arrête un conteneur. |
| `dstart` | `docker start` | Démarre un conteneur. |
| `drm` | `docker rm` | Supprime un conteneur. |
| `drmi` | `docker rmi` | Supprime une image. |
| `dprune` | `docker system prune -a` | Nettoie tout Docker (conteneurs, images, volumes non utilisés). |

---

### 🛠️ Fonctions Utiles

| Fonction | Usage | Description |
| :--- | :--- | :--- |
| `mkcd` | `mkcd <nom_dossier>` | Crée un répertoire et se place directement à l'intérieur. |
| `extract` | `extract <fichier.zip>` | Décompresse intelligemment n'importe quel type d'archive (`.zip`, `.tar.gz`, `.rar`...). |
| `backup` | `backup <nom_fichier>` | Crée une copie de sauvegarde d'un fichier avec la date et l'heure. |
| `hist` | `hist <terme>` | Cherche un mot dans votre historique de commandes. |
| `sysinfo` | `sysinfo` | Affiche un résumé complet de l'état du système (IP, OS, CPU, RAM...). |
| `top10` | `top10` | Affiche les 10 plus gros fichiers ou dossiers du répertoire courant. |
| `pskill` | `pskill <nom_processus>` | Recherche les processus contenant un nom et propose de les tuer. |

---

### ✨ Divers

| Alias | Commande | Description |
| :--- | :--- | :--- |
| `cls` | `clear` | Nettoie l'écran du terminal. |
| `reload` | `source ~/.bashrc` | Recharge la configuration du shell sans se déconnecter. |
| `aliases` | `cat ~/.bash_aliases` | Affiche le contenu du fichier d'alias. |
| `ealias` | `nano ~/.bash_aliases && source ~/.bashrc`| Édite le fichier d'alias, puis le recharge immédiatement. |
| `ebash` | `nano ~/.bashrc && source ~/.bashrc` | Édite le fichier `.bashrc`, puis le recharge. |
