#!/bin/bash

# DevOps Assessment Deployment Script
# This script automates the deployment of the Django-React application

set -e

echo "🚀 Starting deployment process..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Stop existing containers
echo "🛑 Stopping existing containers..."
docker-compose down

# Build and start services
echo "🔨 Building and starting services..."
docker-compose up --build -d

# Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
sleep 10

# Check if services are running
echo "🔍 Checking service status..."
docker-compose ps

# Test backend API
echo "🧪 Testing backend API..."
if curl -f -s http://localhost:8000/api/hello/ > /dev/null; then
    echo "✅ Backend API is working correctly"
else
    echo "❌ Backend API test failed"
    exit 1
fi

# Test frontend
echo "🧪 Testing frontend..."
if curl -f -s http://localhost:3000 > /dev/null; then
    echo "✅ Frontend is working correctly"
else
    echo "❌ Frontend test failed"
    exit 1
fi

echo "🎉 Deployment completed successfully!"
echo "📱 Frontend: http://localhost:3000"
echo "🔧 Backend API: http://localhost:8000/api/hello/"
echo "📋 View logs with: docker-compose logs -f"
