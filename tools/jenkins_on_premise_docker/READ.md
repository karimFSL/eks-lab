# install jenkins with docker
# jenkins runs on tomcat by default 8080
# master / slave communication on port 50000
docker run -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 -d jenkins/jenkins

# jdk 17
https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.13%2B11/OpenJDK17U-jdk_x64_linux_hotspot_17.0.13_11.tar.gz
Subdirectory: jdk-17.0.13+11


# plugin 
https://medium.com/@tamerbenhassan/boost-your-jenkins-workflow-with-these-10-essential-plugins-a420726488f6
https://www.hatica.io/blog/jenkins-plugins/

https://www.geeksforgeeks.org/devops/jenkins-plugins/

# other
mise en place de webhook côté github + installation plugin multibranch pipeline webhook pour du pushing 

## docker compose
# Copier et coller le contenu du fichier docker-compose sous le nom jenkins.yml:
services:
  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins
    ports:
"8080:8080"
"50000:50000"
    volumes:
./jenkins_home:/var/jenkins_home
    restart: always

# Exécuter le fichier docker-compose pour installer jenkins
docker-compose -f jenkins.yml up -d 

# jenkins agent
https://www.cloudbees.com/blog/how-to-install-and-run-jenkins-with-docker-compose