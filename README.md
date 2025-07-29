# Java-twitter-App

**Create an Ubuntu server in AWS for Jenkins, SonarQube, and Nexus**  
Instance: `t2.large`  
Memory: `40GB`

---

### **1. Update the System**
```bash
sudo apt-get update
```

---

### **2. Install Java 17**
```bash
sudo apt install openjdk-17-jdk
```

---

### **3. Install Jenkins**
```bash
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
sudo systemctl start jenkins
```

---

### **4. Install Trivy**
```bash
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy
```

---

### **5. Install Docker**
```bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update
sudo apt-get install docker-ce
```

---

### **6. Install Jenkins Plugins**
Go to Jenkins → Manage Plugins → Install the following plugins:
1. SonarQube Scanner  
2. Config File Provider  
3. Maven Integration  
4. Pipeline Maven Integration  
5. Nexus Artifact Uploader  
6. Docker  
7. OWASP Dependency-Check  
8. Docker Pipeline  
9. Eclipse Temurin Installer  
10. Pipeline Stage View  

---

### **7. Create Nexus Container**
```bash
sudo docker run -d -p 8082:8082 sonatype/nexus3
```
- Sign in to Nexus:  
  Username: `admin`  
  Retrieve the password:
  ```bash
  sudo docker exec -it <container-id> /bin/bash
  cd sonatype-work/nexus3
  cat admin.password
  ```
- Copy the password (do not include `bash`).
- Add Nexus URL in pom.xml
   
Login to Nexus --> browse --> copy maven releases and maven snapshots ---> paste in URL added in pom.xml

![image](https://github.com/user-attachments/assets/b67c6a9b-7bbe-4109-ae4a-2c9492ba9bbb)

 Edit pom.xml

 ![image](https://github.com/user-attachments/assets/f60c1554-2e75-41d9-ac1a-34d99acec1a0)

- Create gloabl maven configuration in jenkins managed files
   
Goto managed files  --> add new config --> select Global Maven settings.xml --> give ID as Global-maven --> add below config under server --> username and password of nexus

```
-->
    <server>
      <id>maven-releases</id>
      <username>admin</username>
      <password>kirancgwd</password>
    </server>
    
    <server>
      <id>maven-snapshots</id>
      <username>admin</username>
      <password>kirancgwd</password>
    </server>
    -->
```


---

### **8. Create SonarQube Container**
```bash
sudo docker run -d -p 9000:9000 sonarqube:lts-community
```
- Login:  
  Username: `admin`  
  Password: `admin`  
- Generate a token in SonarQube and configure the SonarQube server in Jenkins.

---

### **9. Add Credentials in Jenkins**
Add credentials for:
1. Git (if private)  
2. Docker  
3. SonarQube  

---

### **10. Configure Tools in Jenkins**
Configure the following tools in Jenkins:
1. JDK  
2. Docker  
3. Maven  
4. SonarQube  
5. OWASP  

---

### **11. Create a Pipeline Jenkins**
- Write a Declarative pipeline script using Jenkinsfile.
- Ensure tools are defined in the pipeline with names matching the Jenkins configuration.

---

### **Notes**
1. Define all tools explicitly in the pipeline script.  
2. Tool names in the pipeline must match the names defined in Jenkins.
