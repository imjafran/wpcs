 # Installing PHP_CodeSniffers
wget https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.7.1/phpcs.phar
chmod +x phpcs.phar
sudo mv phpcs.phar /usr/local/bin/phpcs

# Installing WPCS
wget https://github.com/WordPress/WordPress-Coding-Standards/archive/master.zip
unzip master.zip

# Installing PHPCompatibility
composer require phpcompatibility/php-compatibility

# Setting up paths
phpcs --config-set installed_paths ./WordPress-Coding-Standards-master,./vendor/phpcompatibility/php-compatibility
phpcs -i

rm phpcs.xml
wget -O phpcs.xml https://raw.githubusercontent.com/imjafran/wpcs/master/data/phpcs.xml

phpcs .