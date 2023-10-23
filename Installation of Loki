#!/bin/bash

# Check CPU architecture
arch=$(uname -m)
echo "CPU Architecture: $arch"

# Determine Loki release version and architecture
loki_version="2.4.1"
loki_arch="amd64"

# Download Loki binary
curl -O -L "https://github.com/grafana/loki/releases/download/v${loki_version}/loki-linux-${loki_arch}.zip"

# Extract the binary
unzip "loki-linux-${loki_arch}.zip"

# Make sure it is executable
chmod a+x "loki-linux-${loki_arch}"

# Copy binary to /usr/local/bin/
sudo cp "loki-linux-${loki_arch}" /usr/local/bin/loki

# Verify installation by checking version
loki --version

# Create user for Loki
sudo useradd --system loki

# Create directories
sudo mkdir -p /etc/loki /etc/loki/logs

# Download default Loki configuration file
sudo curl -o /etc/loki/loki-local-config.yaml -L "https://gist.github.com/psujit775/ceaf475fc369e25a2d04501f8a7c0a59/raw"

# Change permissions
sudo chown -R loki: /etc/loki

# Create a systemd service unit file for Loki
cat <<EOL | sudo tee /etc/systemd/system/loki.service
[Unit]
Description=Loki service
After=network.target

[Service]
Type=simple
User=loki
ExecStart=/usr/local/bin/loki -config.file /etc/loki/loki-local-config.yaml
Restart=on-failure
RestartSec=20
StandardOutput=append:/etc/loki/logs/loki.log
StandardError=append:/etc/loki/logs/loki.log

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd
sudo systemctl daemon-reload

# Start Loki service
sudo systemctl start loki

# Check Loki service status
sudo systemctl status loki

# Enable Loki service to start on boot
sudo systemctl enable loki

# Verify Loki metrics
curl http://localhost:3100/metrics

echo "Loki installation and configuration complete."
