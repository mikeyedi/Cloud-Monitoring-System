#!/bin/bash

# Install necessary packages
sudo apt update
sudo apt install -y curl unzip

# Download and install Loki
curl -s https://api.github.com/repos/grafana/loki/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep loki-linux-amd64.zip | wget -i -
unzip loki-linux-amd64.zip
sudo mv loki-linux-amd64 /usr/local/bin/loki

# Check Loki version
loki --version

# Create data directory
sudo mkdir -p /data/loki

# Create Loki configuration file
sudo tee /etc/loki-local-config.yaml <<EOF
auth_enabled: false
server:
  http_listen_port: 3100
ingester:
  lifecycler:
    address: 127.0.0.1
    ring:
      kvstore:
        store: inmemory
      replication_factor: 1
    final_sleep: 0s
  chunk_idle_period: 5m
  chunk_retain_period: 30s
  max_transfer_retries: 0
schema_config:
  configs:
    - from: 2018-04-15
      store: boltdb
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 168h
storage_config:
  boltdb:
    directory: /data/loki/index
  filesystem:
    directory: /data/loki/chunks
limits_config:
  enforce_metric_name: false
  reject_old_samples: true
  reject_old_samples_max_age: 168h
chunk_store_config:
  max_look_back_period: 0s
table_manager:
  retention_deletes_enabled: false
  retention_period: 0s
EOF

# Create and enable Loki systemd service
sudo tee /etc/systemd/system/loki.service <<EOF
[Unit]
Description=Loki service
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/loki -config.file /etc/loki-local-config.yaml

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, start Loki service, and check its status
sudo systemctl daemon-reload
sudo systemctl start loki.service
systemctl status loki

echo "Loki installation and configuration complete."
