# 🚀 GitHub Direct Deployment Guide

## Frontend (GitHub Pages) - FREE
1. Go to your repo: https://github.com/harshavardhan2006-svg/Axolotl-music-network-
2. Settings → Pages → Source: GitHub Actions
3. Push code to trigger deployment
4. Frontend will be live at: https://harshavardhan2006-svg.github.io/Axolotl-music-network-/

## Backend (Railway) - FREE
1. Go to https://railway.app
2. Login with GitHub
3. New Project → Deploy from GitHub repo
4. Select: harshavardhan2006-svg/Axolotl-music-network-
5. Add environment variables:
   - MONGODB_URI=mongodb+srv://harshacursoracc_db_user:yamahapsre353@music-network.o45z0xx.mongodb.net/?retryWrites=true&w=majority&appName=MUSIC-NETWORK
   - CLERK_PUBLISHABLE_KEY=pk_test_YWNlLXN0b3JrLTEwLmNsZXJrLmFjY291bnRzLmRldiQ
   - CLERK_SECRET_KEY=sk_test_k7Tn1D2U7Ku1F6DSWcG1Ylf9xFLjX5eS8qXAF5esH4
   - CLOUDINARY_CLOUD_NAME=dof0zcvla
   - CLOUDINARY_API_KEY=376416349729277
   - CLOUDINARY_API_SECRET=NvqFrQcf8AYoM-muWBUulr--YJI
   - ADMIN_EMAIL=harshavardhankondaveti1@gmail.com
   - NODE_ENV=production
   - PORT=3000
6. Deploy

## Alternative: Render (FREE)
1. Go to https://render.com
2. Connect GitHub repo
3. Create Web Service
4. Root Directory: backend
5. Build Command: npm install
6. Start Command: npm start
7. Add same environment variables
8. Deploy

## Quick Commands:
```bash
git add .
git commit -m "Add GitHub deployment configs"
git push origin main
```

Your app will be live in 5 minutes! 🎉