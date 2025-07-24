**This Repository gives you the complete, step-by-step guide to set up and deploy your app to Minikube on Windows — including Docker image handling, Kubernetes Deployment, and Service**


1. Install Required Tools
Make sure these are installed:

Tool	Download Link

Minikube -	https://minikube.sigs.k8s.io/docs/start/

kubectl	- https://kubernetes.io/docs/tasks/tools/

Docker	- https://www.docker.com/products/docker-desktop

Java -  https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html

Maven  - https://maven.apache.org/download.cgi

2. Start Minikube
   
Open PowerShell or CMD as admin:

minikube start

This will create a local Kubernetes cluster using a Docker

3. Clone this repository

Build your Java app (using Maven)
   
Navigate to your Java project root and run:

mvn clean package

This generates a JAR file in the target/ directory — e.g., target/app-name-0.0.1-SNAPSHOT.jar

4. Build the Docker image using Dockerfile
   
docker build -t <your-dockerhub-username>/kiran-youtube-app:latest .

5. Test the image locally (optional)

docker run -p 8082:8082 <your-dockerhub-username>/kiran-youtube-app:latest

6. Docker Tag and push to Hub

docker tag <your-dockerhub-username>/kiran-youtube-app:v1 <your-dockerhub-username>/kiran-youtube-app:latest

docker push <your-dockerhub-username>/kiran-youtube-app:latest



