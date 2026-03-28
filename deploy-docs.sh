#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Deploying Skawr Documentation...${NC}"

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
echo -e "${YELLOW}Checking prerequisites...${NC}"

if ! command_exists gitbook; then
    echo -e "${RED}❌ GitBook CLI not found. Installing...${NC}"
    npm install -g gitbook-cli
fi

if ! command_exists git; then
    echo -e "${RED}❌ Git not found. Please install Git first.${NC}"
    exit 1
fi

# Install GitBook plugins if needed
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}📦 Installing GitBook plugins...${NC}"
    gitbook install
fi

# Build GitBook
echo -e "${BLUE}📚 Building GitBook...${NC}"
gitbook build

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ GitBook build failed!${NC}"
    exit 1
fi

echo -e "${GREEN}✅ GitBook built successfully!${NC}"

# Generate API docs if backend is running
echo -e "${YELLOW}📡 Checking for running backend API...${NC}"

if curl -s "http://localhost:8000/openapi.json" > /dev/null 2>&1; then
    echo -e "${BLUE}📊 Generating API documentation from running backend...${NC}"

    # Create API docs directory
    mkdir -p _book/api-docs

    # Download OpenAPI spec
    curl -s "http://localhost:8000/openapi.json" > _book/api-docs/openapi.json

    # Generate HTML documentation if swagger-codegen is available
    if command_exists swagger-codegen; then
        swagger-codegen generate -i _book/api-docs/openapi.json -l html2 -o _book/api-docs/
        echo -e "${GREEN}✅ API documentation generated!${NC}"
    else
        echo -e "${YELLOW}⚠️ swagger-codegen not found. Skipping HTML API docs generation.${NC}"
        echo -e "${BLUE}💡 Install with: npm install -g swagger-codegen${NC}"
    fi
else
    echo -e "${YELLOW}⚠️ Backend API not running on localhost:8000. Skipping API docs generation.${NC}"
    echo -e "${BLUE}💡 Start the backend with: cd skawr-indexer/skawr-indexer && python -m app.main${NC}"
fi

# Optimize images if tools available
if command_exists optipng; then
    echo -e "${BLUE}🖼️ Optimizing PNG images...${NC}"
    find _book -name "*.png" -exec optipng -quiet {} \; 2>/dev/null || true
    echo -e "${GREEN}✅ Images optimized!${NC}"
fi

# Create deployment summary
echo -e "${BLUE}📊 Creating deployment summary...${NC}"

cat > _book/deployment-info.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Deployment Info</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }
        .info-box { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .timestamp { color: #666; font-size: 14px; }
        .success { color: #28a745; }
        .version { font-weight: bold; color: #007bff; }
    </style>
</head>
<body>
    <div class="info-box">
        <h2 class="success">✅ Skawr Documentation Deployed Successfully</h2>
        <p><strong>Deployment Time:</strong> <span class="timestamp">$(date)</span></p>
        <p><strong>Version:</strong> <span class="version">1.0.0</span></p>
        <p><strong>Git Commit:</strong> <code>$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")</code></p>
        <p><strong>Built With:</strong> GitBook CLI</p>
        <p><strong>Total Pages:</strong> $(find _book -name "*.html" | wc -l) pages</p>
        <hr>
        <h3>Quick Links</h3>
        <ul>
            <li><a href="index.html">📖 Documentation Home</a></li>
            <li><a href="api-docs/index.html">📡 API Reference</a> $([ -f "_book/api-docs/index.html" ] && echo "(Available)" || echo "(Not Generated)")</li>
            <li><a href="https://github.com/skawr/skawr-docs">🔧 Source Code</a></li>
        </ul>
    </div>
</body>
</html>
EOF

# Git operations
if [ -d ".git" ]; then
    echo -e "${BLUE}📝 Committing documentation updates...${NC}"
    git add .

    if ! git diff --staged --quiet; then
        git commit -m "📚 Update documentation - $(date '+%Y-%m-%d %H:%M:%S')"
        echo -e "${GREEN}✅ Changes committed to Git!${NC}"
    else
        echo -e "${YELLOW}ℹ️ No changes to commit.${NC}"
    fi
else
    echo -e "${YELLOW}⚠️ Not a Git repository. Skipping Git operations.${NC}"
fi

# Deployment options
echo -e "${BLUE}🌐 Deployment Options:${NC}"
echo ""
echo -e "${YELLOW}Option 1: Local Preview${NC}"
echo -e "  ${BLUE}gitbook serve${NC}  (serves at http://localhost:4000)"
echo ""
echo -e "${YELLOW}Option 2: GitBook.com (requires gitbook.com account)${NC}"
echo -e "  ${BLUE}gitbook publish${NC}  (publishes to gitbook.com)"
echo ""
echo -e "${YELLOW}Option 3: Static Hosting (GitHub Pages, Netlify, etc.)${NC}"
echo -e "  Upload the ${BLUE}_book/${NC} directory to your hosting provider"
echo ""
echo -e "${YELLOW}Option 4: Custom Domain${NC}"
echo -e "  Copy ${BLUE}_book/${NC} contents to your web server"
echo -e "  Example: ${BLUE}rsync -avz _book/ user@docs.skawr.com:/var/www/docs/${NC}"

# Show file sizes
echo ""
echo -e "${BLUE}📊 Build Statistics:${NC}"
echo -e "Build directory: ${YELLOW}_book/${NC}"
echo -e "Total size: ${YELLOW}$(du -sh _book 2>/dev/null | cut -f1)${NC}"
echo -e "HTML files: ${YELLOW}$(find _book -name "*.html" | wc -l)${NC}"
echo -e "CSS files: ${YELLOW}$(find _book -name "*.css" | wc -l)${NC}"
echo -e "JS files: ${YELLOW}$(find _book -name "*.js" | wc -l)${NC}"
echo -e "Images: ${YELLOW}$(find _book -name "*.png" -o -name "*.jpg" -o -name "*.gif" -o -name "*.svg" | wc -l)${NC}"

echo ""
echo -e "${GREEN}🎉 Documentation deployment ready!${NC}"
echo -e "${BLUE}📖 View deployment info: open _book/deployment-info.html${NC}"

# Optional: Open in browser (macOS/Linux)
if command_exists open; then
    read -p "$(echo -e ${YELLOW}Open documentation in browser? [y/N]: ${NC})" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        open _book/index.html
    fi
elif command_exists xdg-open; then
    read -p "$(echo -e ${YELLOW}Open documentation in browser? [y/N]: ${NC})" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        xdg-open _book/index.html
    fi
fi