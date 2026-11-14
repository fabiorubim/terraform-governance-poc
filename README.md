cd /infrastructure
terraform init
terraform plan -out=tfplan
terraform show -json tfplan > plan.json

cd ..

opa eval \
  --data policies/governance.rego \
  --input infrastructure/plan.json \
  --format pretty \
  'data.terraform.governance.deny'

cd ..
./scripts/policy-check.sh

Agora temos o primeiro gatekeeper funcionando.

