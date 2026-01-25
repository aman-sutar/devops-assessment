# DevOps Documentation

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

**Provisions:**
- EC2 Instance with security groups
- Ports 80, 443, 22 open
- Outputs instance public IP for access

## Troubleshooting Log

### Challenge 1: Frontend Build Fails
**Problem:** npm build failed with compatibility issues.
**Solution:** Updated Node.js version to 20-alpine and used `npm ci` instead of `npm ci --only=production`.

### Challenge 2: Django Version Incompatibility
**Problem:** Django 6.0.1 required Python 3.12+.
**Solution:** Downgraded to Django 5.0.1 for Python 3.10 compatibility.

### Challenge 3: Permission Issues
**Problem:** Containers failed to start as non-root users.
**Solution:** Created dedicated users and set proper file ownership in Dockerfiles.
