#!/usr/bin/env bash
set -euo pipefail

PROJECT_PATH=""
AGENT="antigravity"
INCLUDE_UNSLOP=false
INCLUDE_BLA=false
FORCE=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project|-p) PROJECT_PATH="$2"; shift 2 ;;
    --agent|-a) AGENT="$2"; shift 2 ;;
    --include-unslop) INCLUDE_UNSLOP=true; shift ;;
    --include-bla) INCLUDE_BLA=true; shift ;;
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
    if [[ "${skill_name}" == "release-hardening" && "${INCLUDE_BLA}" != "true" ]]; then
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

echo "Installing FAES v3.0.0 into workspace: ${PROJECT_PATH} (agent: ${AGENT})"

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
    # Secret-guard hook scripts (not activated until merged into .claude/settings.json)
    mkdir -p "${PROJECT_PATH}/.claude/hooks"
    for hook in pre-tool-use.js post-tool-use.js faes-secret-guard.mjs; do
      if [[ ! -f "${PROJECT_PATH}/.claude/hooks/${hook}" || "${FORCE}" == "true" ]]; then
        cp "${REPO_ROOT}/adapters/claude/hooks/${hook}" "${PROJECT_PATH}/.claude/hooks/${hook}"
      fi
    done
    echo "  Hook scripts copied to .claude/hooks/. To enable, merge the \"hooks\" object from adapters/claude/hooks.json into .claude/settings.json."
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
  all)
    # 1. Antigravity
    install_skills "${PROJECT_PATH}/.agents/skills"
    if [[ ! -f "${PROJECT_PATH}/AGENTS.md" ]]; then
      cp "${REPO_ROOT}/AGENTS.md" "${PROJECT_PATH}/AGENTS.md"
    fi
    # 2. Claude Code
    install_skills "${PROJECT_PATH}/.claude/skills"
    if [[ ! -f "${PROJECT_PATH}/CLAUDE.md" ]]; then
      cp "${REPO_ROOT}/adapters/claude/CLAUDE.md" "${PROJECT_PATH}/CLAUDE.md"
    fi
    mkdir -p "${PROJECT_PATH}/.claude/hooks"
    for hook in pre-tool-use.js post-tool-use.js faes-secret-guard.mjs; do
      if [[ ! -f "${PROJECT_PATH}/.claude/hooks/${hook}" || "${FORCE}" == "true" ]]; then
        cp "${REPO_ROOT}/adapters/claude/hooks/${hook}" "${PROJECT_PATH}/.claude/hooks/${hook}"
      fi
    done
    echo "  Hook scripts copied to .claude/hooks/. To enable, merge the \"hooks\" object from adapters/claude/hooks.json into .claude/settings.json."
    # 3. Cursor
    mkdir -p "${PROJECT_PATH}/.cursor/rules"
    if [[ ! -f "${PROJECT_PATH}/.cursorrules" ]]; then
      cp "${REPO_ROOT}/adapters/cursor/.cursorrules" "${PROJECT_PATH}/.cursorrules"
    fi
    # 4. Gemini CLI
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
