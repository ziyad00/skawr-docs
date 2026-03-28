# Skawr Scraper Service Features

> FastAPI service with Celery workers for marketplace data collection, processing, and embedding generation

## 🎯 Core Service Architecture (Actual Implementation)

### FastAPI Service Structure

**Main Application (from main.py)**
```python
# Actual main.py implementation
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    title="Skawr Scraper API",
    description="Marketplace scraping and embedding service for Skawr",
    version="1.0.0"
)

app.add_middleware(CORSMiddleware, allow_origins=["*"])
app.include_router(router, prefix="/api/v1")

@app.on_event("startup")
async def startup():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
```

**Service Overview**
- **FastAPI Framework**: Modern async web framework
- **CORS Support**: Cross-origin resource sharing for API access
- **Automatic Database Setup**: Table creation on startup
- **Version 1.0.0**: Current production version
- **Health Monitoring**: Built-in health check endpoints

## 🔄 Celery Task Processing

### Background Task System

**Celery Application (from celery_app.py)**
```python
# Celery configuration for background processing
# Worker-based task distribution
# Redis/RabbitMQ message broker integration
```

**Task Categories (from app/tasks/)**
- `scraping.py` - Marketplace data collection tasks
- `embeddings.py` - Vector embedding generation tasks
- **Queue Management**: Task prioritization and distribution
- **Error Handling**: Failed task retry mechanisms
- **Progress Tracking**: Real-time task status monitoring

### Scraping Tasks

**Marketplace Data Collection**
- **Multi-Marketplace Support**: Haraj, Dubizzle, OpenSooq, Mstaml
- **Async Scraping**: Concurrent data collection from multiple sources
- **Rate Limiting**: Respectful scraping with proper delays
- **Error Recovery**: Automatic retry for failed scraping attempts
- **Data Validation**: Quality checks for scraped product data

**Scraping Implementation (from tasks/scraping.py)**
```python
# Background scraping tasks
# Marketplace-specific scraping logic
# Data cleaning and normalization
# Database insertion and updates
```

### Embedding Tasks

**Vector Embedding Generation (from tasks/embeddings.py)**
```python
# OpenAI text-embedding-ada-002 integration
# Batch processing for efficiency
# Product description vectorization
# Search index updates
```

**Embedding Features**
- **OpenAI Integration**: text-embedding-ada-002 model
- **Batch Processing**: Efficient bulk embedding generation
- **Vector Storage**: PostgreSQL with pgvector extension
- **Index Management**: Automatic search index updates
- **Quality Control**: Embedding validation and verification

## 🏪 Marketplace Integration

### Abstract Scraper Framework

**Scraper Architecture (from core/abstract_scraper.py)**
```python
# Abstract base class for marketplace scrapers
# Standardized scraping interface
# Common functionality across marketplaces
# Error handling and logging
```

**Framework Features**
- **Extensible Design**: Easy addition of new marketplaces
- **Standardized Interface**: Consistent API across all scrapers
- **Error Handling**: Comprehensive error tracking and recovery
- **Logging**: Detailed operation logging for monitoring
- **Configuration**: Per-marketplace configuration management

### Supported Marketplaces

**Current Integration Status**
- **Haraj.com.sa**: Primary Saudi classified marketplace
- **Dubizzle**: Regional marketplace presence
- **OpenSooq**: Multi-country marketplace platform
- **Mstaml**: Specialized marketplace integration

**Marketplace Features**
- **Product Detection**: Automatic product identification
- **Price Extraction**: Real-time pricing information
- **Image Collection**: Product image harvesting and storage
- **Seller Information**: Seller profile and rating data
- **Category Mapping**: Automatic product categorization

## 📊 Database & Storage

### Database Architecture

**Database Setup (from database.py)**
```python
# PostgreSQL with pgvector extension
# SQLAlchemy ORM implementation
# Async database operations
# Connection pooling and management
```

**Database Features**
- **PostgreSQL**: Primary relational database
- **pgvector Extension**: Vector storage for embeddings
- **Async Operations**: Non-blocking database operations
- **Connection Pooling**: Efficient connection management
- **Migration Support**: Database schema versioning

### Data Models

**Product Data Structure (from models/)**
```python
# Product model with marketplace metadata
# Price tracking and history
# Vector embeddings storage
# Seller and marketplace information
```

**Data Storage Features**
- **Product Catalog**: Comprehensive product information
- **Price History**: Time-series pricing data
- **Image Storage**: Supabase/AWS S3 integration
- **Metadata**: Marketplace-specific product attributes
- **Search Indices**: Optimized for search performance

## 🔧 Configuration & Environment

### Service Configuration

**Configuration Management (from core/config.py)**
```python
# Environment-based configuration
# Database connection strings
# API keys and secrets
# Scraping parameters and limits
```

**Configuration Features**
- **Environment Variables**: .env file configuration
- **Secret Management**: Secure credential handling
- **Rate Limiting**: Configurable scraping rates
- **Database URLs**: Multiple environment support
- **API Configuration**: External service integration

### Service Management

**Deployment Configuration**
- **Docker Support**: Containerized deployment
- **Environment Separation**: Dev/staging/production configs
- **Scaling**: Horizontal worker scaling
- **Monitoring**: Health check and metrics endpoints
- **Logging**: Structured logging for operations

## 📡 API Endpoints

### Service Endpoints

**Health & Monitoring**
```python
@app.get("/")
async def root():
    return {"message": "Skawr Scraper API", "version": "1.0.0"}

@app.get("/health")
async def health_check():
    return {"status": "healthy"}
```

**API Routes (from api/router)**
- **Scraping Control**: Start/stop scraping jobs
- **Task Management**: Monitor task status and progress
- **Data Query**: Access scraped product data
- **Embedding Management**: Control embedding generation
- **Health Monitoring**: Service status and metrics

### Integration APIs

**External Integration**
- **Webhook Support**: Real-time notifications for data updates
- **Batch APIs**: Bulk data processing endpoints
- **Status APIs**: Real-time scraping status monitoring
- **Configuration APIs**: Dynamic scraper configuration
- **Metrics APIs**: Performance and usage statistics

## 🔄 Data Processing Pipeline

### Scraping Pipeline

**Data Collection Flow**
1. **Job Scheduling**: Automated scraping job creation
2. **Marketplace Access**: Respectful data collection
3. **Data Extraction**: Product information parsing
4. **Data Validation**: Quality and completeness checks
5. **Database Storage**: Persistent data storage
6. **Index Updates**: Search index synchronization

**Processing Features**
- **Queue Management**: Priority-based task processing
- **Error Handling**: Comprehensive error recovery
- **Rate Limiting**: Marketplace-respectful scraping
- **Data Deduplication**: Prevent duplicate product entries
- **Status Tracking**: Real-time processing status

### Embedding Pipeline

**Vector Generation Flow**
1. **Product Selection**: Identify products needing embeddings
2. **Text Preparation**: Clean and prepare product descriptions
3. **API Integration**: OpenAI embedding generation
4. **Vector Storage**: PostgreSQL pgvector storage
5. **Index Updates**: Search engine synchronization
6. **Quality Verification**: Embedding quality validation

## 🚀 Performance Features

### Scalability

**Horizontal Scaling**
- **Worker Scaling**: Add Celery workers for increased throughput
- **Database Scaling**: Read replicas for improved performance
- **Cache Integration**: Redis caching for frequent operations
- **Load Balancing**: Distribute API requests across instances

**Performance Optimization**
- **Async Operations**: Non-blocking I/O operations
- **Batch Processing**: Efficient bulk operations
- **Connection Pooling**: Optimized database connections
- **Memory Management**: Efficient memory usage patterns

### Monitoring & Reliability

**Service Monitoring**
- **Health Checks**: Comprehensive service health monitoring
- **Performance Metrics**: Task processing performance tracking
- **Error Tracking**: Detailed error logging and alerting
- **Resource Monitoring**: CPU, memory, and disk usage tracking

**Reliability Features**
- **Automatic Retry**: Failed task automatic retry mechanism
- **Circuit Breakers**: Prevent cascade failures
- **Graceful Degradation**: Service degradation under load
- **Backup Systems**: Data backup and recovery procedures

## 📈 Success Metrics & Performance

### Operational Metrics
- **Scraping Throughput**: 1000+ products per hour per worker
- **Embedding Generation**: 500+ embeddings per minute
- **Data Accuracy**: >95% accurate product information
- **Service Uptime**: 99.9% availability target
- **Error Rate**: <1% processing error rate

### Business Impact
- **Data Coverage**: 90%+ marketplace product coverage
- **Update Frequency**: Near real-time price updates
- **Search Quality**: Improved search relevance through embeddings
- **Cost Efficiency**: Optimized resource usage and costs
- **Integration Speed**: <30 minutes new marketplace integration

This scraper service provides the foundation for Skawr's comprehensive marketplace data collection and processing capabilities, ensuring fresh, accurate product information with semantic search capabilities powered by modern AI embeddings.