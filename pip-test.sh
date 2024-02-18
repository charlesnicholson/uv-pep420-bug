#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

PYTHON3=$(command -v python3 || true)
if [[ ! -x "${PYTHON3}" ]]; then
  echo "Python3 not found, aborting."
  exit 1
fi

[ -d "${SCRIPT_DIR}/venv" ] && rm -r "${SCRIPT_DIR}/venv"

python3 -m venv "${SCRIPT_DIR}/venv"
"${SCRIPT_DIR}/venv/bin/python" -m pip install --upgrade pip setuptools wheel build
"${SCRIPT_DIR}/venv/bin/python" -m pip install -e ns1.package1
"${SCRIPT_DIR}/venv/bin/python" -m pip install -e ns2.package2
"${SCRIPT_DIR}/venv/bin/python" "${SCRIPT_DIR}/test.py"
