Write-Host "Starting Kubernetes deployment..." -ForegroundColor Cyan

Write-Host "Loading Docker image into Minikube..." -ForegroundColor Yellow
minikube image load automated-cicd-web-app:1.0

Write-Host "Applying Kubernetes Deployment..." -ForegroundColor Yellow
kubectl apply -f k8s/deployment.yaml

Write-Host "Applying Kubernetes Service..." -ForegroundColor Yellow
kubectl apply -f k8s/service.yaml

Write-Host "Checking deployment..." -ForegroundColor Yellow
kubectl get deployment

Write-Host "Checking pods..." -ForegroundColor Yellow
kubectl get pods

Write-Host "Checking service..." -ForegroundColor Yellow
kubectl get service

Write-Host "Deployment completed!" -ForegroundColor Green