#!/usr/bin/env bash
set -euo pipefail

LOCATION="${LOCATION:-eastus}"
RG="${RG:-rg-storage-az900}"
CONTAINER="${CONTAINER:-laboratorio}"
FILE="${FILE:-lab.txt}"

echo "==> Validando Azure CLI..."
az account show >/dev/null

SUFFIX="$(date +%s)$RANDOM"
STORAGE_ACCOUNT="${STORAGE_ACCOUNT:-staz900${SUFFIX}}"
STORAGE_ACCOUNT="$(echo "$STORAGE_ACCOUNT" | tr '[:upper:]' '[:lower:]' | cut -c1-24)"

echo "==> Resource Group: $RG"
az group create --name "$RG" --location "$LOCATION" --output none

echo "==> Criando Storage Account: $STORAGE_ACCOUNT"
az storage account create \
  --name "$STORAGE_ACCOUNT" \
  --resource-group "$RG" \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --kind StorageV2 \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false \
  --output none

echo "==> Criando container privado..."
az storage container create \
  --account-name "$STORAGE_ACCOUNT" \
  --name "$CONTAINER" \
  --public-access off \
  --auth-mode login \
  --output none

echo "Laboratório Azure Storage" > "$FILE"

echo "==> Enviando blob..."
az storage blob upload \
  --account-name "$STORAGE_ACCOUNT" \
  --container-name "$CONTAINER" \
  --name "evidencias/$FILE" \
  --file "$FILE" \
  --auth-mode login \
  --overwrite true \
  --output none

ACCOUNT_ID="$(az storage account show -g "$RG" -n "$STORAGE_ACCOUNT" --query id -o tsv)"
echo
echo "=============================================="
echo "DEPLOY CONCLUÍDO"
echo "Resource Group : $RG"
echo "Storage Account: $STORAGE_ACCOUNT"
echo "Container      : $CONTAINER"
echo "Blob           : evidencias/$FILE"
echo "Endpoint       : https://${STORAGE_ACCOUNT}.blob.core.windows.net/"
echo "Resource ID    : $ACCOUNT_ID"
echo "=============================================="
echo
echo "Para testar:"
echo "STORAGE_ACCOUNT=$STORAGE_ACCOUNT RG=$RG CONTAINER=$CONTAINER ./scripts/test.sh"
