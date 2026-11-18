#!/usr/bin/env bash
set -euo pipefail

ECC_VERSION="2.2.3"
PLUGIN_ROOT="${HOME}/.gemini/config/plugins/ecc"

echo "ECC package: ecc-universal@${ECC_VERSION}"
echo "Global plugin destination: ${PLUGIN_ROOT}"

mkdir -p "${PLUGIN_ROOT}/ecc"

if [[ ! -f "${PLUGIN_ROOT}/plugin.json" ]]; then
  cat <<EOF > "${PLUGIN_ROOT}/plugin.json"
{
  "name": "ecc",
  "version": "${ECC_VERSION}",
  "description": "Everything Claude Code (ECC) integration plugin for Google Antigravity",
  "publisher": "FlerkenStudio / ECC Community"
}
EOF
fi

if [[ ! -f "${PLUGIN_ROOT}/mcp_config.json" ]]; then
  cat <<EOF > "${PLUGIN_ROOT}/mcp_config.json"
{
  "mcpServers": {}
}
EOF
fi

cat <<EOF > "${PLUGIN_ROOT}/ecc/setup.json"
{
  "version": "${ECC_VERSION}",
  "installedAt": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "profile": "standard"
}
EOF

echo "ECC global plugin structure verified at ${PLUGIN_ROOT}"
