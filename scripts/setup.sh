#!/bin/bash
set -e

echo "🔧 Setting up WPCS..."

# Create temp directory
mkdir -p wpcs-temp
cd wpcs-temp

# Install PHPCS and standards
echo "📦 Installing dependencies..."

# Initialize composer project
if ! composer init --name="wpcs/temp" --no-interaction --quiet; then
    echo "❌ Failed to initialize composer project"
    exit 1
fi

# Install PHP_CodeSniffer
echo "📦 Installing PHP_CodeSniffer..."
if ! composer require squizlabs/php_codesniffer:^3.7 --no-interaction --quiet; then
    echo "❌ Failed to install PHP_CodeSniffer"
    exit 1
fi

# Install WordPress Coding Standards
echo "📦 Installing WordPress Coding Standards..."
if ! composer require wp-coding-standards/wpcs:^3.0 --no-interaction --quiet; then
    echo "❌ Failed to install WordPress Coding Standards"
    exit 1
fi

# Install PHP Compatibility
echo "📦 Installing PHP Compatibility..."
if ! composer require phpcompatibility/php-compatibility:^9.3 --no-interaction --quiet; then
    echo "❌ Failed to install PHP Compatibility"
    exit 1
fi

# Configure PHPCS
echo "⚙️ Configuring PHPCS..."
if ! ./vendor/bin/phpcs --config-set installed_paths ./vendor/wp-coding-standards/wpcs,./vendor/phpcompatibility/php-compatibility; then
    echo "❌ Failed to configure PHPCS"
    exit 1
fi

# Verify installation
echo "✅ Available standards:"
if ! ./vendor/bin/phpcs -i; then
    echo "❌ Failed to verify PHPCS installation"
    exit 1
fi

cd ..
echo "🎉 WPCS setup complete!"