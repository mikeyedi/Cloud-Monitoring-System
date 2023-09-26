#!/bin/bash

# Download Alertmanager
wget https://github.com/prometheus/alertmanager/releases/download/v0.22.2/alertmanager-0.22.2.linux-amd64.tar.gz

# Extract the downloaded file
tar -xzf alertmanager-0.22.2.linux-amd64.tar.gz

# Move Alertmanager to /opt/alertmanager
sudo mv -v alertmanager-0.22.2.linux-amd64 /opt/alertmanager

# Set ownership to root:root
sudo chown -Rfv root:root /opt/alertmanager

# Create data directory
sudo mkdir -v /opt/alertmanager/data

# Set ownership to prometheus:prometheus
sudo chown -Rfv prometheus:prometheus /opt/alertmanager/data

# Create a systemd service unit file
cat <<EOL | sudo tee /etc/systemd/system/alertmanager.service
[Unit]
Description=Alertmanager

[Service]
ExecStart=/opt/alertmanager/alertmanager \
  --config.file=/opt/alertmanager/alertmanager.yml \
  --storage.path=/opt/alertmanager/data

Restart=always
User=prometheus

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd
sudo systemctl daemon-reload

# Start and enable the Alertmanager service
sudo systemctl start alertmanager.service
sudo systemctl enable alertmanager.service

# Check the status of the Alertmanager service
sudo systemctl status alertmanager.service
