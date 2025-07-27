#!/bin/bash
set -e

echo "🔍 Running WPCS checks..."

# Validate inputs
if [ -z "$PATHS" ]; then
    PATHS="."
fi

if [ -z "$STANDARDS" ]; then
    STANDARDS="WordPress,PHPCompatibility"
fi

if [ -z "$IGNORE" ]; then
    IGNORE="vendor/*,node_modules/*,build/*,dist/*"
fi

if [ -z "$FAIL_ON" ]; then
    FAIL_ON="error"
fi

PHPCS_BIN="./wpcs-temp/vendor/bin/phpcs"

# Check if PHPCS is available
if [ ! -f "$PHPCS_BIN" ]; then
    echo "❌ PHPCS binary not found at $PHPCS_BIN"
    echo "Please ensure the setup step completed successfully"
    exit 1
fi

# Build command
CMD="$PHPCS_BIN"

if [ -f "phpcs.xml" ]; then
  echo "📋 Using phpcs.xml configuration"
else
  CMD="$CMD --standard=$STANDARDS"
fi

CMD="$CMD --ignore=$IGNORE"
CMD="$CMD --report=full --report-file=wpcs-report.txt"
CMD="$CMD -p --colors"
CMD="$CMD $PATHS"

echo "🚀 Executing: $CMD"

# Run PHPCS
set +e
$CMD
EXIT_CODE=$?
set -e

# Show results
if [ -f "wpcs-report.txt" ]; then
  cat wpcs-report.txt
fi

# Parse results
if [ -f "wpcs-report.txt" ]; then
    # Extract error count
    ERRORS=$(grep -o '[0-9]\+ ERROR' wpcs-report.txt | grep -o '[0-9]\+' | head -1 || echo "0")
    
    # Extract warning count
    WARNINGS=$(grep -o '[0-9]\+ WARNING' wpcs-report.txt | grep -o '[0-9]\+' | head -1 || echo "0")
    
    # Count files checked
    FILES=$(grep -c "FILE:" wpcs-report.txt || echo "0")
else
    ERRORS="0"
    WARNINGS="0"
    FILES="0"
fi

VIOLATIONS=$((ERRORS + WARNINGS))

echo ""
echo "📊 Results:"
echo "   Files: $FILES"
echo "   Errors: $ERRORS"
echo "   Warnings: $WARNINGS"
echo "   Total: $VIOLATIONS"

# Set GitHub outputs
{
  echo "violations=$VIOLATIONS"
  echo "errors=$ERRORS"
  echo "warnings=$WARNINGS"
  echo "files=$FILES"
} >> $GITHUB_OUTPUT

# Determine if should fail
SHOULD_FAIL=false
case "$FAIL_ON" in
  "error")
    [ "$ERRORS" -gt 0 ] && SHOULD_FAIL=true
    ;;
  "warning")
    [ "$VIOLATIONS" -gt 0 ] && SHOULD_FAIL=true
    ;;
  "never")
    SHOULD_FAIL=false
    ;;
esac

if [ "$SHOULD_FAIL" = "true" ]; then
  echo "❌ WPCS check failed!"
  exit 1
else
  echo "✅ WPCS check passed!"
fi