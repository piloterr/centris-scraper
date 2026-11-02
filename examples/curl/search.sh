#!/usr/bin/env bash
# Centris Search API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./search.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/centris/search" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=montreal
