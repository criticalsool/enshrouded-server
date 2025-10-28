# Enshrouded server
Enshrouded Dedicated Server install and backups scripts on Debian

# Install
```bash
git clone https://github.com/criticalsool/enshrouded-server.git
cd enshrouded-server/
bash enshrouded.bash
```

## First start
> As root
```bash
systemctl start enshrouded.service
```

### Configure
> As enshrouded
```
nano enshroudedserver/enshrouded_server.json
```

# Automation
## Auto restart
> As root : `sudo su -`
```bash
crontab -e
55 6 * * * systemctl stop enshrouded.service
5 7 * * * systemctl start enshrouded.service
```
> Stops at 6:55am and start again at 7:05am

## Auto backup
> As enshrouded : `sudo -u enshrouded -s`
```bash
crontab -e
0 7 * * * /home/enshrouded/scripts/backup-daily.bash
1 * * * * /home/enshrouded/scripts/backup-hourly.bash
```
> Backup every day at 7am and every hours

- Daily backups : map + config + logs
- Hourly backups : map

> Old backups are removed automaticaly