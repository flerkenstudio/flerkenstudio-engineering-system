#!/usr/bin/env bash
set -euo pipefail

GLOBAL_SKILLS_PATH="${HOME}/.gemini/config/skills"
PROJECT_PATH=""
REQUIRE_UNSLOP=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --global-path) GLOBAL_SKILLS_PATH="$2"; shift 2 ;;
    --project|-p) PROJECT_PATH="$2"; shift 2 ;;
    --require-unslop) REQUIRE_UNSLOP=true; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

SKILLS=(
  "karpathy-guidelines" "ponytail" "ponytail-review" "ponytail-audit" "ponytail-debt" "ponytail-gain" "ponytail-help"
  "backend-engineering" "frontend-engineering" "database-design" "api-design" "security-review" "testing-qa"
  "code-review" "product-requirements" "devops-release" "performance-engineering" "project-onboarding"
  "design-review" "visual-qa" "design-system" "accessibility-review"
)

if [[ "${REQUIRE_UNSLOP}" == "true" ]]; then
  SKILLS+=("unslop")
fi

ROOTS=()
if [[ -d "${GLOBAL_SKILLS_PATH}" ]]; then
  ROOTS+=("${GLOBAL_SKILLS_PATH}")
fi
if [[ -n "${PROJECT_PATH}" && -d "${PROJECT_PATH}/.agents/skills" ]]; then
  ROOTS+=("${PROJECT_PATH}/.agents/skills")
fi

if [[ ${#ROOTS[@]} -eq 0 ]]; then
  echo "Error: No skill roots found." >&2
  exit 1
fi

MISSING=0

for root in "${ROOTS[@]}"; do
  echo "Verifying skill root: ${root}"
  for skill in "${SKILLS[@]}"; do
    if [[ -f "${root}/${skill}/SKILL.md" ]]; then
      echo "  [OK]   ${skill}"
    else
      echo "  [MISS] ${skill}"
      MISSING=$((MISSING + 1))
    fi
  done
done

if [[ ${MISSING} -gt 0 ]]; then
  echo "Verification failed: ${MISSING} missing skill file(s)." >&2
  exit 1
fi

echo "All ${#SKILLS[@]} verified skills are valid and present."
