#!/bin/bash

# Download Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v*/node_exporter-*.*-amd64.tar.gz

# Extract the tarball
tar xvfz node_exporter-*.*-amd64.tar.gz

# Move Node Exporter binary to /usr/local/bin/
sudo mv node_exporter-*.*-amd64/node_exporter /usr/local/bin/

# Create a system user for Node Exporter
sudo useradd -rs /bin/false node_exporter

# Create the systemd service file
sudo tee /etc/systemd/system/node_exporter.service <<EOF
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start Node Exporter
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

# Check the status of Node Exporter
sudo systemctl status node_exporter

# Test if Node Exporter is running by accessing its metrics endpoint
curl http://localhost:9100/metrics
