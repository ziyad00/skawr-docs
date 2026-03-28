# Getting Started

> Quick start guide for developers integrating with Skawr platform

## 🚀 Quick Setup

### Prerequisites
- API key from Skawr admin dashboard
- Basic understanding of REST APIs
- Development environment (Python, JavaScript, etc.)

### Authentication
```bash
# All API requests require authentication header
curl -H "X-API-Key: your_api_key_here" \
     https://api.skawr.com/api/v1/health
```

### First API Call
```bash
# Search for products
curl -X POST "https://api.skawr.com/api/v1/search" \
  -H "X-API-Key: your_api_key_here" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "laptop",
    "limit": 10
  }'
```

## 📚 Next Steps
- [API Reference](./api-reference.md) - Complete API documentation
- [Integration Guides](./integration-guides.md) - Step-by-step integration tutorials
- [SDK Documentation](./sdk-documentation.md) - Official SDKs and libraries