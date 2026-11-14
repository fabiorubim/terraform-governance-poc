
#!/usr/bin/env bash
set -euo pipefail

PLAN_JSON="${1:-infrastructure/plan.json}"

echo "Validando Terraform com OPA..."

opa eval \
  --fail-defined \
  --data policies/governance.rego \
  --input "$PLAN_JSON" \
  'data.terraform.governance.deny[_]'

echo "Politicas aprovadas."
