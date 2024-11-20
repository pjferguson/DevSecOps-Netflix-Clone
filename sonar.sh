#! /bin/bash
# script to install SonarQube
cd /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.6.0.92116.zip
sudo apt install unzip -y
sudo unzip sonarqube-10.6.0.92116.zip
sudo mv sonarqube-10.6.0.92116 sonarqube
sudo adduser sonar
sudo chown -R sonar:sonar /opt/sonarqube
echo "[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
User=sonar
Group=sonar

ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
ExecReload=/opt/sonarqube/bin/linux-x86-64/sonar.sh restart

Restart=on-failure

[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/sonarqube.service
sudo systemctl daemon-reload
sudo systemctl start sonarqube
sudo systemctl enable sonarqube



