# Skawr Backend API Features

> Main FastAPI service providing search, SaaS platform, admin management, and integration capabilities

## 🎯 Core API Features

### Product Search API (`/api/v1/`)

**Search Endpoints**
- `POST /search` - Hybrid search with keyword + vector search
- `POST /search/track-click` - Track user click-through behavior
- `GET /autocomplete` - Real-time search suggestions
- `GET /query/reformulate` - Query improvement suggestions
- `GET /filters` - Available filters and facets
- `GET /health` - System health and status

**Product Management**
- `GET /products/{product_id}` - Detailed product information
- Product data aggregation from multiple marketplaces
- Real-time price and availability updates
- Product image and specification management

**Search Features (Implementation Details)**
```python
# From routes.py - actual search implementation
@router.post("/search", response_model=SearchResponse)
async def search_products(
    request: SearchRequest,
    db: Session = Depends(get_database),
    search_use_case: SearchProductsUseCase = Depends(get_search_use_case),
    user_id: Optional[UUID] = Depends(get_optional_user),
    client_id: Optional[UUID] = Depends(get_client_id)
)
```

- **Hybrid Search**: Combines keyword and semantic vector search
- **Personalization**: User-specific search result ranking
- **Multi-language**: Native Arabic and English support
- **Advanced Filtering**: Price, category, location, condition filters
- **Faceted Search**: Dynamic facets based on search results

### SaaS Platform API (`/api/v1/saas/`)

**Multi-Tenant Features**
- `POST /search` - Client-isolated search functionality
- `POST /products/bulk` - Bulk product upload for SaaS clients
- `POST /indices` - Create custom search indices
- `DELETE /indices/{index_name}` - Remove client indices

**SaaS Implementation (From Code)**
```python
# From saas_routes.py - actual SaaS functionality
@router.post("/search", response_model=SearchResponse)
async def search_products(
    request: SearchRequest,
    db: Session = Depends(get_database),
    use_case: SaaSSearchUseCase = Depends(get_saas_search_use_case),
    client_id: UUID = Depends(get_client_id)
)
```

**Multi-Tenancy Features**
- **Client Isolation**: Each client has separate data and indices
- **Custom Index Management**: Clients can create and manage their own search indices
- **Bulk Operations**: Efficient bulk product uploads and updates
- **Resource Quotas**: Per-client usage limits and rate limiting

### Admin Management API (`/api/v1/admin/`)

**Client Management**
- `POST /clients` - Create new SaaS clients
- `GET /clients` - List all clients with pagination
- `GET /clients/{client_id}` - Detailed client information
- `POST /clients/{client_id}/api-keys` - Generate API keys
- `DELETE /clients/{client_id}/api-keys/{key_id}` - Revoke API keys

**Cost Management & Billing**
- `GET /usage/costs` - Cost breakdown and billing analytics
- Variable cost tracking (search operations, storage)
- Fixed cost allocation across clients
- Revenue analytics and reporting

**Admin Features (From Code)**
```python
# From admin_routes.py - actual admin functionality
class CostActionBreakdown(BaseModel):
    action: str
    count: int
    unit_cost: float
    total_cost: float

class VariableCosts(BaseModel):
    actions: List[CostActionBreakdown]
    total: float
```

- **API Key Management**: Secure key generation with configurable permissions
- **Usage Analytics**: Detailed tracking of client API usage
- **Cost Attribution**: Track costs per client and operation type
- **Rate Limiting**: Configurable rate limits per client tier

## 🚀 Integration Features

### Salla Marketplace Integration (`/api/v1/salla/`)

**OAuth & Authentication**
- `GET /oauth/authorize` - Salla OAuth authorization flow
- `GET /oauth/callback` - OAuth callback handling
- `POST /onboard` - Salla store onboarding
- `DELETE /offboard` - Remove Salla integration

**Product Synchronization**
- `POST /webhook` - Salla webhook event handler
- `POST /sync/manual` - Manual product synchronization
- `POST /sync/products` - Automated product sync
- `GET /store/info` - Salla store information

**Widget & Analytics**
- `GET /widget/config` - Widget configuration
- `POST /widget/config` - Update widget settings
- `GET /widget/loader.js` - JavaScript widget loader
- `GET /analytics/search` - Search analytics for Salla stores

### Webhook System (`/api/v1/webhook-retry/`)

**Webhook Management**
- `GET /retry/stats` - Webhook retry statistics
- `POST /retry/process` - Process failed webhooks
- `GET /dead-letter` - View failed webhook queue
- `POST /dead-letter/{index}/requeue` - Requeue failed webhooks
- `DELETE /dead-letter/clear` - Clear dead letter queue

**Reliability Features**
```python
# From webhook_retry_routes.py - actual webhook retry logic
@router.get("/retry/stats", response_model=RetryStatistics)
@router.post("/dead-letter/{item_index}/requeue", response_model=RetryQueueResponse)
```

- **Automatic Retry**: Configurable retry policies for failed webhooks
- **Dead Letter Queue**: Failed webhooks stored for manual processing
- **Monitoring**: Comprehensive webhook performance tracking

### Document Management (`/api/v1/documents/`)

**Index Operations**
- `POST /indices` - Create search indices
- `DELETE /indices/{index_name}` - Delete indices
- `GET /indices` - List all indices
- `GET /indices/{index_name}/stats` - Index statistics

**Bulk Operations**
- `POST /indices/{index_name}/documents` - Bulk document upload
- Efficient batch processing for large datasets
- Progress tracking for long-running operations

## 📊 Monitoring & Analytics

### System Monitoring (`/api/v1/monitoring/`)

**Health Monitoring**
- `GET /health` - Basic health check
- `GET /health/detailed` - Comprehensive system health
- `GET /webhooks/health` - Webhook system status
- `GET /config` - System configuration
- `POST /config` - Update configuration

**Performance Metrics**
- `GET /webhooks/metrics` - Webhook performance metrics
- `GET /stats` - System-wide statistics
- `GET /alerts` - Active system alerts
- `POST /alerts/{alert_id}/acknowledge` - Acknowledge alerts

**Monitoring Implementation (From Code)**
```python
# From monitoring_routes.py - actual monitoring features
@router.get("/health/detailed")
async def detailed_health_check():
    # Comprehensive health check including:
    # - Database connectivity
    # - Search engine status
    # - External service health
    # - Resource utilization
```

### Advanced Analytics (`/api/v2/`)

**Search Analytics**
- `POST /search` - Enhanced search with analytics
- `GET /search/suggestions` - AI-powered search suggestions
- `GET /search/analytics` - Search performance analytics

## 🔧 Technical Infrastructure

### Authentication & Security

**API Key Authentication (From Code)**
```python
# From middleware/api_key_auth.py - actual auth implementation
class APIKeyAuthMiddleware:
    async def __call__(self, request: Request, call_next):
        # API key validation
        # Client identification
        # Permission checking
        # Rate limit enforcement
```

**Security Features**
- **API Key Authentication**: Secure key-based authentication
- **Rate Limiting**: Configurable rate limits per client
- **Input Validation**: Comprehensive request validation
- **CORS**: Configurable cross-origin resource sharing

### Database & Search Integration

**Database Models (From Code)**
```python
# From models.py - actual database schema
class APIClient(Base):
    __tablename__ = "api_clients"

    id: Mapped[UUID] = mapped_column(primary_key=True)
    name: Mapped[str]
    rate_limit_tier: Mapped[RateLimitTier]
    created_at: Mapped[datetime]

class Product(Base):
    __tablename__ = "products"
    # Product schema with marketplace integration
```

**Search Engine Integration**
- **Elasticsearch/Typesense**: Dual search engine support
- **Vector Search**: Semantic search with embeddings
- **Real-time Indexing**: Live product data synchronization
- **Custom Indices**: Client-specific search indices

### Configuration Management

**Settings Configuration (From Code)**
```python
# From config/settings.py - actual configuration
class Settings(BaseSettings):
    DATABASE_URL: str
    SEARCH_ENGINE: str = "elasticsearch"  # or "typesense"
    ELASTICSEARCH_HOST: str
    ELASTICSEARCH_PORT: int
    EMBEDDING_MODEL: str
    API_HOST: str = "0.0.0.0"
    API_PORT: int = 8000
```

**Environment Management**
- **Multi-Environment**: Development, staging, production configs
- **Secret Management**: Secure credential handling
- **Feature Flags**: Runtime feature toggling
- **Performance Tuning**: Configurable performance parameters

## 📈 Performance & Scalability

### Performance Features
- **Async Operations**: Full async/await implementation
- **Connection Pooling**: Efficient database connection management
- **Caching**: Redis-based caching for frequent operations
- **Lazy Loading**: On-demand resource initialization
- **Background Tasks**: Celery integration for heavy operations

### Scalability Features
- **Multi-Tenant**: Efficient resource sharing across clients
- **Horizontal Scaling**: Stateless design for easy scaling
- **Load Balancing**: Support for multiple API instances
- **Resource Isolation**: Per-client resource quotas and limits

### Success Metrics
- **Response Time**: <200ms average for search operations
- **Throughput**: 1000+ requests per second capacity
- **Availability**: 99.9% uptime target
- **Error Rate**: <0.1% across all endpoints

This backend API serves as the core engine powering all Skawr functionality, providing robust search capabilities, multi-tenant SaaS features, comprehensive admin tools, and reliable marketplace integrations.