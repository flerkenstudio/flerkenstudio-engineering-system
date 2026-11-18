#!/usr/bin/env bash
set -euo pipefail

PROJECT_PATH=""
AGENT="antigravity"
INCLUDE_UNSLOP=false
FORCE=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project|-p) PROJECT_PATH="$2"; shift 2 ;;
    --agent|-a) AGENT="$2"; shift 2 ;;
    --include-unslop) INCLUDE_UNSLOP=true; shift ;;
    --force|-f) FORCE=true; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

if [[ -z "${PROJECT_PATH}" ]]; then
  echo "Error: --project <path> is required." >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
SOURCE_SKILLS="${REPO_ROOT}/skills"

install_skills() {
  local target_dir="$1"
  mkdir -p "${target_dir}"
  for skill_dir in "${SOURCE_SKILLS}"/*/; do
    local skill_name="$(basename "${skill_dir}")"
    if [[ "${skill_name}" == "unslop" && "${INCLUDE_UNSLOP}" != "true" ]]; then
      continue
    fi
    local dest="${target_dir}/${skill_name}"
    if [[ -d "${dest}" && "${FORCE}" != "true" ]]; then
      echo "  SKIP existing skill: ${skill_name}"
    else
      cp -r "${skill_dir}" "${dest}"
      echo "  Installed skill: ${skill_name}"
    fi
  done
}

echo "Installing FAES v2.0.0 into workspace: ${PROJECT_PATH} (agent: ${AGENT})"

case "${AGENT}" in
  antigravity)
    install_skills "${PROJECT_PATH}/.agents/skills"
    if [[ ! -f "${PROJECT_PATH}/AGENTS.md" ]]; then
      cp "${REPO_ROOT}/AGENTS.md" "${PROJECT_PATH}/AGENTS.md"
    fi
    ;;
  claude)
    install_skills "${PROJECT_PATH}/.claude/skills"
    if [[ ! -f "${PROJECT_PATH}/CLAUDE.md" ]]; then
      cp "${REPO_ROOT}/adapters/claude/CLAUDE.md" "${PROJECT_PATH}/CLAUDE.md"
    fi
    ;;
  cursor)
    mkdir -p "${PROJECT_PATH}/.cursor/rules"
    if [[ ! -f "${PROJECT_PATH}/.cursorrules" ]]; then
      cp "${REPO_ROOT}/adapters/cursor/.cursorrules" "${PROJECT_PATH}/.cursorrules"
    fi
    ;;
  gemini-cli)
    install_skills "${PROJECT_PATH}/.gemini/skills"
    if [[ ! -f "${PROJECT_PATH}/GEMINI.md" ]]; then
      cp "${REPO_ROOT}/adapters/gemini/GEMINI.md" "${PROJECT_PATH}/GEMINI.md"
    fi
    ;;
  *)
    echo "Unknown agent target: ${AGENT}" >&2
    exit 1
    ;;
esac

echo "Workspace installation complete."
