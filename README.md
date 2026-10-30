<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Centris Scraper API by Piloterr – scrape Centris data as JSON" width="100%"></a>
</p>

# Centris Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Centris Scraper API** lets you extract public data from Centris as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Centris Property API** — Read one Centris property from its URL or listing id.
- **Centris Search API** — Search Centris listings by city or by a full results URL.

Use it for property price monitoring, market analytics, investment sourcing or rental yield models.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Centris Property API](#centris-property-api) | `/v2/centris/property` | 1 | Read one Centris property from its URL or listing id. You get price, address, rooms, and the broker. |
| [Centris Search API](#centris-search-api) | `/v2/centris/search` | 1 | Search Centris listings by city or by a full results URL. Use the English or French path. Page through properties for sale. |

## Table of contents

- [How it works](#how-it-works)
- [Centris Property API](#centris-property-api)
- [Centris Search API](#centris-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Centris Property API

Read one Centris property from its URL or listing id. You get price, address, rooms, and the broker.

`GET | POST https://api.piloterr.com/v2/centris/property` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Full Centris listing URL, in English or French. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/centris/property",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.centris.ca/en/condos~for-sale~montreal-le-sud-ouest/17796540",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type CentrisProperty = {
  id?: string;
  url?: string;
  price?: number;
  rooms?: number;
  title?: string;
  broker?: {
    name?: string;
    image?: string;
    title?: string;
    agency?: string;
    phones?: unknown[];
    agency_type?: string;
    contact_url?: string;
    profile_url?: string;
  };
  images?: string[];
  nearby?: string;
  address?: string;
  bedrooms?: number;
  category?: string;
  currency?: string;
  language?: string;
  latitude?: number;
  area_name?: string;
  bathrooms?: number;
  longitude?: number;
  photos_url?: string;
  walk_score?: number;
  description?: string;
  area_summary?: {
    label?: string;
    value?: string;
  }[];
  price_display?: string;
  area_statistics?: {
    id?: string;
    label?: string;
    title?: string;
    slices?: {
      label?: string;
      value?: number;
    }[];
    average?: string;
  }[];
  characteristics?: {
    name?: string;
    value?: string;
  }[];
  municipality_id?: string;
  [key: string]: unknown;
};

const params = new URLSearchParams({
  "query": "https://www.centris.ca/en/condos~for-sale~montreal-le-sud-ouest/17796540",
});

const response = await fetch(`https://api.piloterr.com/v2/centris/property?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as CentrisProperty;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/centris/property
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.centris.ca/en/condos~for-sale~montreal-le-sud-ouest/17796540"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": "17796540",
  "url": "https://www.centris.ca/en/condos~for-sale~montreal-le-sud-ouest/17796540",
  "price": 568000,
  "rooms": 5,
  "title": "Condo for sale in Montréal (Le Sud-Ouest), Montréal (Island), 2365, Rue Saint-Patrick, apt. 207, 17796540 - Centris.ca",
  "broker": {
    "name": "Cassian Bopp",
    "image": "https://mediaserver.centris.ca/media.ashx?id=ADDD250DDD1BDFFDDDDDDDDDDD&t=c&f=I&w=190&h=220",
    "title": "Residential Real Estate Broker",
    "agency": "SOTHEBY'S INTERNATIONAL REALTY QUÉBEC",
    "phones": [],
    "agency_type": "Real Estate Agency",
    "contact_url": "https://www.centris.ca/en/contact-broker/g5475/property/17796540",
    "profile_url": "example"
  },
  "images": [
    "https://mspublic.centris.ca/media.ashx?id=ADDD250DA2C8CC4DDDDDDDDDD2&t=pi&w=640&h=480&sm=c",
    "https://mspublic.centris.ca/media.ashx?id=ADDD250DA2C8CCBDDDDDDDDDDF&t=pi&w=640&h=480&sm=c"
  ],
  "nearby": "Next to Highway, Daycare, Metro, Park, Bicycle path, Elementary school, High school, Public transit",
  "address": "2365, Rue Saint-Patrick, apt. 207, Montréal (Le Sud-Ouest)",
  "bedrooms": 1,
  "category": "Condo for sale",
  "currency": "CAD",
  "language": "en",
  "latitude": 45.482041,
  "area_name": "Montréal (Le Sud-Ouest)",
  "bathrooms": 1,
  "longitude": -73.569347,
  "photos_url": "https://www.centris.ca/en/condos~for-sale~montreal-le-sud-ouest/17796540/photos",
  "walk_score": 95,
  "description": "Goldilocks unit offering a beautifully balanced layout, high-end finishes and exceptional livability. Thoughtfully designed, the spacious…",
  "area_summary": [
    {
      "label": "Population (2021)",
      "value": "84,553"
    },
    {
      "label": "Population variation between 2016 and 2021",
      "value": "8%"
    }
  ],
  "price_display": "$568,000",
  "area_statistics": [
    {
      "id": "age",
      "label": "Age",
      "title": "Population By Age Group",
      "slices": [
        {},
        {}
      ],
      "average": "Average 39 years"
    },
    {
      "id": "income",
      "label": "Incomes",
      "title": "Household Income",
      "slices": [
        {},
        {}
      ],
      "average": "Average $90,100"
    }
  ],
  "characteristics": [
    {
      "name": "Condominium type",
      "value": "Divided"
    },
    {
      "name": "Net area",
      "value": "690 sqft"
    }
  ],
  "municipality_id": "839"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | string |  |
| `url` | string |  |
| `price` | integer |  |
| `rooms` | integer |  |
| `title` | string |  |
| `broker` | object |  |
| `broker.name` | string |  |
| `broker.image` | string |  |
| `broker.title` | string |  |
| `broker.agency` | string |  |
| `broker.phones` | any[] |  |
| `broker.agency_type` | string |  |
| `broker.contact_url` | string |  |
| `broker.profile_url` | string |  |
| `images` | string[] |  |
| `nearby` | string |  |
| `address` | string |  |
| `bedrooms` | integer |  |
| `category` | string |  |
| `currency` | string |  |
| `language` | string |  |
| `latitude` | number |  |
| `area_name` | string |  |
| `bathrooms` | integer |  |
| `longitude` | number |  |

## Centris Search API

Search Centris listings by city or by a full results URL. Use the English or French path. Page through properties for sale.

`GET | POST https://api.piloterr.com/v2/centris/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Place name or a full Centris results URL. |
| `page` | number | — | Page number, starting at 1. Default is 1. |
| `language` | string | — | Results language when query is a place name. Default is en. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/centris/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "montreal",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type CentrisSearch = {
  results?: {
    id?: string;
    url?: string;
    city?: string;
    image?: string;
    price?: number;
    title?: string;
    address?: string;
    bedrooms?: number;
    category?: string;
    currency?: string;
    language?: string;
    latitude?: number;
    bathrooms?: number;
    longitude?: number;
    photo_count?: number;
    price_display?: string;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "montreal",
});

const response = await fetch(`https://api.piloterr.com/v2/centris/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as CentrisSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/centris/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "montreal"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": "17796540",
      "url": "https://www.centris.ca/en/condos~for-sale~montreal-le-sud-ouest/17796540",
      "city": "Montréal (Le Sud-Ouest)",
      "image": "https://mspublic.centris.ca/media.ashx?id=ADDD250DA2C8CC4DDDDDDDDDD2&t=pi&w=320&h=240&sm=c",
      "price": 568000,
      "title": "Condo for sale in Montréal (Le Sud-Ouest), Montréal (Island), 2365, Rue Saint-Patrick, apt. 207, 17796540 - Centris.ca",
      "address": "2365, Rue Saint-Patrick, apt. 207",
      "bedrooms": 1,
      "category": "Condo for sale",
      "currency": "CAD",
      "language": "en",
      "latitude": 45.482041,
      "bathrooms": 1,
      "longitude": -73.569347,
      "photo_count": 33,
      "price_display": "$568,000"
    }
  ],
  "pagination": {
    "next": "https://www.centris.ca/en/properties~for-sale~montreal?page=2",
    "page": 1,
    "per_page": 20,
    "total_pages": 250,
    "total_results": 9912
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | string |  |
| `results[].url` | string |  |
| `results[].city` | string |  |
| `results[].image` | string |  |
| `results[].price` | integer |  |
| `results[].title` | string |  |
| `results[].address` | string |  |
| `results[].bedrooms` | integer |  |
| `results[].category` | string |  |
| `results[].currency` | string |  |
| `results[].language` | string |  |
| `results[].latitude` | number |  |
| `results[].bathrooms` | integer |  |
| `results[].longitude` | number |  |
| `results[].photo_count` | integer |  |
| `results[].price_display` | string |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Property | Search |
|---|---|---|
| cURL (Bash) | [`property`](examples/curl/property.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`property`](examples/php/property.php) | [`search`](examples/php/search.php) |
| C# | [`property`](examples/csharp/Property.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`property`](examples/go/property.go) | [`search`](examples/go/search.go) |
| Java | [`property`](examples/java/PropertyExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`property`](examples/ruby/property.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`property`](examples/nodejs/property.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track asking prices and price drops per area.
- **Market analytics** — Measure inventory, days on market and price per m² / sqft.
- **Investment sourcing** — Detect undervalued properties as soon as they are listed.
- **Rental yield models** — Combine sale and rent listings to estimate yields.
- **Proptech products** — Power portals, valuation tools and alerts with structured listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Centris plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Centris?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/centris/property` **1**, `/v2/centris/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Centris API return?

Each endpoint returns structured JSON: **Centris Property** — `id`, `url`, `price`, `rooms`, `title`, `broker`; **Centris Search** — `results[]`, `results[].id`, `results[].url`, `results[].city`, `results[].image`, `results[].price`.

### How do I paginate Centris results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Can I target a specific country or language?

Yes, use `language` — see the parameter tables above for accepted values.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [Apartments Scraper API](https://github.com/piloterr/apartments-scraper)
- [Argenprop Scraper API](https://github.com/piloterr/argenprop-scraper)
- [Fotocasa Scraper API](https://github.com/piloterr/fotocasa-scraper)
- [Funda Scraper API](https://github.com/piloterr/funda-scraper)
- [Homestra Scraper API](https://github.com/piloterr/homestra-scraper)
- [Idealista Scraper API](https://github.com/piloterr/idealista-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Centris is a trademark of its respective owner. This repository is not affiliated with or endorsed by Centris. Examples are released under the MIT license.</sub>
