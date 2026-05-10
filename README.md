# Build an Enterprise-style GenAI Platform on AWS EKS using Terraform, Docker,FastAPI, Kubernetes, and ingress routing.
# The platform exposes AI APIs through containerized microservices.
PART 1:-
# DEPLOY TERRAFORM:-

terraform init -upgrade
terraform fmt
terraform validate
teraform plan
terraform apply -auto-approve

# Configure kubectl:-
aws eks update-kubeconfig --region us-east-1 --name genai-eks-cluster
kubectl get nodes
# Expected:-
NAME                           STATUS   AGE
ip-10-0-1-184.ec2.internal    Ready    5m

# — FASTAPI APPLICATION
# Build Docker Image
docker build -t genai-fastapi .
docker run -p 8080:8080 genai-fastapi
curl http://localhost:8080

# Create ECR Repository
aws ecr create-repository --repository-name genai-fastapi

# Login to ECR
aws ecr get-login-password | docker login --username AWS --password-stdin ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com

# Tag Image
docker tag genai-fastapi:latest ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/genai-fastapi:latest
# Push Image
docker push ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/genai-fastapi:latest
# KUBERNETES FILES -
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
# — INSTALL INGRESS CONTROLLER
# Add Helm Repo
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
# Install Ingress Controller
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace
# Verify 
kubectl get pods -n ingress-nginx
# Deploy Ingress
kubectl apply -f ingress.yaml
# Verify Everything
kubectl get pods -n genai
kubectl get svc -n genai
# Expected Final Result
http://LOAD_BALANCER_IP
# And see API Output
{
  "message": "GenAI Platform Running"
}


