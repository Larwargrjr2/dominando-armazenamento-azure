#!/usr/bin/env bash
set -euo pipefail
: "${STORAGE_ACCOUNT:?Defina STORAGE_ACCOUNT}"
RG="${RG:-rg-storage-az900}"
CONTAINER="${CONTAINER:-laboratorio}"
FILE="${1:-lab.txt}"

echo "Arquivo: $FILE"
az storage blob upload \
  --account-name "$STORAGE_ACCOUNT" \
  --container-name "$CONTAINER" \
  --name "evidencias/$(basename "$FILE")" \
  --file "$FILE" \
  --auth-mode login \
  --overwrite true
