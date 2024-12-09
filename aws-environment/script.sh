#! /bin/bash
# shell script for installation of required services & tools. 
apt-get update
apt-get install docker.io -y
git clone https://github.com/pjferguson/DevSecOps-Netflix-Clone.git

# creating use "promonitoring for prometheus monitoring"
useradd --system promonitoring
apt-get -y install grafana
systemctl enable grafana-server
systemctl enable grafana-server
usermod -aG docker jenkins


