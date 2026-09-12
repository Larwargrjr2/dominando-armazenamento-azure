#!/usr/bin/env bash
set -euo pipefail

RG="${RG:-rg-storage-az900}"
CONTAINER="${CONTAINER:-laboratorio}"
FILE="${FILE:-lab.txt}"

if [[ -z "${STORAGE_ACCOUNT:-}" ]]; then
  STORAGE_ACCOUNT="$(az storage account list -g "$RG" --query "[0].name" -o tsv)"
fi

[[ -n "$STORAGE_ACCOUNT" ]] || { echo "[FAIL] Storage Account não encontrada."; exit 1; }

pass(){ echo "[PASS] $1"; }
fail(){ echo "[FAIL] $1"; exit 1; }

az group show -n "$RG" >/dev/null 2>&1 && pass "Resource Group encontrado" || fail "Resource Group"
az storage account show -g "$RG" -n "$STORAGE_ACCOUNT" >/dev/null 2>&1 && pass "Storage Account encontrada" || fail "Storage Account"

az storage container show \
  --account-name "$STORAGE_ACCOUNT" \
  --name "$CONTAINER" \
  --auth-mode login >/dev/null 2>&1 && pass "Container encontrado" || fail "Container"

TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

az storage blob download \
  --account-name "$STORAGE_ACCOUNT" \
  --container-name "$CONTAINER" \
  --name "evidencias/$FILE" \
  --file "$TMP" \
  --auth-mode login \
  --output none >/dev/null 2>&1 && pass "Blob baixado" || fail "Download do blob"

grep -q "Laboratório Azure Storage" "$TMP" && pass "Conteúdo validado" || fail "Conteúdo"

echo
echo "Endpoint: https://${STORAGE_ACCOUNT}.blob.core.windows.net/"
echo "Todos os testes passaram."
