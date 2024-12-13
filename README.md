## DevSecOps with Terraform & Jenkins




### My First Steps
- The first thing I configured is a script that exectutes upon deployment of the EC2 instance. 
- Next, I decided to configure my AWS environment using IaC (Terraform); this template allows for automation when deploying resources in the future. 
### 1. **Script for EC2 Instance Setup**
- The project includes a shell script [script.sh](`./aws-environment/script.sh`) that automates the installation of essential services and tools on an EC2 instance. This script configures the necessary monitoring tools and Docker environment. It performs the following steps:

- Updates the package lists (`apt-get update`).
- Installs **Docker**.
- Clones the [DevSecOps-Netflix-Clone repository](https://github.com/pjferguson/DevSecOps-Netflix-Clone).
- Creates a system user `promonitoring` for Prometheus monitoring.
- Installs **Grafana**, configures it to start on boot, and enables necessary services.
- This can be run in your environment: 
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
- Terraform IaC files should be deployed with security by default. To ensure that my IaC is free from vulnerabilities, I am using Terrascan. Terrascan checks the code against best practices and security policies. 
- Terrascan can detect compliance and security violations across IaC, mitigating risk before provisioning cloud-native infrastructure. More information on Terrascan: [Terrascan Docs](https://runterrascan.io/docs/getting-started/)
- Returned the output in JSON format for readiblity by running the command: 
```bash 
terrascan -o json > terrascan.json
```
### 4. **Docker-Compose**
- Developed a Docker compose file, allowing me to define and run multi-container applications. Streamlines deployment. 
- Comprehensible YAML file [docker-compose](./docker-services/docker-compose.yml)
- This file contains three containers: SonarQube, PostgreSQL, and Jenkins. 
- Start all of the services: 
``` bash 
docker-compose up
```
- Learn more about SonarQube here: [The DevSec Blueprint](https://www.devsecblueprint.com/projects/devsecops-home-lab/installation-and-configuration/security-tools/install-config-sonarqube)

### 5. **Services Configuration**
- After logging into my EC2 instance via ssh, I decided to run a trivy scan. Trivy is an open-source vulnerability management tool that can help developers shift left, implementing security at the beginning of the software development lifecycle. 

### 6. **Python Scripts**
- To enforce my grasp and understanding of automation with Jenkins, I created a script that uses the Jenkins API. This script allows operations teams to gain insight into different server metrics- build issues, change control, or plugin version management. File to reference: [PyJenkins](./python-scripts/jenkins.py)
```bash
# Install dependencies in virtual env
python -m venv /path/to/virtual-env
pip install jenkins api
```
- Script that interacts with SonarQube, allowing for token queries: [PySonar](./python-scripts/sonartoken.py)


### 7. **Additional Docs**
#### Jenkins Configuration as Code
- According to [Jenkins](https://www.jenkins.io/doc/book/managing/casc/), the "Jenkins Configuration as Code (JCasC) feature defines Jenkins configuration parameters in a human-readable YAML file that can be stored as source code."
- This gives me the convenience and flexibility of configuring Global Tools using code. 
- The [Configuration as Code](https://plugins.jenkins.io/configuration-as-code/) Plugin must be installed to make these changes programmatically.
- Jenkins file: [Jenkins](./Jenkinsfile)

#### Yarn Audit Analyzer 
- Yarn is one of the leading JavaScript package managers; this is specific to the Node.js Javascript runtime environment. 
```bash 
yarn audit
```
- Here is a great place to start for more advanced commands: [nodejs-security](https://www.nodejs-security.com/blog/how-to-use-yarn-audit) 


#### Grafana and Prometheus 
- I ran Prometheus in a Docker container to maximize system resource capabilities. 
- Integration Documentation: [prometheus and grafana](https://www.linode.com/docs/guides/how-to-install-prometheus-and-grafana-on-ubuntu/)


### Summary 
- During this project, I successfully deployed and secured a mock Netflix application on AWS, leveraging Terraform for infrastructure provisioning. Focusing on the "shift left" security approach gave me valuable insights into detecting vulnerabilities early in the development lifecycle. Implementing tools like Terrascan and Trivy allowed me to identify security risks within the IaC. At the same time, the setup of a Jenkins pipeline provided real-time visibility into the security health of the application repository.

- In the future, I will continue to build my skillset in the automation of securing cloud infrastructure and services.


### License
- This project is licensed under the MIT license. 

