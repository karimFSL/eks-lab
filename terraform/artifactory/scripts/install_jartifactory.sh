#!/bin/bash
set -e

ARTIFACTORY_USER="artifactory"
ARTIFACTORY_VERSION="7.71.5"  # Modifier selon la version souhaitée
ARTIFACTORY_HOME="/opt/artifactory"

# Mise à jour
sudo apt update
sudo apt upgrade -y

# Installation de Java
sudo apt install -y openjdk-17-jdk

# création de l'utilisateur artifactory
sudo useradd -m -s /bin/bash $ARTIFACTORY_USER


# téléchargement artifactory oss
wget "https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/${ARTIFACTORY_VERSION}/jfrog-artifactory-oss-${ARTIFACTORY_VERSION}-linux.tar.gz"

# extraction
sudo tar -xzf jfrog-artifactory-oss-${ARTIFACTORY_VERSION}-linux.tar.gz -C /opt/
sudo mv /opt/artifactory-oss-${ARTIFACTORY_VERSION} $ARTIFACTORY_HOME
sudo chown -R $ARTIFACTORY_USER:$ARTIFACTORY_USER $ARTIFACTORY_HOME


# /etc/systemd/system/artifactory.service
sudo systemctl daemon-reload

# Démarrage
sudo systemctl enable artifactory
sudo systemctl start artifactory

# Statut
sudo systemctl status artifactory