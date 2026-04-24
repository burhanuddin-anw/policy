#!/bin/bash
# setup-tflint.sh - Local TFLint Setup Script

set -e

echo "================================"
echo "TFLint Local Setup Script"
echo "================================"

# Check if tflint is installed
if ! command -v tflint &> /dev/null; then
    echo "📥 Installing TFLint..."
    curl https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
else
    VERSION=$(tflint --version)
    echo "✅ TFLint already installed: $VERSION"
fi

echo ""
echo "📁 Initializing TFLint..."
tflint --init

echo ""
echo "🔍 Running TFLint validation..."
echo ""

# Run TFLint with formatted output
tflint --format=pretty

echo ""
echo "✅ TFLint setup complete!"
echo ""
echo "💡 Tips:"
echo "   - Run 'tflint' to check the root module"
echo "   - Run 'tflint ./modules' to check modules"
echo "   - Run 'tflint --format=json' for machine-readable output"
echo "   - Update .tflint.hcl to customize rules"
