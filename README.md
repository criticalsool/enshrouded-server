# Enshrouded server
Enshrouded Dedicated Server install script on Debian

# Install
```bash
git clone https://github.com/criticalsool/enshrouded-server.git
cd enshrouded-server/
bash enshrouded.bash
```

## First start
### Log in with enshrouded user
```bash
sudo -u enshrouded -s
```
### Download server files
```bash
/usr/games/steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir /home/enshrouded/enshroudedserver +login anonymous +app_update 2278520 +quit
```

### Start server
```bash
wine ~/enshroudedserver/enshrouded_server.exe
```
> Once server is started exit with `CTRL+C`

### Configure
```
nano enshroudedserver/enshrouded_server.json
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
0 7 * * * tar -czvf /home/enshrouded/backups/enshrouded_backup_$(date +\%Y-\%m-\%d).tar.gz -C /home/enshrouded/enshroudedserver/savegame/ .
```
