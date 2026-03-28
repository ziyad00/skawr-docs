# API Reference

> Complete reference for Skawr REST APIs

## Base URL
```
https://api.skawr.com
```

## Authentication
All API requests must include an API key in the header:
```
X-API-Key: your_api_key_here
```

## Core Endpoints

### Search API
**POST** `/api/v1/search`

Search for products across all marketplaces.

**Request Body:**
```json
{
  "query": "string",
  "filters": {
    "min_price": 0,
    "max_price": 10000,
    "category": "electronics",
    "source": ["haraj", "dubizzle"]
  },
  "limit": 20,
  "offset": 0
}
```

**Response:**
```json
{
  "products": [
    {
      "id": "uuid",
      "title": "Product Title",
      "price": 999.99,
      "currency": "SAR",
      "source": "haraj",
      "url": "https://...",
      "image_url": "https://..."
    }
  ],
  "total": 1250,
  "facets": {}
}
```

### Product Details
**GET** `/api/v1/products/{product_id}`

Get detailed information for a specific product.

### Autocomplete
**GET** `/api/v1/autocomplete?q={query}&limit={limit}`

Get search suggestions.

## SaaS APIs

### Client Search
**POST** `/api/v1/saas/search`

Client-specific search with isolation.

### Bulk Upload
**POST** `/api/v1/saas/products/bulk`

Upload multiple products for SaaS clients.

## Rate Limits
- **Free Tier**: 100 requests/hour
- **Premium**: 10,000 requests/hour
- **Enterprise**: Custom limits

## Error Codes
- **400**: Bad Request - Invalid parameters
- **401**: Unauthorized - Invalid API key
- **429**: Too Many Requests - Rate limit exceeded
- **500**: Internal Server Error