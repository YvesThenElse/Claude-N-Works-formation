#!/bin/sh
# Lance Claude Code **isolé** : seuls les serveurs MCP et les réglages de cet exercice
# sont chargés. Sans cela la session hériterait de votre configuration personnelle —
# mesuré : 89 outils offerts au lieu de 20, quatre serveurs MCP au lieu d'un — et votre
# écran ne ressemblerait pas aux captures de l'énoncé.
cd "$(dirname "$0")" || exit 1
exec claude \
  --strict-mcp-config \
  --mcp-config .mcp.json \
  --setting-sources project \
  "$@"
