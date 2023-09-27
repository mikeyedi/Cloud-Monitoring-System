# Cloud-Monitoring-System

## install_prometheus.sh

This script automates the installation and configuration of Prometheus on an Ubuntu system. It performs the following tasks:

1. Creates necessary directories and user for Prometheus.
2. Downloads the specified version of Prometheus binary.
3. Moves binaries to `/usr/local/bin` and sets ownership.
4. Moves configuration files to `/etc/prometheus` and sets ownership.
5. Creates and edits the Prometheus configuration file (`prometheus.yml`).
6. Creates and edits the Prometheus systemd service file (`prometheus.service`).
7. Reloads systemd and starts Prometheus.

## install_alertmanager.sh

This script automates the installation and configuration of Alertmanager on an Ubuntu system. It performs similar tasks as the Prometheus script:

1. Creates necessary directories and user for Alertmanager.
2. Downloads the specified version of Alertmanager binary.
3. Moves binaries to `/usr/local/bin` and sets ownership.
4. Moves configuration files to `/etc/alertmanager` and sets ownership.
5. Creates and edits the Alertmanager configuration file (`alertmanager.yml`).
6. Creates and edits the Alertmanager systemd service file (`alertmanager.service`).
7. Reloads systemd and starts Alertmanager.

## How to Use

### Step 1: Download Scripts

Clone this repository or download the individual scripts:

**Step 2: Make Scripts Executable**
Make both scripts executable:

bash
Copy code
chmod +x install_prometheus.sh install_alertmanager.sh
Step 3: Run Scripts
Run each script with elevated privileges using sudo:

bash
Copy code
sudo ./install_prometheus.sh
sudo ./install_alertmanager.sh
The scripts will guide you through the installation process, and you will see status messages as the installation progresses.

**Step 4: Verify Installation**
Check the status of Prometheus and Alertmanager:

bash
Copy code
sudo systemctl status prometheus
sudo systemctl status alertmanager

You should see status messages indicating that both services are running.
