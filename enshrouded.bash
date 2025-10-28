#! /bin/bash

# Check root
if [ "$EUID" -ne 0 ]; then
    echo -e "\e[31mPlease run this script as root\e[0m"
    exit
fi

# Install needed packages
apt-get update
apt-get install -y curl nano ufw wget software-properties-common lsb-release

# Configure firewall
ufw allow 15637/udp
ufw default deny incoming
ufw default deny forward
ufw enable

# Install winehq
mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/dists/$(lsb_release -cs)/winehq-$(lsb_release -cs).sources
dpkg --add-architecture i386
apt-get update
apt-get install -y --install-recommends winehq-staging

# Install steamcmd
apt-add-repository -y non-free non-free-firmware
echo steam steam/license note '' | debconf-set-selections
echo steam steam/question select "I AGREE" | debconf-set-selections
apt-get install steamcmd

# Add enshrouded user
useradd -m enshrouded

# Install enshrouded service
cat > /etc/systemd/system/enshrouded.service <<'EOF'
# /etc/systemd/system/enshrouded.service
[Unit]
Description=Enshrouded Server
Wants=network-online.target
After=network-online.target
[Service]
User=enshrouded
Group=enshrouded
WorkingDirectory=/home/enshrouded/
ExecStartPre=/usr/games/steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir /home/enshrouded/enshroudedserver +login anonymous +app_update 2278520 +quit
ExecStart=/usr/bin/wine /home/enshrouded/enshroudedserver/enshrouded_server.exe
Restart=always
[Install]
WantedBy=multi-user.target
EOF

# Enable enshrouded service at startup
systemctl enable enshrouded

# Create directories
mkdir -pv /home/enshrouded/enshroudedserver
mkdir -pv /home/enshrouded/scripts
mkdir -pv /home/enshrouded/backups

# Copy backups scripts
cp scripts/* /home/enshrouded/scripts

# Set permissions
chown -Rv enshrouded: /home/enshrouded
chmod -Rv o-rwx /home/enshrouded

# End print
echo "Installation completed, to configure and setup automation, please read the README.md file"