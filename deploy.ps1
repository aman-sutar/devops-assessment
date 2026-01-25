# DevOps Assessment Deployment Script (PowerShell)
# This script automates the deployment of the Django-React application

Write-Host "🚀 Starting deployment process..." -ForegroundColor Green

# Check if Docker is installed
try {
    docker --version | Out-Null
    Write-Host "✅ Docker is installed" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker is not installed. Please install Docker first." -ForegroundColor Red
    exit 1
}

# Check if Docker Compose is installed
try {
    docker-compose --version | Out-Null
    Write-Host "✅ Docker Compose is installed" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker Compose is not installed. Please install Docker Compose first." -ForegroundColor Red
    exit 1
}

# Stop existing containers
Write-Host "🛑 Stopping existing containers..." -ForegroundColor Yellow
docker-compose down

# Build and start services
Write-Host "🔨 Building and starting services..." -ForegroundColor Yellow
docker-compose up --build -d

# Wait for services to be ready
Write-Host "⏳ Waiting for services to be ready..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Check if services are running
Write-Host "🔍 Checking service status..." -ForegroundColor Yellow
docker-compose ps

# Test backend API
Write-Host "🧪 Testing backend API..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8000/api/hello/" -UseBasicParsing
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Backend API is working correctly" -ForegroundColor Green
    } else {
        Write-Host "❌ Backend API test failed" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Backend API test failed" -ForegroundColor Red
    exit 1
}

# Test frontend
Write-Host "🧪 Testing frontend..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3000" -UseBasicParsing
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Frontend is working correctly" -ForegroundColor Green
    } else {
        Write-Host "❌ Frontend test failed" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Frontend test failed" -ForegroundColor Red
    exit 1
}

Write-Host "🎉 Deployment completed successfully!" -ForegroundColor Green
Write-Host "📱 Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host "🔧 Backend API: http://localhost:8000/api/hello/" -ForegroundColor Cyan
Write-Host "📋 View logs with: docker-compose logs -f" -ForegroundColor Cyan
