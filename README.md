<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="PitchBook Scraper API by Piloterr – scrape PitchBook data as JSON" width="100%"></a>
</p>

# PitchBook Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr PitchBook Scraper API** lets you extract public data from PitchBook as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **PitchBook Company Info API** — Get a PitchBook company profile: overview, funding, competitors and more via browser rendering.
- **PitchBook Search API** — Search PitchBook for companies, news and profiles by keyword or search URL via browser rendering.

Use it for lead generation, CRM enrichment, market mapping, investment research or job market analytics.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [PitchBook Company Info API](#pitchbook-company-info-api) | `/v2/pitchbook/company/info` | 2 | Get a PitchBook company profile |
| [PitchBook Search API](#pitchbook-search-api) | `/v2/pitchbook/search` | 2 | Search PitchBook for companies, news and profiles by keyword or search URL via browser rendering. |

## Table of contents

- [How it works](#how-it-works)
- [PitchBook Company Info API](#pitchbook-company-info-api)
- [PitchBook Search API](#pitchbook-search-api)
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

## PitchBook Company Info API

Get a PitchBook company profile: overview, funding, competitors and more via browser rendering.

`GET | POST https://api.piloterr.com/v2/pitchbook/company/info` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | PitchBook company id or company profile URL. |
| `return_page_source` | boolean | — | When `true`, return rendered HTML instead of JSON. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/pitchbook/company/info",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "11062-99",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type PitchbookCompanyInfo = {
  url?: string;
  name?: string;
  status?: string;
  website?: string;
  employees?: number;
  company_id?: string;
  description?: string;
  stock_symbol?: string;
  year_founded?: number;
  corporate_office?: {
    city?: string;
    country?: string;
  };
  primary_industry?: string;
};

const params = new URLSearchParams({
  "query": "11062-99",
});

const response = await fetch(`https://api.piloterr.com/v2/pitchbook/company/info?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as PitchbookCompanyInfo;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/pitchbook/company/info
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "11062-99"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "url": "https://pitchbook.com/profiles/company/11062-99",
  "name": "Airbus Group",
  "status": "Public",
  "website": "http://www.airbus.com",
  "employees": 166876,
  "company_id": "11062-99",
  "description": "Airbus is a global aerospace and defense firm.",
  "stock_symbol": "AIR",
  "year_founded": 1960,
  "corporate_office": {
    "city": "Leiden",
    "country": "Netherlands"
  },
  "primary_industry": "Aerospace and Defense"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `url` | string |  |
| `name` | string |  |
| `status` | string |  |
| `website` | string |  |
| `employees` | integer |  |
| `company_id` | string |  |
| `description` | string |  |
| `stock_symbol` | string |  |
| `year_founded` | integer |  |
| `corporate_office` | object |  |
| `corporate_office.city` | string |  |
| `corporate_office.country` | string |  |
| `primary_industry` | string |  |

## PitchBook Search API

Search PitchBook for companies, news and profiles by keyword or search URL via browser rendering.

`GET | POST https://api.piloterr.com/v2/pitchbook/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Keyword or PitchBook search URL. |
| `page` | string | — | Page number for content search (`/search?q=...`). |
| `return_page_source` | boolean | — | When `true`, return rendered HTML instead of JSON. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/pitchbook/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "airbus",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type PitchbookSearch = {
  results?: {
    url?: string;
    type?: string;
    image?: string;
    title?: string;
    category?: string;
    company_id?: string;
    description?: string;
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
  "query": "airbus",
});

const response = await fetch(`https://api.piloterr.com/v2/pitchbook/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as PitchbookSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/pitchbook/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "airbus"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "url": "https://pitchbook.com/profiles/company/11062-99",
      "type": "profile",
      "image": "https://image.pitchbook.com/example_200x200",
      "title": "Airbus Group",
      "category": "Profile Preview",
      "company_id": "11062-99",
      "description": "Airbus is a global aerospace and defense firm."
    }
  ],
  "pagination": {
    "next": "https://pitchbook.com/search?q=airbus&p=2",
    "page": 1,
    "per_page": 10,
    "total_pages": 4,
    "total_results": 33
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].url` | string |  |
| `results[].type` | string |  |
| `results[].image` | string |  |
| `results[].title` | string |  |
| `results[].category` | string |  |
| `results[].company_id` | string |  |
| `results[].description` | string |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Company Info | Search |
|---|---|---|
| cURL (Bash) | [`company-info`](examples/curl/company_info.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`company-info`](examples/php/company_info.php) | [`search`](examples/php/search.php) |
| C# | [`company-info`](examples/csharp/CompanyInfo.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`company-info`](examples/go/company_info.go) | [`search`](examples/go/search.go) |
| Java | [`company-info`](examples/java/CompanyInfoExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`company-info`](examples/ruby/company_info.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`company-info`](examples/nodejs/company_info.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Lead generation** — Build target account lists from public company data.
- **CRM enrichment** — Keep firmographics, websites and descriptions up to date.
- **Market mapping** — Map competitors and segments across countries and industries.
- **Investment research** — Screen companies, funding and signals for deal flow.
- **Job market analytics** — Track hiring, roles and salaries where available.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — PitchBook plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape PitchBook?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/pitchbook/company/info` **2**, `/v2/pitchbook/search` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the PitchBook API return?

Each endpoint returns structured JSON: **PitchBook Company Info** — `url`, `name`, `status`, `website`, `employees`, `company_id`; **PitchBook Search** — `results[]`, `results[].url`, `results[].type`, `results[].image`, `results[].title`, `results[].category`.

### How do I paginate PitchBook results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Can I get the raw HTML instead of JSON?

Yes. Set `return_page_source=true` and the response becomes `{"result": "..."}` with the page source.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [Company Database Scraper API](https://github.com/piloterr/company-data-api)
- [Crunchbase Scraper API](https://github.com/piloterr/crunchbase-scraper)
- [Europages Scraper API](https://github.com/piloterr/europages-scraper)
- [Fiverr Scraper API](https://github.com/piloterr/fiverr-scraper)
- [G2 Scraper API](https://github.com/piloterr/g2-scraper)
- [github-scraper](https://github.com/piloterr/github-scraper)
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

<sub>PitchBook is a trademark of its respective owner. This repository is not affiliated with or endorsed by PitchBook. Examples are released under the MIT license.</sub>
