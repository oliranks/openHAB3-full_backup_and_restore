#!/bin/bash
# openHAB3-full_backup_and_restore/oh3_full_restore.sh v0.1 by OliRanks - https://github.com/oliranks/openHAB3-full_backup_and_restore"

RESTOREFILE=$1
RESTOREDIR=$(basename "$RESTOREFILE" | cut -d. -f1)
TIMESTAMP="`date +%Y%m%d_%H%M%S`";
BACKUPDIR="/home/openhabian/";
BACKUPNAME="openhab3-backup";
INFLUXDB="openhab"; #influxdb database name

echo -e " _____________________ ____________________________  ____________________\n \______   \_   _____//   _____/\__    ___/\_____  \ \_____   \_   _____/\n  |       _/|    __)_ \_____  \   |    |    /   |   \|       _/|    __)_ \n  |    |   \|        \/        \  |    |   /    |    \    |   \|        \ \n  |____|_  /_______  /_______  /  |____|   \_______  /____|_  /_______  /\n         \/        \/        \/                    \/       \/        \/ ";
echo -e "   openHAB3-full_backup_and_restore v0.1 by OliRanks";
echo -e "      https://github.com/oliranks/openHAB3-full_backup_and_restore";
echo -e "";
echo -e "\e[96m#################################################\e[0m";
echo -e "\e[96m##### \e[39mRestores a complete backup including: \e[96m#####\e[0m";
echo -e "\e[96m##### \e[39m- openHAB3                            \e[96m#####\e[0m";
echo -e "\e[96m##### \e[39m- influxdb                            \e[96m#####\e[0m";
echo -e "\e[96m##### \e[39m- grafana                             \e[96m#####\e[0m";
echo -e "\e[96m#################################################\e[0m";
echo -e "This script must be run as root";
echo -e "Usage: sudo ./oh3_full_restore.sh filename.tar.gz";
usage() {
    exit $1
}
fatal() {
    echo error: $*
    usage 1
}
[ "$1" = -h ] && usage 0
[ $# -lt 1 ] && fatal missing arguments

if [[ $EUID -ne 0 ]]; then
echo -e " _____________________ ____________________________  ____________________\n \______   \_   _____//   _____/\__    ___/\_____  \ \_____   \_   _____/\n  |       _/|    __)_ \_____  \   |    |    /   |   \|       _/|    __)_ \n  |    |   \|        \/        \  |    |   /    |    \    |   \|        \ \n  |____|_  /_______  /_______  /  |____|   \_______  /____|_  /_______  /\n         \/        \/        \/                    \/       \/        \/ ";
echo -e "   openHAB3-full_backup_and_restore v0.1 by OliRanks";
echo -e "      https://github.com/oliranks/openHAB3-full_backup_and_restore";
echo -e "";
echo -e "\e[96m#################################################\e[0m";
echo -e "\e[96m##### \e[39mRestores a complete backup including: \e[96m#####\e[0m";
echo -e "\e[96m##### \e[39m- openHAB3                            \e[96m#####\e[0m";
echo -e "\e[96m##### \e[39m- influxdb                            \e[96m#####\e[0m";
echo -e "\e[96m##### \e[39m- grafana                             \e[96m#####\e[0m";
echo -e "\e[96m#################################################\e[0m";
echo -e "This script must be run as root";
echo -e "Usage: sudo ./oh3_full_restore.sh filename.tar.gz";
   exit 1
   
fi
if [ ! -f "$RESTOREFILE" ]
then
echo -e " _____________________ ____________________________  ____________________\n \______   \_   _____//   _____/\__    ___/\_____  \ \_____   \_   _____/\n  |       _/|    __)_ \_____  \   |    |    /   |   \|       _/|    __)_ \n  |    |   \|        \/        \  |    |   /    |    \    |   \|        \ \n  |____|_  /_______  /_______  /  |____|   \_______  /____|_  /_______  /\n         \/        \/        \/                    \/       \/        \/ ";
echo -e "   openHAB3-full_backup_and_restore v0.1 by OliRanks";
echo -e "      https://github.com/oliranks/openHAB3-full_backup_and_restore";
echo -e "";
echo -e "\e[96m#################################################\e[0m";
echo -e "\e[96m##### \e[39mRestores a complete backup including: \e[96m#####\e[0m";
echo -e "\e[96m##### \e[39m- openHAB3                            \e[96m#####\e[0m";
echo -e "\e[96m##### \e[39m- influxdb                            \e[96m#####\e[0m";
echo -e "\e[96m##### \e[39m- grafana                             \e[96m#####\e[0m";
echo -e "\e[96m#################################################\e[0m";
echo -e "This script must be run as root";
echo -e "Usage: sudo ./oh3_full_restore.sh filename.tar.gz";
echo -e "";
echo -e "$RESTOREFILE does not exist";
    exit 1
fi
echo -e " _____________________ ____________________________  ____________________\n \______   \_   _____//   _____/\__    ___/\_____  \ \_____   \_   _____/\n  |       _/|    __)_ \_____  \   |    |    /   |   \|       _/|    __)_ \n  |    |   \|        \/        \  |    |   /    |    \    |   \|        \ \n  |____|_  /_______  /_______  /  |____|   \_______  /____|_  /_______  /\n         \/        \/        \/                    \/       \/        \/ ";
echo -e "   openHAB3-full_backup_and_restore v0.1 by OliRanks";
echo -e "      https://github.com/oliranks/openHAB3-full_backup_and_restore";
echo -e "";
echo -e "\e[96m#################################################\e[0m";
echo -e "\e[96m##### \e[39mRestores a complete backup including: \e[96m#####\e[0m";
echo -e "\e[96m##### \e[39m- openHAB3                            \e[96m#####\e[0m";
echo -e "\e[96m##### \e[39m- influxdb                            \e[96m#####\e[0m";
echo -e "\e[96m##### \e[39m- grafana                             \e[96m#####\e[0m";
echo -e "\e[96m#################################################\e[0m";
#echo -e "Usage: sudo ./oh3_full_restore.sh filename.tar.gz";
echo -e "Restoring backup from file: \e[31m$RESTOREFILE\e[0m";
echo -e "";
read -p "Are you sure? y/n " -n 1 -r
echo -e "";
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && echo "Ok, see you next time! ;)" && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
echo -e "";

echo -e "\e[96m#############################\e[0m";
echo -e "\e[96m##### \e[31mStopping services \e[96m#####\e[0m";
echo -e "\e[96m#############################\e[0m";
echo -e "Stopping openhab service...";
sudo systemctl stop openhab.service
echo -e "openhab service \e[31mstopped\e[0m.";
echo -e "Stopping grafana server...";
sudo systemctl stop grafana-server
echo -e "Grafana server \e[31mstopped\e[0m.";
echo -e "Stopping influxdb server...";
sudo systemctl stop influxdb
echo -e "Influxdb server \e[31mstopped\e[0m.";
echo -e "";

echo -e "\e[96m######################################\e[0m";
echo -e "\e[96m##### \e[31mTimestamp and folder setup \e[96m#####\e[0m";
echo -e "\e[96m######################################\e[0m";
echo -e "Checking if old backup directory is present:";
if [ -d "$BACKUPDIR$RESTOREDIR" ] 
then
    echo -e "Directory $BACKUPDIR$RESTOREDIR exists.";
	echo -e "Deleting old backup directory:";
else
    echo "Directory $BACKUPDIR$RESTOREDIR does not exists.";
fi
sudo rm -rfv "$BACKUPDIR$RESTOREDIR";
echo -e "Extracting main backup file:";
sudo tar xvzf $RESTOREFILE;
echo -e "";

echo -e "\e[96m############################\e[0m";
echo -e "\e[96m##### \e[31mopenHAB3 Restore \e[96m#####\e[0m";
echo -e "\e[96m############################\e[0m";
echo -e "Restoring openHAB3 backup...";
sudo openhab-cli restore "$BACKUPDIR$RESTOREDIR/openhab/openhab-backup.zip";

echo -e "\e[96m###########################\e[0m";
echo -e "\e[96m##### \e[31mGrafana Restore \e[96m#####\e[0m";
echo -e "\e[96m###########################\e[0m";
echo -e "Restoring grafana config file...";
sudo cp -arv "$BACKUPDIR$RESTOREDIR/grafana/grafana.ini" "/etc/grafana/grafana.ini";
echo -e "Restoring grafana database...";
sudo cp -arv "$BACKUPDIR$RESTOREDIR/grafana/grafana.db" "/var/lib/grafana/grafana.db";
echo -e "";

echo -e "\e[96m############################\e[0m";
echo -e "\e[96m##### \e[31mInfluxdb Restore \e[96m#####\e[0m";
echo -e "\e[96m############################\e[0m";
echo -e "Restoring influxdb config file...";
sudo cp -arv "$BACKUPDIR$RESTOREDIR/influxdb/influxdb.conf" "/etc/influxdb/influxdb.conf";
echo -e "Importing influxdb metadata...";
sudo influxd restore -metadir /var/lib/influxdb/meta "$BACKUPDIR$RESTOREDIR/influxdb/metastore/"
echo -e "Importing influxdb database...";
sudo influxd restore -database $INFLUXDB -datadir /var/lib/influxdb/data "$BACKUPDIR$RESTOREDIR/influxdb/db/"
echo -e "";

echo -e "\e[96m###############################\e[0m";
echo -e "\e[96m##### \e[31mRestarting services \e[96m#####\e[0m";
echo -e "\e[96m###############################\e[0m";
echo -e "Starting openhab service...";
sudo systemctl start openhab.service
echo -e "openhab service \e[32mstarted\e[0m.";
echo -e "Starting grafana server...";
sudo systemctl start grafana-server
echo -e "Grafana server \e[32mstarted\e[0m.";
echo -e "Starting influxdb server...";
sudo systemctl start influxdb
echo -e "influxdb server \e[32mstarted\e[0m.";
echo -e "";

echo -e "\e[96m#######################\e[0m";
echo -e "\e[96m##### \e[31mCleaning up \e[96m#####\e[0m";
echo -e "\e[96m#######################\e[0m";
read -p "Delete temporary directory: $BACKUPDIR$RESTOREDIR? y/n " -n 1 -r
echo -e "";
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && echo -e "" && echo -e "Backup restored \e[32msucessfully\e[0m! <- $BACKUPDIR$RESTOREDIR" && exit 1 || return 1
fi
echo -e "Deleting temporary directory: $BACKUPDIR$RESTOREDIR";
sudo rm -rf $BACKUPDIR$RESTOREDIR
echo -e "Temporary directory deleted.";
echo -e "";

echo -e "Backup restored \e[32msucessfully\e[0m! <- $BACKUPDIR$RESTOREFILE";
