# 🚀 Complete Terminal Deployment Guide

## Prerequisites Setup (5 minutes)

### 1. MongoDB Atlas (Free Database)
```bash
# Visit: https://mongodb.com/atlas
# 1. Create free account
# 2. Create cluster (free tier)
# 3. Get connection string
# Format: mongodb+srv://username:password@cluster.mongodb.net/axl-music
```

### 2. Cloudinary (Free Media Storage)
```bash
# Visit: https://cloudinary.com
# 1. Create free account
# 2. Get: API Key, API Secret, Cloud Name
```

### 3. Clerk (Free Authentication)
```bash
# Visit: https://clerk.com
# 1. Create free account
# 2. Create application
# 3. Get: Publishable Key, Secret Key
```

## Backend Deployment (Vercel)

```bash
# Navigate to backend
cd backend

# Login to Vercel
npx vercel login

# Deploy backend
npx vercel --prod

# Set environment variables (run after deployment)
npx vercel env add PORT
# Enter: 10000

npx vercel env add NODE_ENV
# Enter: production

npx vercel env add MONGODB_URI
# Enter: your_mongodb_connection_string

npx vercel env add ADMIN_EMAIL
# Enter: your_email@example.com

npx vercel env add CLOUDINARY_API_KEY
# Enter: your_cloudinary_key

npx vercel env add CLOUDINARY_API_SECRET
# Enter: your_cloudinary_secret

npx vercel env add CLOUDINARY_CLOUD_NAME
# Enter: your_cloudinary_name

npx vercel env add CLERK_PUBLISHABLE_KEY
# Enter: your_clerk_publishable_key

npx vercel env add CLERK_SECRET_KEY
# Enter: your_clerk_secret_key

npx vercel env add FRONTEND_URL
# Enter: https://your-frontend-url.vercel.app

# Redeploy with environment variables
npx vercel --prod
```

## Frontend Deployment (Vercel)

```bash
# Navigate to frontend
cd ../frontend

# Deploy frontend
npx vercel --prod

# Set environment variables
npx vercel env add VITE_CLERK_PUBLISHABLE_KEY
# Enter: your_clerk_publishable_key

npx vercel env add VITE_API_URL
# Enter: https://your-backend-url.vercel.app/api

# Redeploy with environment variables
npx vercel --prod
```

## Alternative: One-Click Deploy

### Backend (Render)
```bash
# Visit: https://render.com
# 1. Connect GitHub: https://github.com/harshavardhan2006-svg/Axolotl-music-network-
# 2. Select backend folder
# 3. Add all environment variables
# 4. Deploy
```

### Frontend (Netlify)
```bash
# Visit: https://netlify.com
# 1. Connect GitHub repo
# 2. Build command: npm run build
# 3. Publish directory: dist
# 4. Add environment variables
# 5. Deploy
```

## Quick Test Commands

```bash
# Test backend
curl https://your-backend-url.vercel.app/api/songs

# Test frontend
curl https://your-frontend-url.vercel.app
```

## 🎉 Your app is now LIVE!

Backend: https://your-backend-url.vercel.app
Frontend: https://your-frontend-url.vercel.app