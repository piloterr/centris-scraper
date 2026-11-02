#!/usr/bin/env bash
# Centris Property API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./property.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/centris/property" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode 'query=https://www.centris.ca/en/condos~for-sale~montreal-le-sud-ouest/17796540'
