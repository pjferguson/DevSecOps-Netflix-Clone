# DevSecOps on AWS
![Open Source License](https://img.shields.io/badge/License-MIT-blue)
![Trivy](https://img.shields.io/badge/Vulnerabilities-None-brightgreen)
![Security](https://img.shields.io/badge/security-passed-brightgreen)
![Terraform](https://img.shields.io/badge/Terraform-valid-brightgreen)



### My First Steps
- The first thing I have done is created a script that be ran upon deployment of EC2 instance. 
- Next, I decided to configure my AWS environment using IaC (Terraform), this template allows for automation when deploying resources in the future. 
- I want to my sure that my Terraform file does not have any vulnerabilities that I may not be aware of, so I decided to use Terrascan. 
- Terrascan can be used to detect compliance and security violations across IaC, mitigating risk before provisioning cloud native infrastructure. More information on Terrascan: [Terrascan Docs](https://runterrascan.io/docs/getting-started/)
- Returned the output in JSON format for readiblity by running the command: 
```bash 
terrascan -o json > terrascan.json
```
### 1. **Script for EC2 Instance Setup**
- The project includes a shell script [script.sh](`./script.sh`) that automates the installation of essential services and tools on an EC2 instance. This script configures the necessary monitoring tools and Docker environment. It performs the following steps:

- Updates the package lists (`apt-get update`).
- Installs **Docker**.
- Clones the [DevSecOps-Netflix-Clone repository](https://github.com/pjferguson/DevSecOps-Netflix-Clone).
- Creates a system user `promonitoring` for Prometheus monitoring.
- Installs **Grafana**, configures it to start on boot, and enables necessary services.
- This can be ran in your environment: 
``` bash
git clone https://github.com/pjferguson/DevSecOps-Netflix-Clone
cd DevSecOps-Netflix-Clone
# make the script executable
chmod 400 script.sh
sudo script.sh
```
### 2. **Infrastructure as Code (IaC) with Terraform**
- To automate the creation and configuration of cloud resources, I have used **Terraform**. The template provided here helps automate future resource provisioning on AWS.

- You can use the Terraform templates to deploy resources like EC2 instances, security groups, and other AWS services, all in an automated manner.



### 3. **Security Scanning with Terrascan**
- Terraform files must be deployed with security by default. To ensure that my IaC is free from vulnerabilities I am using terrascan. Terrascan checks code against best practices, and security policies. 
- Checkout [terrascan.json](./terrascan.json) to see the details. 
- Scan your IaC:
``` bash
terrscan scan -o json > terrascan.json 
```
### 4. **Docker-Compose**
- Developed a Docker compose file, this tool allows me to define and run multi-container applications. Streamlimes deployment. 
- Comprehensible YAML file [docker-compose](./docker-compose.yml)
- This file contains three containers, SonarQube, PostgreSQL, and Jenkins. 
- Start all of services: 
``` bash 
docker compose up
```

### 5. **Services Configuration**
- After logging into my EC2 instance via ssh, I decided to run a trivy scan. Trivy is an open source vulnerability management tool that can help developers shift left, implementing security at the begining of the software develpment lifecycle. 

- Learn more about SonarQube here: [The DevSec Blueprint](https://www.devsecblueprint.com/projects/devsecops-home-lab/installation-and-configuration/security-tools/install-config-sonarqube)

### 6. ***Python Scripts**
- To enforce my grasp for understanding of automation with Jenkins, I created a script that uses the JenkinsAPI. This script allows operations teams to gain insight on different server metrics, rather it be build issues, change control, or plugin version management.  File to reference: [PyJenkins](./jenkins.py)
Install dependcies in virtual env
```bash
python -m venv /path/to/virtual-env
pip install jenkins api
```
- Script that interacts with SonarQube, allowing for token queries: [PySonar](./sonartoken.py)


### 7. Additional Docs
### Jenkins Configuration as Code
- According to [Jenkins](https://www.jenkins.io/doc/book/managing/casc/) "Jenkins Configuration as Code (JCasC) feature defines Jenkins configuration parameters in a human-readable YAML file that can be stored as source code."
- This provides me with the convenience and flexibility of configuring Global Tools using code. 
- The [Configuration as Code](https://plugins.jenkins.io/configuration-as-code/) Plugin must be installed to progammatically make these changes.
- Checkout [jenkins.yaml](./jenkins.yaml) to check out some of the configuration tools required for this project. Including OWASP Dependcy Check, JDK(17), NodeJs(16). 
### Pipeline as Code
🚧 **This is a work in progress. Please check back later for updates.**


### Current Status
- Creating pipeline Jenkinsfile
- Designed a python script to fetch sonarqube token data, this can be used to automate click-ops. 
- Designed a python script that fetches analytics from Jenkins server. 

### Summary 
🚧 **This is a work in progress. Please check back later for updates.**

### License
- This project is licensed under the MIT license. 

