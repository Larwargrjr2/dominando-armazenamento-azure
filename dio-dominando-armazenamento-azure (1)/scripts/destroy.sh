#!/usr/bin/env bash
set -euo pipefail
RG="${RG:-rg-storage-az900}"

echo "ATENÇÃO: todos os recursos do Resource Group '$RG' serão removidos."
read -r -p "Digite DELETE para confirmar: " CONFIRM

if [[ "$CONFIRM" != "DELETE" ]]; then
  echo "Operação cancelada."
  exit 0
fi

az group delete --name "$RG" --yes --no-wait
echo "Exclusão iniciada para: $RG"
