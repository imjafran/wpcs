# Changelog

## [1.0.0] - 2024-12-19

### Changed
- Renamed action from "WPCS" to "phpwpcs"
- Updated all examples and documentation to use the published marketplace version
- Fixed action references from `./` to `imjafran/phpwpcs@v1.0.0`

## [1.0.0] - 2024-12-19

### Added
- Comprehensive README.md with usage examples and documentation
- MIT License file
- .gitignore file for proper repository management
- Data directory with default phpcs.xml configuration
- Validation script to check action structure
- Enhanced error handling in setup.sh and run-checks.sh
- Comprehensive test workflow with edge case testing
- Input validation in run-checks.sh
- Better logging and user feedback throughout the action

### Fixed
- Removed broken external config URL reference
- Fixed action references in example files (changed from `imjafran/wpcs-action@v1` to `./`)
- Improved error handling for composer installation failures
- Enhanced result parsing to handle edge cases
- Added proper fallback mechanisms for configuration
- Fixed PHP version range updating in configuration

### Improved
- Better error messages and user guidance
- More robust configuration handling
- Enhanced test coverage with multiple scenarios
- Improved script reliability and error recovery
- Better organization of files and directories

### Security
- Removed dependency on external URLs for default configuration
- Added validation for downloaded configurations
- Improved error handling to prevent information leakage

## Structure
```
phpwpcs/
├── action.yml              # Main action definition
├── README.md               # Comprehensive documentation
├── LICENSE                 # MIT License
├── .gitignore             # Git ignore rules
├── CHANGELOG.md           # This file
├── data/
│   └── phpcs.xml          # Default configuration
├── configs/
│   └── default-phpcs.xml  # Legacy config (kept for compatibility)
├── scripts/
│   ├── setup.sh           # Setup script with enhanced error handling
│   ├── run-checks.sh      # Main execution script with validation
│   └── validate.sh        # Action structure validation
├── examples/
│   ├── basic.yml          # Basic usage example
│   ├── plugin.yml         # Plugin development example
│   └── theme.yml          # Theme development example
└── .github/workflows/
    └── test.yml           # Comprehensive test workflow
``` 