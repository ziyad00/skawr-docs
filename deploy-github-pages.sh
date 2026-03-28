#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Deploying Skawr Documentation to GitHub Pages${NC}"

# Check if we're in the right directory
if [ ! -f "book.json" ]; then
    echo -e "${RED}❌ book.json not found. Are you in the skawr-docs directory?${NC}"
    exit 1
fi

# Check if Git is initialized
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}📁 Initializing Git repository...${NC}"
    git init
    git branch -m main
fi

# Install GitBook and plugins
echo -e "${BLUE}📦 Installing GitBook plugins...${NC}"
if ! command -v gitbook &> /dev/null; then
    echo -e "${YELLOW}Installing GitBook CLI...${NC}"
    npm install -g gitbook-cli
fi

gitbook install || echo -e "${YELLOW}⚠️ Some plugins failed to install but continuing...${NC}"

# Build the documentation
echo -e "${BLUE}📚 Building documentation...${NC}"
gitbook build

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ GitBook build failed!${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Documentation built successfully!${NC}"

# Create .nojekyll file to prevent GitHub Pages from processing files with underscores
touch _book/.nojekyll

# Add build info
cat > _book/deploy-info.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Deployment Info - Skawr Documentation</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }
        .info-box { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .timestamp { color: #666; font-size: 14px; }
        .success { color: #28a745; }
        .version { font-weight: bold; color: #007bff; }
        .link { color: #007bff; text-decoration: none; }
        .link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="info-box">
        <h2 class="success">🚀 Skawr Documentation - Successfully Deployed</h2>
        <p><strong>Deployment Time:</strong> <span class="timestamp">$(date)</span></p>
        <p><strong>Version:</strong> <span class="version">1.0.0</span></p>
        <p><strong>Built With:</strong> GitBook CLI</p>
        <p><strong>Total Pages:</strong> $(find _book -name "*.html" | wc -l) pages</p>
        <p><strong>Total Size:</strong> $(du -sh _book 2>/dev/null | cut -f1)</p>
        <hr>
        <h3>📖 Navigation</h3>
        <ul>
            <li><a href="index.html" class="link">📚 Documentation Home</a></li>
            <li><a href="#" class="link">🏢 Business Overview</a></li>
            <li><a href="#" class="link">🏗️ Platform Architecture</a></li>
            <li><a href="#" class="link">🔧 Developer Resources</a></li>
        </ul>
        <hr>
        <p><small>🤖 Auto-generated deployment info</small></p>
    </div>
</body>
</html>
EOF

# Git operations
echo -e "${BLUE}📝 Preparing Git commit...${NC}"

# Add all files
git add .

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo -e "${YELLOW}ℹ️ No changes to commit${NC}"
else
    git commit -m "📚 Initial Skawr documentation

- Complete business and technical documentation
- Platform feature specifications
- API reference and developer guides
- GitBook setup with professional styling

🤖 Generated with GitBook CLI
$(date)"
fi

# Check if we have a remote
if ! git remote get-url origin &> /dev/null; then
    echo ""
    echo -e "${YELLOW}🔗 Next steps:${NC}"
    echo ""
    echo -e "${BLUE}1. Create a new GitHub repository${NC}"
    echo "   Go to: https://github.com/new"
    echo "   Repository name: skawr-docs"
    echo "   Make it public for GitHub Pages"
    echo ""
    echo -e "${BLUE}2. Add the repository as remote:${NC}"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/skawr-docs.git"
    echo ""
    echo -e "${BLUE}3. Push to GitHub:${NC}"
    echo "   git push -u origin main"
    echo ""
    echo -e "${BLUE}4. Deploy to GitHub Pages:${NC}"
    echo "   ./deploy-to-github-pages.sh"
    echo ""
    echo -e "${GREEN}📖 Your docs will then be live at:${NC}"
    echo -e "${BLUE}   https://YOUR_USERNAME.github.io/skawr-docs${NC}"

    # Create a helper script for the GitHub Pages deployment
    cat > deploy-to-github-pages.sh << 'GHPAGES_EOF'
#!/bin/bash
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🌐 Deploying to GitHub Pages...${NC}"

# Build fresh documentation
gitbook build

# Create/switch to gh-pages branch
git checkout -B gh-pages

# Remove all files except _book
find . -maxdepth 1 ! -name '_book' ! -name '.git' ! -name '.' -exec rm -rf {} +

# Move _book contents to root
mv _book/* .
rm -rf _book

# Add .nojekyll file
touch .nojekyll

# Commit and push
git add .
git commit -m "🚀 Deploy documentation to GitHub Pages

$(date)"

git push origin gh-pages --force

# Switch back to main
git checkout main

echo -e "${GREEN}✅ Deployed to GitHub Pages!${NC}"
echo -e "${BLUE}📖 Documentation will be available at:${NC}"
echo "   https://YOUR_USERNAME.github.io/skawr-docs"
echo ""
echo -e "${YELLOW}💡 Enable GitHub Pages in repository settings:${NC}"
echo "   Settings → Pages → Source: Deploy from branch → gh-pages → root"
GHPAGES_EOF

    chmod +x deploy-to-github-pages.sh

    echo -e "${GREEN}✅ Created helper script: deploy-to-github-pages.sh${NC}"

else
    # We have a remote, try to push
    echo -e "${BLUE}📤 Pushing to GitHub...${NC}"

    # Push to main branch
    git push -u origin main

    # Auto-deploy to GitHub Pages
    echo -e "${BLUE}🌐 Deploying to GitHub Pages...${NC}"

    # Create/switch to gh-pages branch
    git checkout -B gh-pages

    # Remove all files except _book
    find . -maxdepth 1 ! -name '_book' ! -name '.git' ! -name '.' -exec rm -rf {} + 2>/dev/null || true

    # Move _book contents to root
    mv _book/* . 2>/dev/null || true
    rm -rf _book 2>/dev/null || true

    # Commit and push
    git add .
    git commit -m "🚀 Deploy documentation to GitHub Pages

$(date)" 2>/dev/null || echo "No changes to commit"

    git push origin gh-pages --force

    # Switch back to main
    git checkout main

    echo ""
    echo -e "${GREEN}🎉 Documentation deployed successfully!${NC}"
    echo ""

    # Get the GitHub username from remote URL
    remote_url=$(git remote get-url origin)
    if [[ $remote_url == *"github.com"* ]]; then
        username=$(echo $remote_url | sed -n 's/.*github\.com[:/]\([^/]*\)\/.*/\1/p')
        repo_name=$(echo $remote_url | sed -n 's/.*github\.com[:/][^/]*\/\([^/]*\)\.git*/\1/p')

        echo -e "${BLUE}📖 Your documentation is now live at:${NC}"
        echo -e "${GREEN}   https://$username.github.io/$repo_name${NC}"
        echo ""
        echo -e "${YELLOW}💡 If not working yet:${NC}"
        echo "   1. Go to GitHub repository settings"
        echo "   2. Pages → Source: Deploy from branch → gh-pages → root"
        echo "   3. Wait 2-3 minutes for deployment"
    fi
fi

echo ""
echo -e "${GREEN}✅ Build complete!${NC}"
echo -e "${BLUE}📊 Statistics:${NC}"
echo "   - HTML files: $(find _book -name '*.html' 2>/dev/null | wc -l)"
echo "   - Total size: $(du -sh _book 2>/dev/null | cut -f1)"
echo "   - Git commit: $(git rev-parse --short HEAD 2>/dev/null || echo 'none')"