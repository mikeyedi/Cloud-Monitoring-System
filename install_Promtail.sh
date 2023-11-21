#!/bin/bash

# Change to the /usr/local/bin directory
cd /usr/local/bin

# Download Promtail binary
curl -O -L "https://github.com/grafana/loki/releases/download/v2.4.1/promtail-linux-amd64.zip"

# Unzip the downloaded file
unzip "promtail-linux-amd64.zip"

# Set execute permissions for Promtail binary
sudo chmod a+x "promtail-linux-amd64"

# Create Promtail configuration file
cat <<EOL | sudo tee config-promtail.yml
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: 'http://localhost:3100/loki/api/v1/push'

scrape_configs:
  - job_name: system
    static_configs:
      - targets:
          - localhost
        labels:
          job: varlogs
          __path__: /var/log/*log
EOL

# Create promtail system user
sudo useradd --system promtail

# Create Promtail systemd service file
cat <<EOL | sudo tee /etc/systemd/system/promtail.service
[Unit]
Description=Promtail service
After=network.target

[Service]
Type=simple
User=promtail
ExecStart=/usr/local/bin/promtail-linux-amd64 -config.file /usr/local/bin/config-promtail.yml

[Install]
WantedBy=multi-user.target
EOL

# Start the Promtail service
sudo systemctl start promtail

# Check the status of the Promtail service
sudo systemctl status promtail
