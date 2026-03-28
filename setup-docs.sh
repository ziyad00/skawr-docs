#!/bin/bash
set -e

echo "🔧 Setting up Skawr Documentation Portal..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if GitBook CLI is installed
if ! command -v gitbook &> /dev/null; then
    echo -e "${YELLOW}Installing GitBook CLI...${NC}"
    npm install -g gitbook-cli
fi

# Install GitBook plugins
echo -e "${BLUE}Installing GitBook plugins...${NC}"
gitbook install

# Create missing documentation files
echo -e "${BLUE}Creating placeholder documentation files...${NC}"

# Developer docs
cat > developer/integration-guides.md << 'EOF'
# Integration Guides

> Step-by-step integration tutorials for different platforms

## Web Integration
- JavaScript SDK integration
- React component usage
- API integration patterns

## Mobile Integration
- iOS SDK setup
- Android SDK setup
- Flutter plugin usage

## Server Integration
- Python SDK
- Node.js SDK
- Direct API integration
EOF

cat > developer/sdk-documentation.md << 'EOF'
# SDK Documentation

> Official SDKs and libraries for Skawr platform

## Available SDKs

### JavaScript/TypeScript
```bash
npm install @skawr/sdk
```

### Python
```bash
pip install skawr-sdk
```

### Flutter/Dart
```bash
flutter pub add skawr_sdk
```

## SDK Usage Examples

### Search Products
```javascript
import { SkawrClient } from '@skawr/sdk';

const client = new SkawrClient('your-api-key');
const results = await client.search('laptop', { limit: 10 });
```
EOF

# Analytics docs
cat > analytics/usage-metrics.md << 'EOF'
# Usage Metrics

> Platform usage statistics and analytics

## Key Metrics
- Daily/Monthly Active Users
- Search volume and patterns
- API usage statistics
- Platform performance metrics

## Dashboards
- Real-time usage dashboard
- Historical trends
- User behavior analytics
EOF

cat > analytics/performance-data.md << 'EOF'
# Performance Data

> System performance metrics and monitoring

## Performance Metrics
- API response times
- Search performance
- Database query optimization
- Infrastructure monitoring

## Alerts & SLAs
- Uptime monitoring
- Performance thresholds
- Alert configurations
EOF

cat > analytics/business-intelligence.md << 'EOF'
# Business Intelligence

> Business insights and analytics

## Revenue Analytics
- Marketplace commission tracking
- Subscription revenue
- Growth metrics

## Market Intelligence
- Popular product categories
- Price trend analysis
- Marketplace performance
EOF

# Partnership docs
cat > partnerships/marketplace-integration.md << 'EOF'
# Marketplace Integration

> Guide for marketplace partners

## Integration Process
1. Technical requirements
2. API integration setup
3. Data synchronization
4. Testing and validation
5. Go-live process

## Benefits
- Increased visibility
- Enhanced search capabilities
- Analytics and insights
EOF

cat > partnerships/salla-plugin.md << 'EOF'
# Salla Plugin Guide

> Integration guide for Salla marketplace

## Plugin Installation
- OAuth setup process
- Widget configuration
- Webhook configuration

## Features
- Product synchronization
- Search widget embedding
- Analytics dashboard
EOF

cat > partnerships/white-label.md << 'EOF'
# White-label Solutions

> Custom branding and white-label options

## Available Solutions
- Custom branded search interface
- API integration with custom UI
- Private label marketplace search

## Implementation
- Branding customization
- API configuration
- Deployment options
EOF

# Appendices
cat > appendices/glossary.md << 'EOF'
# Glossary

> Key terms and definitions

**API**: Application Programming Interface
**SaaS**: Software as a Service
**Marketplace**: E-commerce platform (Haraj, Dubizzle, etc.)
**Vector Search**: AI-powered semantic search
**Embedding**: Numerical representation of text for AI processing
EOF

cat > appendices/faq.md << 'EOF'
# Frequently Asked Questions

## General

**Q: What is Skawr?**
A: Skawr is an AI-powered marketplace aggregator for Saudi Arabia.

**Q: Which marketplaces are supported?**
A: Haraj, Dubizzle, OpenSooq, Mstaml, and more.

## Technical

**Q: What authentication is required?**
A: All API requests require an API key in the X-API-Key header.

**Q: What are the rate limits?**
A: Varies by plan - Free (100/hour), Premium (10,000/hour), Enterprise (custom).
EOF

cat > appendices/changelog.md << 'EOF'
# Changelog

> Platform updates and version history

## v1.3.0 - 2026-03-29
- Enhanced Flutter mobile app
- Improved Firebase integration
- New seller listing features

## v1.2.0 - 2026-03-15
- React web application updates
- Advanced search filtering
- Performance optimizations

## v1.1.0 - 2026-03-01
- Salla marketplace integration
- Webhook system improvements
- Multi-tenant SaaS features

## v1.0.0 - 2026-02-15
- Initial platform release
- Core search functionality
- Basic marketplace integrations
EOF

echo -e "${GREEN}✅ Documentation structure created!${NC}"

# Build GitBook
echo -e "${BLUE}📚 Building GitBook...${NC}"
gitbook build

echo -e "${GREEN}✅ GitBook built successfully!${NC}"

# Serve locally for preview
echo -e "${YELLOW}🌐 Starting local server...${NC}"
echo -e "${BLUE}Documentation will be available at: http://localhost:4000${NC}"
echo -e "${YELLOW}Press Ctrl+C to stop the server${NC}"

gitbook serve