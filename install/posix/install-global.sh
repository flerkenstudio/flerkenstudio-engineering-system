#!/usr/bin/env bash
set -euo pipefail

FORCE=false
INSTALL_INSTRUCTIONS=false
INCLUDE_UNSLOP=false
GLOBAL_SKILLS_PATH="${HOME}/.gemini/config/skills"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force|-f) FORCE=true; shift ;;
    --instructions|-i) INSTALL_INSTRUCTIONS=true; shift ;;
    --include-unslop) INCLUDE_UNSLOP=true; shift ;;
    --path) GLOBAL_SKILLS_PATH="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
SOURCE_SKILLS="${REPO_ROOT}/skills"
BACKUP_ROOT="${HOME}/.gemini/config/backups"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
SKILLS_BACKUP_DIR="${BACKUP_ROOT}/skills-${TIMESTAMP}"

if [[ ! -d "${SOURCE_SKILLS}" ]]; then
  echo "Error: Skills directory not found at ${SOURCE_SKILLS}" >&2
  exit 1
fi

mkdir -p "${GLOBAL_SKILLS_PATH}"

for skill_dir in "${SOURCE_SKILLS}"/*/; do
  skill_name="$(basename "${skill_dir}")"
  if [[ "${skill_name}" == "unslop" && "${INCLUDE_UNSLOP}" != "true" ]]; then
    echo "SKIP optional skill: unslop (use --include-unslop to install)"
    continue
  fi
  dest="${GLOBAL_SKILLS_PATH}/${skill_name}"
  if [[ -d "${dest}" && "${FORCE}" != "true" ]]; then
    echo "SKIP existing skill: ${skill_name} (use --force to overwrite)"
  else
    if [[ -d "${dest}" ]]; then
      mkdir -p "${SKILLS_BACKUP_DIR}"
      mv "${dest}" "${SKILLS_BACKUP_DIR}/${skill_name}"
      echo "Backed up existing skill to: ${SKILLS_BACKUP_DIR}/${skill_name}"
    fi
    cp -r "${skill_dir}" "${dest}"
    echo "Installed: ${skill_name}"
  fi
done

# Clean up legacy inline .backup-* folders if present
for inline_backup in "${GLOBAL_SKILLS_PATH}"/*.backup-*; do
  if [[ -d "${inline_backup}" ]]; then
    mkdir -p "${SKILLS_BACKUP_DIR}"
    mv "${inline_backup}" "${SKILLS_BACKUP_DIR}/"
    echo "Cleaned up inline backup from active skills root"
  fi
done

if [[ "${INSTALL_INSTRUCTIONS}" == "true" ]]; then
  dest_agents="${HOME}/.gemini/AGENTS.md"
  if [[ -f "${dest_agents}" ]]; then
    echo "Existing ~/.gemini/AGENTS.md preserved."
  else
    cp "${REPO_ROOT}/global/AGENTS.md" "${dest_agents}"
    echo "Installed global AGENTS.md"
  fi
fi

echo "Global FAES v2.0.0 skills successfully installed to ${GLOBAL_SKILLS_PATH}"
