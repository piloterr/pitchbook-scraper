#!/usr/bin/env bash
# PitchBook Company Info API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./company_info.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/pitchbook/company/info" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=11062-99
