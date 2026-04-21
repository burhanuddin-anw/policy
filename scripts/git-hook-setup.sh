#!/bin/bash
# git-hook-setup.sh - Install git pre-commit hook for local validation

echo "Setting up git pre-commit hook..."

# Create hooks directory if it doesn't exist
mkdir -p .git/hooks

# Copy pre-commit hook
cp scripts/pre-commit-hook.sh .git/hooks/pre-commit

# Make it executable
chmod +x .git/hooks/pre-commit

echo "✅ Pre-commit hook installed successfully!"
echo ""
echo "The hook will run the following checks before each commit:"
echo "  • Terraform format validation"
echo "  • Terraform syntax validation"
echo "  • TFLint (if installed)"
echo ""
echo "To bypass the hook: git commit --no-verify"
