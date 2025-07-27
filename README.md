# phpwpcs - WordPress Coding Standards GitHub Action

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PHP Support](https://img.shields.io/badge/PHP-7.4--8.3-blue.svg)](https://php.net)

A comprehensive GitHub Action for checking WordPress Coding Standards with PHP compatibility support.

## Features

- ✅ **WordPress Coding Standards** - Full support for WordPress, WordPress-Core, WordPress-Extra
- ✅ **PHP Compatibility** - Check compatibility across PHP versions (7.4-8.3)
- ✅ **Flexible Configuration** - Use custom phpcs.xml or built-in defaults
- ✅ **Multiple Standards** - Support for various coding standards
- ✅ **Detailed Reporting** - Full violation reports with error/warning counts
- ✅ **Customizable Failure** - Fail on errors, warnings, or never
- ✅ **Path Filtering** - Check specific directories or files
- ✅ **Pattern Ignoring** - Exclude files/directories with patterns

## Quick Start

```yaml
name: WPCS Check
on: [push, pull_request]

jobs:
  wpcs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: phpwpcs Check
        uses: imjafran/phpwpcs@v1.0.0
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `paths` | Paths to check | No | `.` |
| `standards` | PHPCS standards (WordPress,WordPress-Core,WordPress-Extra,PHPCompatibility) | No | `WordPress,PHPCompatibility` |
| `php-version` | PHP version (7.4-8.3) | No | `8.0` |
| `min-php-version` | Minimum PHP version for compatibility | No | `7.4` |
| `max-php-version` | Maximum PHP version for compatibility | No | `8.3` |
| `config-url` | Custom phpcs.xml URL | No | Built-in default |
| `fail-on` | Fail on (error, warning, never) | No | `error` |
| `ignore-patterns` | Patterns to ignore | No | `vendor/*,node_modules/*,build/*,dist/*` |

## Outputs

| Output | Description |
|--------|-------------|
| `violations` | Total violations (errors + warnings) |
| `errors` | Error count |
| `warnings` | Warning count |
| `files` | Number of files checked |

## Examples

### Basic Usage
```yaml
- name: phpwpcs Check
  uses: imjafran/phpwpcs@v1.0.0
```

### Plugin Development
```yaml
- name: Plugin Standards Check
  uses: imjafran/phpwpcs@v1.0.0
  with:
    paths: 'includes/ admin/ public/'
    standards: 'WordPress,PHPCompatibility'
    php-version: '8.0'
    min-php-version: '7.4'
    max-php-version: '8.3'
    ignore-patterns: 'vendor/*,node_modules/*,tests/*'
```

### Theme Development
```yaml
- name: Theme Standards Check
  uses: imjafran/phpwpcs@v1.0.0
  with:
    standards: 'WordPress-Core,WordPress-Extra'
    ignore-patterns: 'node_modules/*,build/*,dist/*,assets/*'
    fail-on: 'warning'
```

### Custom Configuration
```yaml
- name: Custom phpwpcs Check
  uses: imjafran/phpwpcs@v1.0.0
  with:
    config-url: 'https://example.com/custom-phpcs.xml'
    fail-on: 'never'
```

## Supported Standards

- **WordPress** - Complete WordPress coding standards
- **WordPress-Core** - WordPress core coding standards
- **WordPress-Extra** - WordPress extra coding standards
- **PHPCompatibility** - PHP version compatibility checks

## Technical Details

### PHP Version Support
- **Minimum**: PHP 7.4
- **Maximum**: PHP 8.3
- **Default**: PHP 8.0

### Action Architecture
- **Type**: Composite Action
- **Dependencies**: PHP_CodeSniffer, WordPress Coding Standards, PHP Compatibility
- **Configuration**: Uses phpcs.xml for WordPress standards
- **Outputs**: violations, errors, warnings, files

### File Structure
```
phpwpcs/
├── action.yml              # Main action definition
├── data/phpcs.xml          # Default WordPress configuration
├── scripts/
│   ├── setup.sh           # Install dependencies
│   ├── run-checks.sh      # Execute PHPCS
│   └── validate.sh        # Validate action structure
└── examples/              # Usage examples
```

## Configuration

The action automatically creates a `phpcs.xml` configuration file if one doesn't exist. You can:

1. **Use the built-in default** - Automatically configured for WordPress standards
2. **Provide a custom URL** - Use `config-url` input to specify a custom configuration
3. **Use existing file** - If `phpcs.xml` exists in your repository, it will be used

## Ignore Patterns

Default ignore patterns:
- `vendor/*` - Composer dependencies
- `node_modules/*` - Node.js dependencies
- `build/*` - Build artifacts
- `dist/*` - Distribution files

You can customize these using the `ignore-patterns` input.

## Failure Modes

- **error** (default) - Fail only on errors
- **warning** - Fail on both errors and warnings
- **never** - Never fail, always pass

## Contributing

### For Developers

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes following WordPress Coding Standards
4. Add tests if applicable
5. Run validation: `./scripts/validate.sh`
6. Submit a pull request

### Development Workflow

```bash
# Clone the repository
git clone https://github.com/imjafran/phpwpcs.git
cd phpwpcs

# Install dependencies (if needed)
# The action uses composite action, so no additional dependencies

# Validate the action
./scripts/validate.sh

# Test locally
# Create a test workflow using ./
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Development

### Local Testing
```yaml
- name: phpwpcs Check
  uses: ./
```

### Building and Testing
```bash
# Validate action structure
./scripts/validate.sh

# Run tests
./scripts/release.sh
```

## Support

### For Developers

- **Issues**: [GitHub Issues](https://github.com/imjafran/phpwpcs/issues)
- **Discussions**: [GitHub Discussions](https://github.com/imjafran/phpwpcs/discussions)
- **Documentation**: This README and examples in `/examples`
- **Testing**: Use the test workflow in `.github/workflows/test.yml`

### Reporting Issues

When reporting issues, please include:
- Action version used
- PHP version
- WordPress standards being checked
- Complete error output
- Steps to reproduce
