#!/usr/bin/env bash
set -euo pipefail

GLOBAL_SKILLS_PATH="${HOME}/.gemini/config/skills"
REMOVE_ECC=false
REMOVE_GLOBAL_INSTRUCTIONS=false
BACKUP_ROOT="${HOME}/.gemini/config/backups"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
UNINSTALL_BACKUP_DIR="${BACKUP_ROOT}/uninstall-${TIMESTAMP}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --path) GLOBAL_SKILLS_PATH="$2"; shift 2 ;;
    --remove-ecc) REMOVE_ECC=true; shift ;;
    --remove-global-instructions) REMOVE_GLOBAL_INSTRUCTIONS=true; shift ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

FAES_SKILLS=(
  "accessibility-review"
  "agent-reliability-self-debugging"
  "api-design"
  "backend-engineering"
  "code-review"
  "code-review-ocr"
  "database-design"
  "design-review"
  "design-system"
  "devops-release"
  "frontend-engineering"
  "karpathy-guidelines"
  "performance-engineering"
  "ponytail"
  "ponytail-audit"
  "ponytail-debt"
  "ponytail-gain"
  "ponytail-help"
  "ponytail-review"
  "product-requirements"
  "project-onboarding"
  "release-hardening"
  "secret-scanning"
  "security-audit"
  "security-review"
  "testing-qa"
  "unslop"
  "visual-qa"
)

is_faes_skill() {
  local target="$1"
  for s in "${FAES_SKILLS[@]}"; do
    if [[ "$s" == "$target" ]]; then
      return 0
    fi
  done
  return 1
}

removed_count=0
preserved_count=0

if [[ -d "${GLOBAL_SKILLS_PATH}" ]]; then
  # Use nullglob to handle empty directories safely
  shopt -s nullglob
  for item in "${GLOBAL_SKILLS_PATH}"/*/; do
    skill_name="$(basename "${item}")"
    if is_faes_skill "${skill_name}"; then
      mkdir -p "${UNINSTALL_BACKUP_DIR}/skills"
      mv "${item}" "${UNINSTALL_BACKUP_DIR}/skills/${skill_name}"
      echo "  Removed FAES skill: ${skill_name} -> backed up to: ${UNINSTALL_BACKUP_DIR}/skills/${skill_name}"
      removed_count=$((removed_count + 1))
    else
      echo "  Preserved non-FAES / custom skill: ${skill_name}"
      preserved_count=$((preserved_count + 1))
    fi
  done
  shopt -u nullglob
else
  echo "Global skills path does not exist: ${GLOBAL_SKILLS_PATH} (nothing to remove)"
fi

if [[ "${REMOVE_GLOBAL_INSTRUCTIONS}" == "true" ]]; then
  GLOBAL_AGENTS="${HOME}/.gemini/AGENTS.md"
  if [[ -f "${GLOBAL_AGENTS}" ]]; then
    mkdir -p "${UNINSTALL_BACKUP_DIR}"
    mv "${GLOBAL_AGENTS}" "${UNINSTALL_BACKUP_DIR}/AGENTS.md"
    echo "  Removed global AGENTS.md -> backed up to: ${UNINSTALL_BACKUP_DIR}/AGENTS.md"
  fi
fi

if [[ "${REMOVE_ECC}" == "true" ]]; then
  ECC_DIR="${HOME}/.gemini/config/plugins/ecc"
  if [[ -d "${ECC_DIR}" ]]; then
    mkdir -p "${UNINSTALL_BACKUP_DIR}"
    mv "${ECC_DIR}" "${UNINSTALL_BACKUP_DIR}/ecc-plugin"
    echo "  Removed ECC plugin -> backed up to: ${UNINSTALL_BACKUP_DIR}/ecc-plugin"
  fi
fi

echo "Selective global uninstall complete. Removed: ${removed_count} FAES skills, Preserved: ${preserved_count} non-FAES skills."
