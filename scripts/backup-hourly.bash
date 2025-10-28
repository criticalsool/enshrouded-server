#! /bin/bash

# Variables
ServerPath="/home/enshrouded/enshroudedserver/"     # Where the server is
BackupPath="/home/enshrouded/backups/hourly/"       # Where the backup will be stored
BackupStamp=$(date +%Y-%m-%d_%Hh)                   # Make a timestamp
BackupName="enshrouded_backup_$BackupStamp.tar.gz"  # The name of the backup file

# Folder creation (in case it is not there)
mkdir -p $BackupPath

# Backup creation (Map)
umask 0027 ; tar -cvzf $BackupPath/$BackupName -C $ServerPath savegame/

# Remove all old (older than 3 days) backups to cut down on disk utilization.
find $BackupPath/* -mtime +2 -exec rm {} -fv \;