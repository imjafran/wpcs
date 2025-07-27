#!/bin/bash
set -e

VERSION="1.0.0"
RELEASE_DATE=$(date +"%Y-%m-%d")

echo "🚀 Preparing phpwpcs GitHub Action Release v$VERSION"

# Validate action structure
echo "🔍 Validating action structure..."
./scripts/validate.sh

# Check git status
echo "📋 Checking git status..."
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Warning: There are uncommitted changes"
    git status --short
    read -p "Continue with release? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Release cancelled"
        exit 1
    fi
fi

# Create test file for validation
echo "🧪 Creating test file..."
mkdir -p test-release
cat > test-release/test.php << 'EOF'
<?php
/**
 * Test file for WPCS validation
 * 
 * @package TestPackage
 */
class TestClass {
    /**
     * Test method
     * 
     * @param string $param Parameter.
     * @return void
     */
    public function test_method( $param ) {
        if ( 'test' === $param ) {
            echo esc_html( 'test' );
        }
    }
}
EOF

# Update version in files
echo "📝 Updating version information..."

# Update README.md with version
sed -i.bak "s/uses: \.\//uses: imjafran\/phpwpcs@v$VERSION/g" README.md
sed -i.bak "s/uses: \.\//uses: imjafran\/phpwpcs@v$VERSION/g" examples/*.yml

# Create release notes
echo "📄 Creating release notes..."
cat > RELEASE_NOTES.md << EOF
# phpwpcs v$VERSION Release Notes

## Release Date: $RELEASE_DATE

## What's New

This is the initial release of the phpwpcs GitHub Action, providing comprehensive WordPress Coding Standards checking with PHP compatibility support.

### Features

- ✅ **WordPress Coding Standards** - Full support for WordPress, WordPress-Core, WordPress-Extra
- ✅ **PHP Compatibility** - Check compatibility across PHP versions (7.4-8.3)
- ✅ **Flexible Configuration** - Use custom phpcs.xml or built-in defaults
- ✅ **Multiple Standards** - Support for various coding standards
- ✅ **Detailed Reporting** - Full violation reports with error/warning counts
- ✅ **Customizable Failure** - Fail on errors, warnings, or never
- ✅ **Path Filtering** - Check specific directories or files
- ✅ **Pattern Ignoring** - Exclude files/directories with patterns

### Technical Details

- **PHP Support**: 7.4 - 8.3
- **Standards**: WordPress, WordPress-Core, WordPress-Extra, PHPCompatibility
- **License**: MIT
- **Action Type**: Composite

### Usage

\`\`\`yaml
- name: phpwpcs Check
  uses: imjafran/phpwpcs@v$VERSION
\`\`\`

### Breaking Changes

None - This is the initial release.

### Known Issues

None at this time.

### Support

- GitHub Issues: https://github.com/imjafran/phpwpcs/issues
- Documentation: README.md
- Examples: examples/ directory

---

For detailed information, see the [README.md](README.md) file.
EOF

# Clean up
rm -f README.md.bak examples/*.yml.bak
rm -rf test-release

echo "✅ Release preparation completed!"
echo ""
echo "📋 Next steps:"
echo "1. Review the changes: git diff"
echo "2. Commit changes: git add . && git commit -m 'Prepare v$VERSION release'"
echo "3. Create tag: git tag -a v$VERSION -m 'Release v$VERSION'"
echo "4. Push changes: git push origin main --tags"
echo "5. Create GitHub release using RELEASE_NOTES.md"
echo ""
echo "📄 Release notes saved to: RELEASE_NOTES.md" 