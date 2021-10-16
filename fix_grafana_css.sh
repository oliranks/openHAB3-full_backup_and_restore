#!/bin/bash
# fix_grafana_css.sh v0.1 by oliranks - 
# adds custom css to grafana index.html. place custom content in fix_grafana_css.css

FILE="/usr/share/grafana/public/views/index.html"
BLA="/home/openhabian/fix/fixgrafana.css" 

if [[ $EUID -ne 0 ]]; then
echo -e "  __________________    _____  ________________    _______      _____    \n /  _____/\______   \  /  _  \ \_   _____/  _  \   \      \    /  _  \   \n/   \  ___ |       _/ /  /_\  \ |    __)/  /_\  \  /   |   \  /  /_\  \  \n\    \_\  \|    |   \/    |    \|     \/    |    \/    |    \/    |    \ \n \______  /|____|_  /\____|__  /\___  /\____|__  /\____|__  /\____|__  / \n   CSS  \/        \/         \/     \/         \/         \/   FIX   \/ ";
echo -e "";
echo -e "error: This script must be run as root";
   exit 1
fi

echo -e "  __________________    _____  ________________    _______      _____    \n /  _____/\______   \  /  _  \ \_   _____/  _  \   \      \    /  _  \   \n/   \  ___ |       _/ /  /_\  \ |    __)/  /_\  \  /   |   \  /  /_\  \  \n\    \_\  \|    |   \/    |    \|     \/    |    \/    |    \/    |    \ \n \______  /|____|_  /\____|__  /\___  /\____|__  /\____|__  /\____|__  / \n   CSS  \/        \/         \/     \/         \/         \/   FIX   \/ ";
echo -e "Adds custom css from fix_grafana_css.css to $FILE.";
echo -e "";
echo -e "Fixing grafana css:";
read -p "Are you sure? y/N " -n 1 -r
echo -e "";
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && echo "Ok, see you next time! ;)" && exit 1 || return 1
fi
echo -e "";

sudo sed  "/<\/title>/ r $BLA" "$FILE" > TMP1
sudo mv TMP1 "$FILE"
echo -e "Done!";