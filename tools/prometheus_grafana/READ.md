# create user prometheus
sudo useradd --no-create-home --shell /bin/false prometheus

# prometheus installation
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v3.5.0/prometheus-3.5.0.linux-amd64.tar.gz
tar xvfz prometheus-3.5.0.linux-amd64.tar.gz

sudo cp prometheus-3.5.0.linux-amd64/prometheus /usr/local/bin/
sudo cp prometheus-3.5.0.linux-amd64/promtool /usr/local/bin/
sudo mkdir -p /etc/prometheus
sudo mkdir -p /var/lib/prometheus
sudo cp  prometheus-3.5.0.linux-amd64/prometheus.yml /etc/prometheus

sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /var/lib/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool


# créer un service systemd
sudo nano /etc/systemd/system/prometheus.service

# démarrer prometheus
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
sudo systemctl status prometheus

# check version
prometheus --version


# Vérifier que le port écoute
sudo ss -tlnp | grep 9090