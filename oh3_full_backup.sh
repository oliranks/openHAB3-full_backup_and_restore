#!/bin/bash
# openHAB3 Backup Script v0.1 by OliRanks

TIMESTAMP="`date +%Y%m%d_%H%M%S`";
BACKUPDIR="/home/openhabian/";
BACKUPNAME="openhab3-backup";
INFLUXDB="openhab"

if [[ $EUID -ne 0 ]]; then
echo -e " __________    _____  _________  ____  __ ____ _____________  \n \______   \  /  _  \ \_   ___ \|    |/ _|    |   \______   \ \n  |    |  _/ /  /_\  \/    \  \/|      < |    |   /|     ___/ \n  |    |   \/    |    \     \___|    |  \|    |  / |    |     \n  |______  /\____|__  /\______  /____|__ \______/  |____|     \n         \/         \/        \/        \/                   "
echo -e "   openHAB3-full_backup_and_restore v0.1 by OliRanks"
echo -e ""
echo -e "\e[96m################################################\e[0m"
echo -e "\e[96m##### \e[39mCreates a complete backup including: \e[96m#####\e[0m"
echo -e "\e[96m##### \e[39m- openHAB3                           \e[96m#####\e[0m"
echo -e "\e[96m##### \e[39m- influxdb                           \e[96m#####\e[0m"
echo -e "\e[96m##### \e[39m- grafana                            \e[96m#####\e[0m"
echo -e "\e[96m################################################\e[0m"
echo -e "This script must be run as root" 
echo -e "Usage: sudo ./oh3_full_backup.sh"
   exit 1
fi

echo -e " __________    _____  _________  ____  __ ____ _____________  \n \______   \  /  _  \ \_   ___ \|    |/ _|    |   \______   \ \n  |    |  _/ /  /_\  \/    \  \/|      < |    |   /|     ___/ \n  |    |   \/    |    \     \___|    |  \|    |  / |    |     \n  |______  /\____|__  /\______  /____|__ \______/  |____|     \n         \/         \/        \/        \/                   "
echo -e "   openHAB3-full_backup_and_restore v0.1 by OliRanks"
echo -e ""
echo -e "\e[96m################################################\e[0m"
echo -e "\e[96m##### \e[39mCreates a complete backup including: \e[96m#####\e[0m"
echo -e "\e[96m##### \e[39m- openHAB3                           \e[96m#####\e[0m"
echo -e "\e[96m##### \e[39m- influxdb                           \e[96m#####\e[0m"
echo -e "\e[96m##### \e[39m- grafana                            \e[96m#####\e[0m"
echo -e "\e[96m################################################\e[0m"
echo -e "Creating backup..."
echo -e ""
read -p "Are you sure? y/n " -n 1 -r
echo -e ""
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && echo "Ok, see you next time! ;)" && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
echo -e ""
echo -e "Saving BACKUP to: \e[92m$BACKUPDIR$BACKUPNAME-$TIMESTAMP.tar.gz\e[0m"
echo -e ""

echo -e "\e[96m#############################\e[0m"
echo -e "\e[96m##### \e[31mStopping services \e[96m#####\e[0m"
echo -e "\e[96m#############################\e[0m"
echo -e "Stopping openhab service..."
sudo systemctl stop openhab.service
echo -e "openhab service \e[31mstopped\e[0m."
echo -e "Stopping grafana server..."
sudo systemctl stop grafana-server
echo -e "Grafana server \e[31mstopped\e[0m."
echo -e ""

echo -e "\e[96m######################################\e[0m"
echo -e "\e[96m##### \e[31mTimestamp and folder setup \e[96m#####\e[0m"
echo -e "\e[96m######################################\e[0m"
echo -e "Creating main backup directory:";
sudo mkdir -v "$BACKUPDIR$BACKUPNAME-$TIMESTAMP";
echo -e "Creating openhab backup directory:";
sudo mkdir -v "$BACKUPDIR$BACKUPNAME-$TIMESTAMP/openhab";
echo -e "Creating influxdb backup directory:";
sudo mkdir -v "$BACKUPDIR$BACKUPNAME-$TIMESTAMP/influxdb";
echo -e "Creating grafana backup directory:";
sudo mkdir -v "$BACKUPDIR$BACKUPNAME-$TIMESTAMP/grafana";
echo -e ""

echo -e "\e[96m###########################\e[0m"
echo -e "\e[96m##### \e[31mopenHAB3 Backup \e[96m#####\e[0m"
echo -e "\e[96m###########################\e[0m"
echo -e "Creating openHAB3 backup..."
sudo openhab-cli backup "$BACKUPDIR$BACKUPNAME-$TIMESTAMP/openhab/openhab-backup.zip"

echo -e "\e[96m##########################\e[0m"
echo -e "\e[96m##### \e[31mGrafana Backup \e[96m#####\e[0m"
echo -e "\e[96m##########################\e[0m"
echo -e "Copying grafana config file..."
sudo cp -arv "/etc/grafana/grafana.ini" "$BACKUPDIR$BACKUPNAME-$TIMESTAMP/grafana/grafana.ini"
echo -e "Copying grafana database..."
sudo cp -arv "/var/lib/grafana/grafana.db" "$BACKUPDIR$BACKUPNAME-$TIMESTAMP/grafana/grafana.db"
echo -e ""

echo -e "\e[96m###########################\e[0m"
echo -e "\e[96m##### \e[31mInfluxdb Backup \e[96m#####\e[0m"
echo -e "\e[96m###########################\e[0m"
echo -e "Copying influxdb config file..."
sudo cp -arv "/etc/influxdb/influxdb.conf" "$BACKUPDIR$BACKUPNAME-$TIMESTAMP/influxdb/influxdb.conf"
echo -e "Exporting influxdb database..."
sudo influxd backup "$BACKUPDIR$BACKUPNAME-$TIMESTAMP/influxdb/metastore/"
sudo influxd backup -database $INFLUXDB "$BACKUPDIR$BACKUPNAME-$TIMESTAMP/influxdb/db/"
echo -e ""

echo -e "\e[96m###############################\e[0m"
echo -e "\e[96m##### \e[31mRestarting services \e[96m#####\e[0m"
echo -e "\e[96m###############################\e[0m"
echo -e "Starting openhab service..."
sudo systemctl start openhab.service
echo -e "openhab service \e[32mstarted\e[0m."
echo -e "Starting grafana server..."
sudo systemctl start grafana-server
echo -e "Grafana server \e[32mstarted\e[0m."
echo -e ""

echo -e "\e[96m##############################\e[0m"
echo -e "\e[96m##### \e[31mCompressing backup \e[96m#####\e[0m"
echo -e "\e[96m##############################\e[0m"
cd $BACKUPDIR
sudo tar cfvz $BACKUPDIR$BACKUPNAME-$TIMESTAMP.tar.gz $BACKUPNAME-$TIMESTAMP/
echo -e ""

echo -e "Backup finished!"
echo -e ""

echo -e "Total backup folder size:"
sudo du -sh -- $BACKUPDIR$BACKUPNAME-$TIMESTAMP/*
echo -e ""

echo -e "Compressed backup file size:"
sudo du -sh -- $BACKUPDIR$BACKUPNAME-$TIMESTAMP.tar.gz
echo -e ""

echo -e "\e[96m#######################\e[0m";
echo -e "\e[96m##### \e[31mCleaning up \e[96m#####\e[0m";
echo -e "\e[96m#######################\e[0m";
read -p "Delete temporary directory: $BACKUPDIR$BACKUPNAME-$TIMESTAMP? y/n " -n 1 -r
echo -e ""
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && echo -e "" && echo -e "Backup created \e[32msucessfully\e[0m! -> $BACKUPDIR$BACKUPNAME-$TIMESTAMP.tar.gz" && exit 1 || return 1
fi
echo -e "Deleting temporary directory: $BACKUPDIR$BACKUPNAME-$TIMESTAMP";
sudo rm -rf $BACKUPDIR$BACKUPNAME-$TIMESTAMP
echo -e "Temporary directory deleted.";
echo -e "";

echo -e "Backup created \e[32msucessfully\e[0m! -> $BACKUPDIR$BACKUPNAME-$TIMESTAMP.tar.gz"