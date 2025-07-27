#!/bin/bash
set -e

echo "🔍 Validating WPCS Action structure..."

# Check required files
required_files=(
    "action.yml"
    "README.md"
    "LICENSE"
    "data/phpcs.xml"
    "scripts/setup.sh"
    "scripts/run-checks.sh"
    "examples/basic.yml"
    "examples/plugin.yml"
    "examples/theme.yml"
    ".github/workflows/test.yml"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ Missing: $file"
        exit 1
    fi
done

# Check script permissions
echo "🔧 Checking script permissions..."
chmod +x scripts/*.sh

# Validate action.yml structure
echo "📋 Validating action.yml..."
if ! grep -q "name:" action.yml; then
    echo "❌ action.yml missing name"
    exit 1
fi

if ! grep -q "description:" action.yml; then
    echo "❌ action.yml missing description"
    exit 1
fi

if ! grep -q "runs:" action.yml; then
    echo "❌ action.yml missing runs section"
    exit 1
fi

# Validate phpcs.xml
echo "📋 Validating phpcs.xml..."
if ! grep -q "WordPress" data/phpcs.xml; then
    echo "❌ phpcs.xml missing WordPress standard"
    exit 1
fi

if ! grep -q "PHPCompatibility" data/phpcs.xml; then
    echo "❌ phpcs.xml missing PHPCompatibility standard"
    exit 1
fi

echo "🎉 Validation completed successfully!" 