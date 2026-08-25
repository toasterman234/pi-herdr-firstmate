#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$root"

fail=0
for f in README.md AGENTS.md task_plan.md findings.md progress.md docs/architecture.md docs/host-readiness.md docs/setup-plan.md docs/evaluation-plan.md docs/operations-and-recovery.md config/pi-profile.example.env config/hosts.example.yaml; do
  if [[ ! -s "$f" ]]; then echo "missing or empty: $f"; fail=1; fi
done

python3 - <<'PY'
from pathlib import Path
for p in Path('.').rglob('*.yaml'):
    text=p.read_text()
    if '\t' in text:
        raise SystemExit(f'tab found in YAML-like file: {p}')
print('documentation/config presence checks passed')
PY

git diff --check
if [[ "$fail" -ne 0 ]]; then exit "$fail"; fi
echo "doctor passed: $root"
