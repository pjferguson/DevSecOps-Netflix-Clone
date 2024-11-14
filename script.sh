#! /bin/bash
# shell script for installation of required services & tools. 
sudo apt-get update
sudo apt-get install docker.io -y
git clone https://github.com/N4si/DevSecOps-Project.git
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get install trivy
sudo apt install openjdk-17-jre
sudo apt-get install jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
# creating use "promonitoring for prometheus monitoring"
sudo useradd --system promonitoring
sudo apt-get -y install grafana
sudo systemctl enable grafana-server
sudo systemctl enable grafana-server
