#!/bin/bash

# Script d'installation des alias les plus fréquents
# Compatible avec Debian/Ubuntu et dérivés

set -e

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fichier de destination
ALIAS_FILE="$HOME/.bash_aliases"
BASHRC_FILE="$HOME/.bashrc"

echo -e "${GREEN}=== Installation des alias système ===${NC}"
echo ""

# Création d'une sauvegarde si le fichier existe
if [ -f "$ALIAS_FILE" ]; then
    BACKUP_FILE="${ALIAS_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$ALIAS_FILE" "$BACKUP_FILE"
    echo -e "${YELLOW}Sauvegarde créée : $BACKUP_FILE${NC}"
fi

# Création du fichier d'alias
cat > "$ALIAS_FILE" << 'EOF'
# ============================================
# Alias système - Configuration personnalisée
# ============================================

# --- Navigation et listage ---
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias lh='ls -lh'
alias lt='ls -lt'
alias ltr='ls -ltr'
alias lsize='ls -lSh'
alias tree='tree -C'

# --- Navigation rapide ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cd..='cd ..'
alias back='cd -'
alias home='cd ~'

# --- Grep avec couleurs ---
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rgrep='grep -r --color=auto'

# --- Gestion des fichiers ---
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias mkdir='mkdir -pv'
alias rmdir='rmdir -v'
alias df='df -h'
alias du='du -h'
alias duf='du -sh *'
alias free='free -h'

# --- Éditeurs ---
alias nano='nano -W'
alias vi='vim'
alias svi='sudo vi'
alias snano='sudo nano'

# --- Système et processus ---
alias ps='ps auxf'
alias psg='ps aux | grep -v grep | grep -i'
alias top='htop 2>/dev/null || top'
alias mem='free -h && echo && ps aux | head -1 && ps aux | sort -rnk 4 | head -10'
alias cpu='ps aux | head -1 && ps aux | sort -rnk 3 | head -10'
alias ports='netstat -tulanp'
alias listening='netstat -tulpn | grep LISTEN'
alias services='systemctl list-units --type=service --state=running'

# --- APT / Gestion des paquets ---
alias update='sudo apt update'
alias upgrade='sudo apt update && sudo apt upgrade'
alias search='apt search'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias autoremove='sudo apt autoremove'
alias clean='sudo apt clean && sudo apt autoclean'
alias policy='apt policy'
alias show='apt show'

# --- Réseau ---
alias myip='curl -s ifconfig.me && echo'
alias localip='hostname -I | awk "{print \$1}"'
alias ping='ping -c 5'
alias fastping='ping -c 100 -i 0.2'
alias wget='wget -c'
alias curl='curl -w "\n"'

# --- Archives ---
alias untar='tar -xvf'
alias targz='tar -czf'
alias unzip='unzip -v'

# --- Historique ---
alias h='history'
alias hgrep='history | grep'
alias histop='history | awk "{print \$2}" | sort | uniq -c | sort -rn | head -20'

# --- Git (si installé) ---
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# --- Docker (si installé) ---
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs'
alias dstop='docker stop'
alias dstart='docker start'
alias drm='docker rm'
alias drmi='docker rmi'
alias dprune='docker system prune -a'

# --- Systemctl ---
alias sctl='systemctl'
alias sstart='sudo systemctl start'
alias sstop='sudo systemctl stop'
alias srestart='sudo systemctl restart'
alias sstatus='systemctl status'
alias senable='sudo systemctl enable'
alias sdisable='sudo systemctl disable'

# --- Journalctl ---
alias jctl='journalctl'
alias jctlf='journalctl -f'
alias jctlu='journalctl -u'

# --- Sécurité ---
alias chmod='chmod -v'
alias chown='chown -v'
alias passwd='passwd -S'

# --- Divers ---
alias cls='clear'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias week='date +%V'
alias path='echo -e ${PATH//:/\\n}'
alias reload='source ~/.bashrc'
alias aliases='cat ~/.bash_aliases'
alias ealias='nano ~/.bash_aliases && source ~/.bashrc'
alias ebash='nano ~/.bashrc && source ~/.bashrc'
alias weather='curl wttr.in'
alias calc='bc -l'
alias mounted='mount | column -t'
alias findfile='find . -type f -name'
alias finddir='find . -type d -name'
alias biggest='find . -type f -exec du -Sh {} + | sort -rh | head -20'

# --- Fonctions utiles ---

# Créer et entrer dans un répertoire
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extraction universelle d'archives
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.bz2)       bunzip2 "$1"   ;;
            *.rar)       unrar e "$1"   ;;
            *.gz)        gunzip "$1"    ;;
            *.tar)       tar xf "$1"    ;;
            *.tbz2)      tar xjf "$1"   ;;
            *.tgz)       tar xzf "$1"   ;;
            *.zip)       unzip "$1"     ;;
            *.Z)         uncompress "$1";;
            *.7z)        7z x "$1"      ;;
            *)           echo "'$1' ne peut pas être extrait via extract()" ;;
        esac
    else
        echo "'$1' n'est pas un fichier valide"
    fi
}

# Backup rapide d'un fichier
backup() {
    if [ -f "$1" ]; then
        cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
        echo "Backup créé : $1.backup.$(date +%Y%m%d_%H%M%S)"
    else
        echo "Le fichier '$1' n'existe pas"
    fi
}

# Recherche dans l'historique
hist() {
    history | grep -i "$1"
}

# Afficher les couleurs disponibles
colors() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
    done
}

# Informations système rapides
sysinfo() {
    echo "=== Informations Système ==="
    echo "Hostname: $(hostname)"
    echo "IP Local: $(hostname -I | awk '{print $1}')"
    echo "IP Public: $(curl -s ifconfig.me)"
    echo "OS: $(lsb_release -d | cut -f2)"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p)"
    echo "CPU: $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
    echo "Mémoire: $(free -h | grep Mem | awk '{print $3 " / " $2}')"
    echo "Disque: $(df -h / | tail -1 | awk '{print $3 " / " $2 " (" $5 ")"}')"
}

# Afficher le top 10 des fichiers/dossiers les plus gros
top10() {
    du -hsx * | sort -rh | head -10
}

# Recherche de processus et kill
pskill() {
    if [ -z "$1" ]; then
        echo "Usage: pskill <nom_processus>"
        return 1
    fi
    ps aux | grep -i "$1" | grep -v grep
    echo ""
    read -p "Tuer ces processus ? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pkill -f "$1"
        echo "Processus tués."
    fi
}

EOF

echo -e "${GREEN}✓ Fichier d'alias créé : $ALIAS_FILE${NC}"

# Vérification et ajout de la source dans .bashrc
if ! grep -q "source.*\.bash_aliases" "$BASHRC_FILE" 2>/dev/null && \
   ! grep -q "\. .*\.bash_aliases" "$BASHRC_FILE" 2>/dev/null; then
    echo "" >> "$BASHRC_FILE"
    echo "# Chargement des alias personnalisés" >> "$BASHRC_FILE"
    echo "if [ -f ~/.bash_aliases ]; then" >> "$BASHRC_FILE"
    echo "    . ~/.bash_aliases" >> "$BASHRC_FILE"
    echo "fi" >> "$BASHRC_FILE"
    echo -e "${GREEN}✓ Configuration ajoutée à .bashrc${NC}"
else
    echo -e "${YELLOW}ℹ Les alias sont déjà configurés dans .bashrc${NC}"
fi

# Création d'un fichier de documentation
DOC_FILE="$HOME/.bash_aliases_help.txt"
cat > "$DOC_FILE" << 'EOF'
DOCUMENTATION DES ALIAS INSTALLÉS
==================================

NAVIGATION:
  ll        - Liste détaillée avec types de fichiers
  la        - Liste tous les fichiers (cachés inclus)
  lh        - Liste avec tailles humaines
  lt        - Liste triée par date
  lsize     - Liste triée par taille
  ..        - Remonter d'un niveau
  ...       - Remonter de 2 niveaux

SYSTÈME:
  update    - Mettre à jour la liste des paquets
  upgrade   - Mettre à jour le système
  mem       - Afficher l'utilisation mémoire
  cpu       - Afficher l'utilisation CPU
  ports     - Afficher les ports ouverts
  services  - Lister les services actifs
  sysinfo   - Informations système complètes

RÉSEAU:
  myip      - Afficher l'IP publique
  localip   - Afficher l'IP locale

FONCTIONS:
  mkcd <dir>     - Créer et entrer dans un dossier
  extract <file> - Extraire une archive
  backup <file>  - Créer une copie de sauvegarde
  hist <terme>   - Chercher dans l'historique
  pskill <nom>   - Rechercher et tuer un processus
  top10          - Top 10 des plus gros fichiers/dossiers

RACCOURCIS:
  reload    - Recharger la configuration bash
  ealias    - Éditer les alias
  aliases   - Afficher tous les alias

Pour plus de détails, consultez : ~/.bash_aliases
EOF

echo -e "${GREEN}✓ Documentation créée : $DOC_FILE${NC}"
echo ""
echo -e "${GREEN}=== Installation terminée ===${NC}"
echo ""
echo -e "${YELLOW}Pour activer les alias immédiatement :${NC}"
echo -e "  ${GREEN}source ~/.bashrc${NC}"
echo ""
echo -e "${YELLOW}Pour voir la documentation :${NC}"
echo -e "  ${GREEN}cat ~/.bash_aliases_help.txt${NC}"
echo ""
echo -e "${YELLOW}Pour éditer les alias :${NC}"
echo -e "  ${GREEN}nano ~/.bash_aliases${NC}"
