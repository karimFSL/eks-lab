#!/bin/bash
set -e

# Mise à jour
sudo apt update
sudo apt upgrade -y

# Installation de Java
sudo apt install -y openjdk-17-jdk

# Ajout du repository Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Installation de Jenkins
sudo apt update
sudo apt install -y jenkins

# Démarrage
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Statut
sudo systemctl status jenkins

# Récupération du mot de passe initial
echo "Mot de passe initial :"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword