#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

command -v docker >/dev/null || { echo 'Docker não está instalado neste ambiente.' >&2; exit 1; }
docker info >/dev/null 2>&1 || { echo 'Docker não está disponível. Reinicie o Codespace e tente novamente.' >&2; exit 1; }
docker compose version >/dev/null
if [[ ! -e /dev/kvm || ! -e /dev/net/tun ]]; then
  echo 'Este host não disponibiliza /dev/kvm e /dev/net/tun. O Windows precisa desses dispositivos; não é possível corrigir isso apenas com DNS.' >&2
  exit 1
fi

# Do not replace existing credentials, disks, volumes, or Docker daemon settings.
if [[ ! -e .env ]]; then
  command -v openssl >/dev/null || { echo 'Instale openssl para gerar a senha local.' >&2; exit 1; }
  (
    umask 077
    set -o noclobber
    password="$(openssl rand -hex 16)"
    printf 'USERNAME=Jose\nPASSWORD=%s\n' "$password" > .env
  )
  echo 'Credenciais geradas em .env (não envie esse arquivo ao GitHub).'
fi
docker compose -f windows10.yml config --quiet
echo 'Configuração pronta. Na aba Portas, abra a porta privada 8006 e aguarde a instalação.'
