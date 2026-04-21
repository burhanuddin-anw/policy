#!/bin/bash
# This script should be run before each commit
# Add to .git/hooks/pre-commit for automatic execution

set -e

echo "🔍 Running pre-commit checks..."
echo ""

# Format check
echo "Checking Terraform format..."
if ! terraform fmt -check -recursive; then
    echo "❌ Format check failed!"
    echo "Run 'terraform fmt -recursive' to fix formatting"
    exit 1
fi

# Validate
echo "Validating Terraform configuration..."
if ! terraform init -backend=false &> /dev/null; then
    terraform init
fi

if ! terraform validate; then
    echo "❌ Terraform validation failed!"
    exit 1
fi

# TFLint check
if command -v tflint &> /dev/null; then
    echo "Running TFLint..."
    if tflint --format=json &> /dev/null; then
        echo "✅ TFLint passed"
    else
        echo "⚠️  TFLint found issues (non-blocking)"
    fi
fi

echo ""
echo "✅ All pre-commit checks passed!"
