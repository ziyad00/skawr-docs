# Skawr Platform Features

> Detailed feature documentation for each component in the Skawr ecosystem (based on actual implementation)

## Platform Overview

Based on the actual codebase analysis, Skawr consists of these core components:

### Backend Services
- **[Backend API](./backend-api/)** - Main FastAPI service (skawr-indexer) with search, SaaS, and admin functionality
- **[Scraper Service](./scraper-service/)** - Product scraping service with Celery workers (skawr-scraper)

### Frontend Applications
- **[Web App](./web-app/)** - React web application (skawr-web)
- **[Mobile App](./mobile-app/)** - Flutter mobile app (Skawr-Marketplace)

### Supporting Services
- **Model Service** - ML/AI service (skawr-model-service)
- **Cross-sell Service** - Cross-selling recommendations (skawr-cross-sell)

## Core API Routes (Actual Implementation)

### Public API (`/api/v1/`)
- `POST /search` - Product search with hybrid search
- `GET /products/{id}` - Get product details
- `GET /autocomplete` - Search suggestions
- `GET /filters` - Available search filters
- `GET /health` - System health check

### SaaS API (`/api/v1/saas/`)
- `POST /search` - Client-specific product search
- `POST /products/bulk` - Bulk product upload
- `POST /indices` - Create search index
- `DELETE /indices/{name}` - Delete search index

### Admin API (`/api/v1/admin/`)
- `POST /clients` - Create new client
- `GET /clients` - List all clients
- `POST /clients/{id}/api-keys` - Generate API keys
- `GET /usage/costs` - Cost analysis and billing

### Salla Integration (`/api/v1/salla/`)
- `POST /webhook` - Salla webhook handler
- `POST /sync/products` - Sync Salla products
- `GET /oauth/authorize` - OAuth authorization
- `GET /widget/loader.js` - Salla widget loader

### Monitoring (`/api/v1/monitoring/`)
- `GET /health/detailed` - Detailed health check
- `GET /webhooks/metrics` - Webhook metrics
- `GET /stats` - System statistics

## Technology Stack (Actual)

### Backend
- **FastAPI** - Main API framework
- **SQLAlchemy** - Database ORM
- **PostgreSQL** - Primary database
- **Elasticsearch/Typesense** - Search engines
- **Celery** - Background task processing
- **Redis** - Cache and message broker

### Frontend
- **React** - Web application (TypeScript + Vite)
- **Flutter** - Mobile application (iOS/Android)

### Infrastructure
- **AWS** - Cloud infrastructure
- **Docker** - Containerization
- **CI/CD** - Automated deployment pipeline

## Key Features (Based on Code Analysis)

### Authentication & Authorization
- API key authentication middleware
- Rate limiting by client tier
- Role-based access control
- OAuth integration (Salla)

### Search & Discovery
- Hybrid search (keyword + vector)
- Multilingual support (Arabic/English)
- Real-time autocomplete
- Advanced filtering and faceting
- Personalized recommendations

### SaaS Platform
- Multi-tenant architecture
- Client isolation and management
- Usage tracking and billing
- Bulk operations support
- Custom index management

### Integration Features
- Webhook system with retry logic
- Salla marketplace integration
- Widget embedding capability
- Real-time synchronization
- Dead letter queue handling

### Monitoring & Analytics
- Comprehensive health monitoring
- Performance metrics tracking
- Cost analysis and reporting
- Alert management system
- Usage analytics

---

Each platform documentation includes actual API endpoints, features, and capabilities found in the implementation, not theoretical features.