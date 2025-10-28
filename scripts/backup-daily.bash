#! /bin/bash

# Variables
ServerPath="/home/enshrouded/enshroudedserver/"     # Where the server is
BackupPath="/home/enshrouded/backups/daily/"        # Where the backup will be stored
BackupStamp=$(date +%Y-%m-%d)                       # Make a timestamp
BackupName="enshrouded_backup_$BackupStamp.tar.gz"  # The name of the backup file

# Folder creation (in case it is not there)
mkdir -p $BackupPath

# Backup creation (map + config + logs)
umask 0027 ; tar -cvzf $BackupPath/$BackupName -C $ServerPath savegame/ enshrouded_server.json enshrouded_server_readme.txt logs/

# Remove all old (older than 7 days) backups to cut down on disk utilization.
find $BackupPath/* -mtime +6 -exec rm {} -fv \;