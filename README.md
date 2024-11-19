# DevSecOps on AWS
![Open Source License](https://img.shields.io/badge/License-MIT-blue)
![SonarQube](https://img.shields.io/badge/SonarQube-blue)
![Application Security](https://img.shields.io/badge/AppSec-blue)

### My First Steps
- The first thing I have done is created a script that be ran upon deployment of EC2 instance. This script will install tools and services needed for the project (SonarQube, Jenkins, Grafana). 
- Next, I decided to configure my AWS environment using IaC (Terraform), this template allows for automation when deploying resources in the future. 
- I want to my sure that my Terraform file does not have any vulnerabilities that I may not be aware of, so I decided to use Terrascan. 
- Terrascan can be used to detect compliance and security violations across IaC, mitigating risk before provisioning cloud native infrastructure. More information on Terrascan: [Terrascan Docs](https://runterrascan.io/docs/getting-started/)
- Returned the output in JSON format for readiblity by running the command: 
```bash 
terrascan -o json > terrascan.json
```
### Sonar Script
- As part of this project, I focused on automating operational taks by creating a script that simplifies the installation and configuration of SonarQube and its dependcies. The ['sonar.sh](./sonar.sh) script also configures a systemd service for easy management. 
Before running the [`sonar.sh`](./sonar.sh) script, make sure the following requirements are met:

- A **Linux-based server** (e.g., Ubuntu, CentOS, or other modern distributions).
- **Sudo or root privileges** to install software and configure services.
- **Java 11+** installed, as SonarQube requires Java to function.
- **PostgreSQL or MySQL** database set up for SonarQube. This project uses a PostgreSQL DB. 
- At least **2 GB of free disk space** for installation and data storage.
> **Note:** The script assumes a clean server environment.
- To run the script:
**Clone the repo**:
``` bash
git clone https://github.com/pjferguson/DevSecOps-Netflix-Clone
cd DevSecOps-Netflix-Clone
# make the script executable
chmod 755 sonar.sh
sudo ./sonar.sh
```



### Current Status
- Terraform file under maintenance. 
- Sonar.sh has finishing touches being applied. 

### Summary 
🚧 **This is a work in progress. Please check back later for updates.**

### License
- This project is licensed under the MIT license. 

