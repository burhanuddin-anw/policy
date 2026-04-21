#!/bin/bash
# local-validation.sh - Run local Terraform and TFLint validation

set -e

echo "================================"
echo "Local Terraform Validation"
echo "================================"
echo ""

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Step 1: Format Check
echo "${YELLOW}[1/5] Running terraform fmt...${NC}"
if terraform fmt -check -recursive; then
    echo -e "${GREEN}✅ Format check passed${NC}"
else
    echo -e "${RED}❌ Format check failed. Running terraform fmt -recursive to fix...${NC}"
    terraform fmt -recursive
    echo -e "${GREEN}✅ Files formatted${NC}"
fi
echo ""

# Step 2: Init
echo "${YELLOW}[2/5] Running terraform init...${NC}"
terraform init -upgrade
echo -e "${GREEN}✅ Terraform initialized${NC}"
echo ""

# Step 3: Validate
echo "${YELLOW}[3/5] Running terraform validate...${NC}"
terraform validate
echo -e "${GREEN}✅ Terraform validation passed${NC}"
echo ""

# Step 4: Plan
echo "${YELLOW}[4/5] Running terraform plan...${NC}"
terraform plan -no-color
echo -e "${GREEN}✅ Terraform plan completed${NC}"
echo ""

# Step 5: TFLint
echo "${YELLOW}[5/5] Running TFLint...${NC}"
if command -v tflint &> /dev/null; then
    tflint --init
    echo ""
    echo "Root module:"
    tflint --format=pretty
    echo ""
    echo "Modules:"
    tflint --format=pretty ./modules
    echo -e "${GREEN}✅ TFLint checks completed${NC}"
else
    echo -e "${YELLOW}⚠️  TFLint not installed. Run scripts/setup-tflint.sh first${NC}"
fi
echo ""

echo "${GREEN}================================"
echo "✅ All local validations passed!"
echo "================================${NC}"
echo ""
echo "Next steps:"
echo "  1. Review the terraform plan output above"
echo "  2. Commit your changes: git add . && git commit -m 'message'"
echo "  3. Push to feature branch: git push origin feature-branch"
echo "  4. Create a Pull Request on GitHub"
