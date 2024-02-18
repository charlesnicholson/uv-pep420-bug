#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ ! -f "${SCRIPT_DIR}/uv" ]; then
  echo "uv not found at "${SCRIPT_DIR}", please copy it in"
  exit 1
fi

PYTHON3=$(command -v python3 || true)
if [[ ! -x "${PYTHON3}" ]]; then
  echo "Python3 not found, aborting."
  exit 1
fi

[ -d "${SCRIPT_DIR}/venv" ] && rm -r "${SCRIPT_DIR}/venv"

"${SCRIPT_DIR}/uv" venv -p python3 --seed "${SCRIPT_DIR}/venv"
VIRTUAL_ENV="${SCRIPT_DIR}/venv" "${SCRIPT_DIR}/uv" pip install build
VIRTUAL_ENV="${SCRIPT_DIR}/venv" "${SCRIPT_DIR}/uv" pip install -e "${SCRIPT_DIR}/ns1"
VIRTUAL_ENV="${SCRIPT_DIR}/venv" "${SCRIPT_DIR}/uv" pip install -e "${SCRIPT_DIR}/ns2"
"${SCRIPT_DIR}/venv/bin/python" "${SCRIPT_DIR}/test.py"
