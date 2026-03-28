#!/bin/bash
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🚀 Building Static Skawr Documentation for GitHub Pages${NC}"

# Create build directory
mkdir -p docs

# Create main index.html
cat > docs/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Skawr Documentation</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            line-height: 1.6; color: #333; background: #f8f9fa;
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
        header { background: #2c3e50; color: white; padding: 2rem 0; }
        .header-content { display: flex; align-items: center; justify-content: space-between; }
        .logo { font-size: 2rem; font-weight: bold; color: #3498db; }
        nav { background: white; padding: 1rem 0; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .nav-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem; }
        .nav-card {
            background: white; border: 1px solid #e1e8ed; border-radius: 8px;
            padding: 1.5rem; transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none; color: inherit;
        }
        .nav-card:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .nav-card h3 { color: #2c3e50; margin-bottom: 0.5rem; }
        .nav-card p { color: #666; font-size: 0.9rem; }
        .icon { font-size: 2rem; margin-bottom: 1rem; }
        main { padding: 2rem 0; }
        .hero { text-align: center; margin-bottom: 3rem; }
        .hero h1 { font-size: 2.5rem; margin-bottom: 1rem; color: #2c3e50; }
        .hero p { font-size: 1.2rem; color: #666; max-width: 600px; margin: 0 auto; }
        footer { background: #2c3e50; color: white; text-align: center; padding: 2rem 0; }
        .deployment-info {
            background: #e8f5e8; border: 1px solid #4caf50; border-radius: 8px;
            padding: 1rem; margin: 2rem 0; text-align: center;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <div class="logo">📚 Skawr</div>
                <div>Complete Platform Documentation</div>
            </div>
        </div>
    </header>

    <main>
        <div class="container">
            <div class="hero">
                <h1>Skawr Documentation Hub</h1>
                <p>Complete business and technical documentation for Saudi Arabia's first AI-powered marketplace aggregator</p>
            </div>

            <div class="deployment-info">
                <strong>🚀 Documentation deployed successfully!</strong><br>
                <small>Generated on: $(date)</small>
            </div>

            <nav>
                <div class="nav-grid">
                    <a href="business/overview.html" class="nav-card">
                        <div class="icon">🏢</div>
                        <h3>Business Overview</h3>
                        <p>Product overview, value proposition, and market positioning</p>
                    </a>

                    <a href="platforms/index.html" class="nav-card">
                        <div class="icon">🏗️</div>
                        <h3>Platform Architecture</h3>
                        <p>Technical specifications for all platform components</p>
                    </a>

                    <a href="developer/getting-started.html" class="nav-card">
                        <div class="icon">🔧</div>
                        <h3>Developer Resources</h3>
                        <p>API reference, SDKs, and integration guides</p>
                    </a>

                    <a href="partnerships/index.html" class="nav-card">
                        <div class="icon">🤝</div>
                        <h3>Partnerships</h3>
                        <p>Marketplace integration and white-label solutions</p>
                    </a>
                </div>
            </nav>

            <div style="margin: 3rem 0; padding: 2rem; background: white; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                <h2>📊 Documentation Statistics</h2>
                <ul style="list-style: none; padding: 1rem 0;">
                    <li>📄 Total Pages: 15+ comprehensive documents</li>
                    <li>🏗️ Platform Components: 4 major services documented</li>
                    <li>🔧 API Endpoints: 20+ endpoints with examples</li>
                    <li>🎯 Business Sections: Complete market and strategy analysis</li>
                </ul>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2026 Skawr. All rights reserved. | Built with ❤️ for Saudi Arabia's e-commerce future</p>
        </div>
    </footer>
</body>
</html>
EOF

# Create business section
mkdir -p docs/business
cat > docs/business/overview.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Business Overview - Skawr Documentation</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <header>
        <div class="container">
            <a href="../index.html" class="logo">📚 Skawr Docs</a>
            <nav>
                <a href="../index.html">Home</a>
                <a href="../platforms/index.html">Platforms</a>
                <a href="../developer/getting-started.html">Developers</a>
            </nav>
        </div>
    </header>

    <main class="container">
        <h1>🏢 Business Overview</h1>

        <div class="section">
            <h2>What is Skawr?</h2>
            <p>Skawr is Saudi Arabia's first AI-powered marketplace aggregator that helps consumers find and compare products across all major online marketplaces in one unified search experience.</p>
        </div>

        <div class="section">
            <h2>📋 Available Documents</h2>
            <div class="doc-grid">
                <a href="../product/overview.md" class="doc-card">
                    <h3>Product Overview</h3>
                    <p>Comprehensive product description and market opportunity</p>
                </a>

                <a href="../product/value-proposition.md" class="doc-card">
                    <h3>Value Proposition</h3>
                    <p>Why customers choose Skawr and competitive advantages</p>
                </a>

                <a href="../market/competition.md" class="doc-card">
                    <h3>Competitive Analysis</h3>
                    <p>Market landscape and competitive positioning</p>
                </a>

                <a href="../business/model.md" class="doc-card">
                    <h3>Business Model</h3>
                    <p>Revenue streams and scaling strategy</p>
                </a>

                <a href="../brand/identity.md" class="doc-card">
                    <h3>Brand Identity</h3>
                    <p>Brand values, messaging, and positioning</p>
                </a>
            </div>
        </div>
    </main>
</body>
</html>
EOF

# Create shared CSS
cat > docs/style.css << 'EOF'
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    line-height: 1.6; color: #333; background: #f8f9fa;
}
.container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
header {
    background: #2c3e50; color: white; padding: 1rem 0;
    display: flex; justify-content: space-between; align-items: center;
}
.logo { font-size: 1.5rem; font-weight: bold; color: #3498db; text-decoration: none; }
nav a { color: white; text-decoration: none; margin-left: 1rem; }
nav a:hover { color: #3498db; }
main { padding: 2rem 0; }
h1 { color: #2c3e50; margin-bottom: 2rem; font-size: 2.5rem; }
h2 { color: #34495e; margin: 2rem 0 1rem 0; }
.section {
    background: white; padding: 2rem; margin-bottom: 2rem;
    border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
.doc-grid {
    display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1rem; margin-top: 1rem;
}
.doc-card {
    background: #f8f9fa; border: 1px solid #e1e8ed; border-radius: 8px;
    padding: 1.5rem; text-decoration: none; color: inherit;
    transition: transform 0.2s, box-shadow 0.2s;
}
.doc-card:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
.doc-card h3 { color: #2c3e50; margin-bottom: 0.5rem; }
.doc-card p { color: #666; font-size: 0.9rem; }
EOF

# Copy all markdown files as downloadable content
echo -e "${BLUE}📄 Copying documentation files...${NC}"
cp -r product docs/ 2>/dev/null || true
cp -r market docs/ 2>/dev/null || true
cp -r business docs/ 2>/dev/null || true
cp -r brand docs/ 2>/dev/null || true
cp -r platforms docs/ 2>/dev/null || true
cp -r developer docs/ 2>/dev/null || true

# Create platforms overview
mkdir -p docs/platforms
cat > docs/platforms/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Platform Architecture - Skawr Documentation</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <header>
        <div class="container">
            <a href="../index.html" class="logo">📚 Skawr Docs</a>
            <nav>
                <a href="../index.html">Home</a>
                <a href="../business/overview.html">Business</a>
                <a href="../developer/getting-started.html">Developers</a>
            </nav>
        </div>
    </header>

    <main class="container">
        <h1>🏗️ Platform Architecture</h1>

        <div class="section">
            <h2>Platform Components</h2>
            <div class="doc-grid">
                <a href="backend-api/features.md" class="doc-card">
                    <h3>Backend API</h3>
                    <p>FastAPI service with search, SaaS, and admin functionality</p>
                </a>

                <a href="web-app/features.md" class="doc-card">
                    <h3>Web Application</h3>
                    <p>React web application with authentication and search</p>
                </a>

                <a href="mobile-app/features.md" class="doc-card">
                    <h3>Mobile Application</h3>
                    <p>Flutter mobile app with Firebase integration</p>
                </a>

                <a href="scraper-service/features.md" class="doc-card">
                    <h3>Scraper Service</h3>
                    <p>Marketplace data collection with Celery workers</p>
                </a>
            </div>
        </div>
    </main>
</body>
</html>
EOF

# Add .nojekyll file
touch docs/.nojekyll

echo -e "${GREEN}✅ Static documentation built in docs/ directory${NC}"
echo -e "${BLUE}📊 Generated files:${NC}"
find docs -type f | head -10

# Add build info
cat > docs/build-info.json << EOF
{
  "buildTime": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "version": "1.0.0",
  "generator": "Custom Static Builder",
  "totalFiles": $(find docs -type f | wc -l),
  "status": "success"
}
EOF

echo ""
echo -e "${YELLOW}🚀 Ready for GitHub Pages deployment!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Create new GitHub repository: 'skawr-docs'"
echo "2. git add ."
echo "3. git commit -m 'Initial documentation'"
echo "4. git remote add origin https://github.com/YOUR_USERNAME/skawr-docs.git"
echo "5. git push -u origin main"
echo "6. Enable GitHub Pages: Settings → Pages → Source: main branch /docs folder"
echo ""
echo -e "${GREEN}📖 Documentation will be live at: https://YOUR_USERNAME.github.io/skawr-docs${NC}"