#!/usr/bin/env bash
set -euo pipefail

GLOBAL_SKILLS_PATH="${HOME}/.gemini/config/skills"
REMOVE_ECC=false
BACKUP_ROOT="${HOME}/.gemini/config/backups"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
UNINSTALL_BACKUP_DIR="${BACKUP_ROOT}/uninstall-${TIMESTAMP}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --remove-ecc) REMOVE_ECC=true; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

if [[ -d "${GLOBAL_SKILLS_PATH}" ]]; then
  mkdir -p "${UNINSTALL_BACKUP_DIR}"
  mv "${GLOBAL_SKILLS_PATH}" "${UNINSTALL_BACKUP_DIR}/skills"
  echo "Global skills backed up to ${UNINSTALL_BACKUP_DIR}/skills"
fi

if [[ "${REMOVE_ECC}" == "true" ]]; then
  ECC_DIR="${HOME}/.gemini/config/plugins/ecc"
  if [[ -d "${ECC_DIR}" ]]; then
    mkdir -p "${UNINSTALL_BACKUP_DIR}"
    mv "${ECC_DIR}" "${UNINSTALL_BACKUP_DIR}/ecc-plugin"
    echo "ECC plugin backed up to ${UNINSTALL_BACKUP_DIR}/ecc-plugin"
  fi
fi

echo "Global uninstall complete."
