# Enshrouded server
Enshrouded Dedicated Server install script on Debian

# Install
```bash
git clone https://github.com/criticalsool/enshrouded-server.git
cd enshrouded-server/
bash enshrouded.bash
```

# Automation
## Auto restart
> As root
```bash
crontab -e
10 7 * * * systemctl restart enshrouded.service
```

## Auto backup
> As enshrouded
```bash
mkdir /home/enshrouded/backups
crontab -e
0 7 * * * tar -czvf /home/enshrouded/backups/enshrouded_backup_$(date +%Y-%m-%d).tar.gz -C /home/enshrouded/enshroudedserver/savegame/ .
```