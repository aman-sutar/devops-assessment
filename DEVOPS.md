# DevOps Documentation

<img width="1920" height="1027" alt="show" src="https://github.com/user-attachments/assets/d9b93e5e-0bfc-4513-b530-105a2a0521b4" />


## Setup Guide

### Local Development
```bash
git clone https://github.com/aman-sutar/devops-assessment.git
cd devops-assessment
docker-compose up --build
```

**Access:**
- Frontend: http://localhost:3000
- Backend: http://localhost:8000/api/hello/

### Server Deployment
```bash
git clone https://github.com/aman-sutar/devops-assessment.git
cd devops-assessment
docker-compose up --build -d
```

**Access:**
- Frontend: http://your-server-ip:3000
- Backend: http://your-server-ip:8000/api/hello/

### Infrastructure as Code (Terraform)
```bash
cd terraform
terraform init
terraform plan
terraform apply
```


**Access:**
- Frontend: http://your-server-ip:3000


**Provisions:**
- EC2 Instance with security groups
- Ports 80, 443, 22 open
- Outputs instance public IP for access

### CI/CD Pipeline
The GitHub Actions workflow automatically:
- Tests Django backend and React frontend
- Builds Docker images
- Pushes to Docker Hub: `mt67rtum/devops-assessment-backend` and `mt67rtum/devops-assessment-frontend`
- Deploys to production

## Troubleshooting Log

### Challenge 1: Frontend Build Fails
**Problem:** npm build failed with compatibility issues.
**Solution:** Updated Node.js version to 20-alpine and used `npm ci` instead of `npm ci --only=production`.

### Challenge 2: Django Version Incompatibility
**Problem:** Django 6.0.1 required Python 3.12+.
**Solution:** Downgraded to Django 5.0.1 for Python 3.10 compatibility.

### Challenge 3: Docker Hub Authentication
**Problem:** CI/CD pipeline failed with "push access denied" errors.
**Solution:** Updated Docker Hub username to `mt67rtum` and created proper repositories on Docker Hub.
