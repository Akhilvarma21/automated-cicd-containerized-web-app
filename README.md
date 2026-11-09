# Automated CI/CD Pipeline for a Containerized Web Application

A complete DevOps project demonstrating how to build, containerize, continuously integrate, and deploy a Python Flask web application using Docker, GitHub Actions, and Kubernetes with Minikube.

## Project Overview

This project implements a practical CI/CD workflow for a containerized web application.

The application is developed using Python Flask, packaged into a Docker container, validated through GitHub Actions, and deployed locally on a Kubernetes cluster running through Minikube.

The project focuses on demonstrating core DevOps practices including:

- Application development
- Git and GitHub version control
- Docker containerization
- Continuous Integration using GitHub Actions
- Kubernetes deployment
- Kubernetes service exposure
- Repeatable deployment using PowerShell automation
- Infrastructure and application troubleshooting

## Architecture

```text
Developer
    |
    | git push
    v
GitHub Repository
    |
    v
GitHub Actions
    |
    +----------------------+
    |                      |
    v                      v
Python Dependency      Docker Build
Installation           Validation
    |                      |
    +----------+-----------+
               |
               v
        CI Pipeline Pass
               |
               |
        Local Deployment
               |
               v
       deploy.ps1 script
               |
               v
           Minikube
               |
               v
        Kubernetes Cluster
               |
        +------+------+
        |             |
        v             v
   Deployment      Service
   2 Replicas      NodePort
        |             |
        +------+------+
               |
               v
       Flask Web Application
````

## Technologies Used

| Technology     | Purpose                       |
| -------------- | ----------------------------- |
| Python         | Application development       |
| Flask          | Web application framework     |
| Git            | Version control               |
| GitHub         | Source code repository        |
| GitHub Actions | Continuous Integration        |
| Docker         | Application containerization  |
| Kubernetes     | Container orchestration       |
| Minikube       | Local Kubernetes cluster      |
| kubectl        | Kubernetes cluster management |
| PowerShell     | Deployment automation         |
| Windows 11     | Development environment       |

## Project Structure
```
automated-cicd-containerized-web-app/
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
│
├── .gitignore
├── app.py
├── deploy.ps1
├── Dockerfile
├── README.md
└── requirements.txt
```

## Application

The application is a lightweight Flask web application.

The Flask application is exposed on port `5000`.

The application can be run locally using Python or packaged and executed using Docker.

## Running the Application Locally

Create and activate the Python virtual environment:
```
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

Install the dependencies:
```
pip install -r requirements.txt
```

Start the application:
```
python app.py
```

The application runs on:
```
http://localhost:5000
```

## Docker

### Build the Docker Image

Build the application image:
```
docker build -t automated-cicd-web-app:1.0 .
```

### Run the Container
```
docker run -d -p 5000:5000 --name automated-cicd-container automated-cicd-web-app:1.0
```

The application can then be accessed at:
```
http://localhost:5000
```

### View Container Logs
```
docker logs automated-cicd-container
```

### Stop the Container
```
docker stop automated-cicd-container
```

## Continuous Integration with GitHub Actions

The project uses GitHub Actions to automatically validate changes pushed to the `main` branch.

The CI pipeline performs the following steps:

1. Checks out the source code.
2. Sets up Python 3.10.
3. Installs the required Python dependencies.
4. Performs a Python syntax check.
5. Builds the Docker image.

### CI Workflow
```
Git Push
   |
   v
GitHub Actions
   |
   v
Checkout Repository
   |
   v
Setup Python 3.10
   |
   v
Install Dependencies
   |
   v
Validate Flask Application
   |
   v
Build Docker Image
   |
   v
CI Passed
```

The workflow file is located at:
```
.github/workflows/ci.yml
```

## Kubernetes

The application is deployed to a local Kubernetes cluster using Minikube.

The Kubernetes configuration contains:

- A Deployment with 2 replicas
- A NodePort Service
- Container port `5000`
- Local Docker image deployment

### Kubernetes Deployment

The Deployment manages two replicas of the application:
```
automated-cicd-web-app
        |
        +-- Pod 1
        |
        +-- Pod 2
```

This provides basic replica-based availability within the local Kubernetes environment.

### Kubernetes Service

The Service exposes the application using a NodePort.

The service connects to pods using the Kubernetes label:
```
app: automated-cicd-web-app
```

## Minikube Deployment

Start Minikube:
```
minikube start --driver=docker
```

Load the Docker image into Minikube:
```
minikube image load automated-cicd-web-app:1.0
```

Apply the Kubernetes Deployment:
```
kubectl apply -f k8s/deployment.yaml
```

Apply the Kubernetes Service:
```
kubectl apply -f k8s/service.yaml
```

Check the Deployment:
```
kubectl get deployments
```

Check the Pods:
```
kubectl get pods
```

Check the Services:
```
kubectl get services
```

Open the application through Minikube:
```
minikube service automated-cicd-web-app-service
```

## Automated Deployment Script

The project includes a PowerShell deployment script:
```
deploy.ps1
```

The script automates the local Kubernetes deployment process.

It performs the following operations:

1. Loads the Docker image into Minikube.
2. Applies the Kubernetes Deployment.
3. Applies the Kubernetes Service.
4. Displays Deployment status.
5. Displays Pod status.
6. Displays Service status.

Run it using:
```
.\deploy.ps1
```

## CI/CD Workflow

The current project separates Continuous Integration from local deployment.

### Continuous Integration

GitHub Actions automatically:

- Installs dependencies
- Validates the Python application
- Builds the Docker image

### Deployment

The Kubernetes deployment is performed locally using Minikube and the `deploy.ps1` automation script.

This design is intentional because a GitHub-hosted runner cannot directly access the Kubernetes cluster running locally on the developer's Windows machine.
```
                    GitHub
                       |
                       v
                GitHub Actions
                       |
              +--------+--------+
              |                 |
       Python Validation   Docker Build
              |                 |
              +--------+--------+
                       |
                    CI Pass
                       
                      

Developer Machine
       |
       v
   Minikube
       |
       v
   Kubernetes
       |
       v
 Flask Application
```

## Kubernetes Commands

### Check Cluster
```
kubectl get nodes
```

### Check Deployments
```
kubectl get deployments
```

### Check Pods
```
kubectl get pods
```

### Check Services
```
kubectl get services
```

### Describe a Pod
```
kubectl describe pod <pod-name>
```

### View Pod Logs
```
kubectl logs <pod-name>
```

## Troubleshooting

### Docker daemon is not running

If Docker commands fail with a connection error, make sure Docker Desktop is running.

Verify Docker:
```
docker version
```

### Minikube is not running

Check Minikube:
```
minikube status
```

Start it if required:
```
minikube start --driver=docker
```

### Kubernetes Pod is not starting

Check the pods:
```
kubectl get pods
```

Then inspect the problematic pod:
```
kubectl describe pod <pod-name>
```

### ImagePullBackOff

Because the project uses a locally built Docker image, load the image into Minikube:
```
minikube image load automated-cicd-web-app:1.0
```

The Kubernetes Deployment uses:
```
imagePullPolicy: Never
```

so Kubernetes uses the locally available image rather than attempting to pull it from a container registry.

## Key DevOps Concepts Demonstrated

This project demonstrates practical knowledge of:

- Version control with Git
- GitHub repository management
- Continuous Integration
- GitHub Actions
- Docker image creation
- Docker containers
- Containerized application deployment
- Kubernetes Deployments
- Kubernetes Pods
- Kubernetes Services
- NodePort networking
- Replica management
- Minikube
- kubectl
- PowerShell automation
- Troubleshooting container and Kubernetes environments

## Future Improvements

Possible improvements for a production-oriented version include:

- Push Docker images to GitHub Container Registry
- Add automated image versioning
- Add unit tests with Pytest
- Add Docker image security scanning
- Add Kubernetes health checks
- Add ConfigMaps and Secrets
- Add Ingress
- Add Horizontal Pod Autoscaling
- Deploy Kubernetes workloads to a cloud environment
- Implement full automated Continuous Deployment
- Add monitoring using Prometheus and Grafana

## Project Status

The project currently provides:

- Flask web application
- Docker containerization
- GitHub repository
- GitHub Actions CI pipeline
- Kubernetes Deployment
- Kubernetes Service
- Minikube-based deployment
- PowerShell deployment automation
- Project documentation

## Author

**Akhil Varma**

Cloud & DevOps Enthusiast

Focus Areas:

- AWS
- Cloud Computing
- DevOps
- Docker
- Kubernetes
- CI/CD
- Linux
- Infrastructure Automation
````