#!/bin/bash

echo "🚀 AXL Music Network Deployment Script"
echo "======================================"

# Step 1: Deploy Backend to Vercel
echo "📦 Deploying Backend..."
cd backend
echo "Run these commands manually:"
echo "1. npx vercel login"
echo "2. npx vercel --prod"
echo "3. Set environment variables in Vercel dashboard"

# Step 2: Deploy Frontend to Vercel  
echo "🎨 Deploying Frontend..."
cd ../frontend
echo "Run these commands manually:"
echo "1. npx vercel login (if not already logged in)"
echo "2. npx vercel --prod"
echo "3. Set environment variables in Vercel dashboard"

echo "✅ Deployment commands ready!"
echo "Visit: https://vercel.com/dashboard to manage deployments"