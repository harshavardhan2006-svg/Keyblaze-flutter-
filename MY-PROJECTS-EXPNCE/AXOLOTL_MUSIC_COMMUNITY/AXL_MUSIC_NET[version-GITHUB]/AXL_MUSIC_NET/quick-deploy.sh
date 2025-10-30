#!/bin/bash

echo "🎵 AXL Music Network - Quick Deploy Script"
echo "=========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Step 1: Deploy Backend${NC}"
echo "cd backend && npx vercel login && npx vercel --prod"

echo -e "${YELLOW}Step 2: Deploy Frontend${NC}"
echo "cd frontend && npx vercel --prod"

echo -e "${GREEN}✅ Run these commands manually:${NC}"
echo ""
echo "1. cd backend"
echo "2. npx vercel login"
echo "3. npx vercel --prod"
echo "4. Set environment variables in Vercel dashboard"
echo "5. cd ../frontend"
echo "6. npx vercel --prod"
echo "7. Set environment variables in Vercel dashboard"
echo ""
echo -e "${GREEN}🚀 Your app will be live in 5 minutes!${NC}"
echo ""
echo "📖 Full guide: cat TERMINAL_DEPLOY.md"