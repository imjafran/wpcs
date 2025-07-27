# WPCS - WordPress Coding Standards GitHub Action

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
      
      - name: WPCS Check
        uses: ./
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
- name: WPCS Check
  uses: ./
```

### Plugin Development
```yaml
- name: Plugin Standards Check
  uses: ./
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
  uses: ./
  with:
    standards: 'WordPress-Core,WordPress-Extra'
    ignore-patterns: 'node_modules/*,build/*,dist/*,assets/*'
    fail-on: 'warning'
```

### Custom Configuration
```yaml
- name: Custom WPCS Check
  uses: ./
  with:
    config-url: 'https://example.com/custom-phpcs.xml'
    fail-on: 'never'
```

## Supported Standards

- **WordPress** - Complete WordPress coding standards
- **WordPress-Core** - WordPress core coding standards
- **WordPress-Extra** - WordPress extra coding standards
- **PHPCompatibility** - PHP version compatibility checks

## PHP Version Support

- **Minimum**: PHP 7.4
- **Maximum**: PHP 8.3
- **Default**: PHP 8.0

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

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions, please use the GitHub Issues page.
