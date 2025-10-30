# Deployment Guide for AXL Music Net

## Prerequisites
1. MongoDB Atlas account (free tier available)
2. Cloudinary account (free tier available)
3. Clerk account (free tier available)
4. GitHub repository

## Backend Deployment (Choose one)

### Option 1: Render (Recommended)
1. Go to [render.com](https://render.com)
2. Connect your GitHub repository
3. Create a new Web Service
4. Select your backend folder
5. Set environment variables in Render dashboard
6. Deploy

### Option 2: Railway
1. Go to [railway.app](https://railway.app)
2. Connect GitHub repository
3. Deploy backend folder
4. Set environment variables
5. Deploy

### Option 3: Vercel (Serverless)
1. Install Vercel CLI: `npm i -g vercel`
2. In backend folder: `vercel`
3. Set environment variables in Vercel dashboard

## Frontend Deployment (Choose one)

### Option 1: Vercel (Recommended)
1. Go to [vercel.com](https://vercel.com)
2. Connect GitHub repository
3. Select frontend folder
4. Set build command: `npm run build`
5. Set environment variables
6. Deploy

### Option 2: Netlify
1. Go to [netlify.com](https://netlify.com)
2. Connect GitHub repository
3. Set build command: `npm run build`
4. Set publish directory: `dist`
5. Set environment variables
6. Deploy

## Environment Variables Setup

### Backend (.env)
```
PORT=10000
NODE_ENV=production
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/axl-music
ADMIN_EMAIL=your-email@example.com
CLOUDINARY_API_KEY=your_key
CLOUDINARY_API_SECRET=your_secret
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLERK_PUBLISHABLE_KEY=pk_live_...
CLERK_SECRET_KEY=sk_live_...
FRONTEND_URL=https://your-frontend.vercel.app
```

### Frontend (.env)
```
VITE_CLERK_PUBLISHABLE_KEY=pk_live_...
VITE_API_URL=https://your-backend.render.com/api
```

## Post-Deployment Steps
1. Update CORS origins in backend with your frontend URL
2. Test all functionality
3. Set up custom domains (optional)
4. Monitor logs for any issues

## Quick Deploy Commands
```bash
# Backend
cd backend
npm install
npm start

# Frontend
cd frontend
npm install
npm run build
```