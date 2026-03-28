#!/bin/bash
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🚀 Skawr Documentation Quick Start${NC}"
echo ""

# Check if we're in the right directory
if [ ! -f "book.json" ]; then
    echo -e "${YELLOW}⚠️ Not in documentation directory. Changing to skawr-docs...${NC}"
    cd skawr-docs 2>/dev/null || {
        echo "❌ skawr-docs directory not found!"
        echo "Run this script from the skawr project root directory."
        exit 1
    }
fi

# Quick menu
echo "Choose an option:"
echo "1. 🔧 Setup (first time)"
echo "2. 📚 Build documentation"
echo "3. 🌐 Serve locally"
echo "4. 🚀 Deploy"
echo "5. 🧹 Clean build"
echo "6. 📊 Show stats"

read -p "Enter choice [1-6]: " choice

case $choice in
    1)
        echo -e "${BLUE}Setting up documentation...${NC}"
        ./setup-docs.sh
        ;;
    2)
        echo -e "${BLUE}Building documentation...${NC}"
        gitbook build
        echo -e "${GREEN}✅ Build complete! Files in _book/${NC}"
        ;;
    3)
        echo -e "${BLUE}Starting local server...${NC}"
        echo -e "${YELLOW}Documentation will be at: http://localhost:4000${NC}"
        echo -e "${YELLOW}Press Ctrl+C to stop${NC}"
        gitbook serve
        ;;
    4)
        echo -e "${BLUE}Deploying documentation...${NC}"
        ./deploy-docs.sh
        ;;
    5)
        echo -e "${BLUE}Cleaning build files...${NC}"
        rm -rf _book node_modules
        echo -e "${GREEN}✅ Clean complete!${NC}"
        ;;
    6)
        echo -e "${BLUE}📊 Documentation Statistics:${NC}"
        echo ""
        echo "📄 Markdown files: $(find . -name '*.md' | wc -l)"
        echo "📖 Total words: $(find . -name '*.md' -exec wc -w {} + | tail -1 | awk '{print $1}')"
        if [ -d "_book" ]; then
            echo "🌐 Built pages: $(find _book -name '*.html' | wc -l)"
            echo "💾 Build size: $(du -sh _book | cut -f1)"
        fi
        echo "⏰ Last modified: $(find . -name '*.md' -exec stat -c %y {} \; | sort | tail -1 | cut -d' ' -f1)"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac