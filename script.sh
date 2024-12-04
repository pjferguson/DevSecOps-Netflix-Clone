#! /bin/bash
# shell script for installation of required services & tools. 
apt-get update
apt-get install docker.io -y
git clone https://github.com/pjferguson/DevSecOps-Netflix-Clone.git
usermod -aG docker $USER
apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key |  apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main |  tee -a /etc/apt/sources.list.d/trivy.list
apt-get install trivy
apt install openjdk-17-jre
apt-get install jenkins
systemctl enable jenkins
systemctl start jenkins
# Installation of jcli which will allow me to install required plugins.
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin adoptopenjdk:1.5
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin sonar:2.17.3
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin nodejs:1.6..2
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin email-ext:1855.vd9e491cb_de1e
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin configuration-as-code:1887.v9e47623cb_043
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin docker-plugin:1.7.0
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin docker-commons:445.v6b_646c962a_94
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin docker-java-api:3.4.0-94.v65ced49b_a_7d5

# creating use "promonitoring for prometheus monitoring"
useradd --system promonitoring
apt-get -y install grafana
systemctl enable grafana-server
systemctl enable grafana-server
usermod -aG docker jenkins
systemctl restart jenkins
cd /DevSecOps-Netflix-Clone && chmod 755 docker.sh
./docker.sh


