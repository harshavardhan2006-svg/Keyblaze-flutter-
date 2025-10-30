#!/bin/bash

echo "🔧 Setting Environment Variables"
echo "================================"

# Backend Environment Variables
echo "Setting Backend Environment Variables..."
cd backend

# Set backend environment variables
npx vercel env add NODE_ENV production
npx vercel env add PORT 10000
npx vercel env add FRONTEND_URL https://frontend-lqmiqcd7t-harshavardhankondaveti1-gmailcoms-projects.vercel.app

echo "✅ Backend basic env vars set!"
echo "⚠️  You still need to add:"
echo "- MONGODB_URI"
echo "- CLERK_PUBLISHABLE_KEY" 
echo "- CLERK_SECRET_KEY"
echo "- CLOUDINARY_API_KEY"
echo "- CLOUDINARY_API_SECRET"
echo "- CLOUDINARY_CLOUD_NAME"
echo "- ADMIN_EMAIL"

# Frontend Environment Variables
echo "Setting Frontend Environment Variables..."
cd ../frontend

npx vercel env add VITE_API_URL https://backend-co29wugf4-harshavardhankondaveti1-gmailcoms-projects.vercel.app/api

echo "✅ Frontend basic env vars set!"
echo "⚠️  You still need to add:"
echo "- VITE_CLERK_PUBLISHABLE_KEY"

echo ""
echo "🚀 Your Apps Are Live:"
echo "Backend:  https://backend-co29wugf4-harshavardhankondaveti1-gmailcoms-projects.vercel.app"
echo "Frontend: https://frontend-lqmiqcd7t-harshavardhankondaveti1-gmailcoms-projects.vercel.app"