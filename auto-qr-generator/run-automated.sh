#!/usr/bin/env bash
# Appelle l'API de synchronisation QR codes toutes les ~10 secondes.

set -u

API_URL="${API_URL:-http://127.0.0.1:8090/api/qr/sync}"
INTERVAL_SECONDS="${INTERVAL_SECONDS:-10}"
CONNECT_TIMEOUT_SECONDS="${CONNECT_TIMEOUT_SECONDS:-3}"
REQUEST_TIMEOUT_SECONDS="${REQUEST_TIMEOUT_SECONDS:-30}"

if ! command -v curl >/dev/null 2>&1; then
  echo "Erreur : curl n'est pas installé." >&2
  exit 1
fi

trap 'echo; echo "Synchronisation arrêtée."; exit 0' INT TERM

echo "Synchronisation QR codes : ${API_URL}"
echo "Pause entre les requêtes : ${INTERVAL_SECONDS} secondes"
echo "Appuyez sur Ctrl+C pour arrêter."

while true; do
  if response="$(curl --fail --silent --show-error \
      --connect-timeout "${CONNECT_TIMEOUT_SECONDS}" \
      --max-time "${REQUEST_TIMEOUT_SECONDS}" \
      --request POST "${API_URL}")"; then
    printf '[%s] OK : %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${response}"
  else
    printf '[%s] Échec de la synchronisation ; nouvelle tentative après la pause.\n' \
      "$(date '+%Y-%m-%d %H:%M:%S')" >&2
  fi

  sleep "${INTERVAL_SECONDS}"
done

# later : run this command : java -jar target/demo-0.0.1-SNAPSHOT.jar

