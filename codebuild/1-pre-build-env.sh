#!/bin/bash
set -eo pipefail # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
shopt -s nullglob # https://www.endpoint.com/blog/2016/12/12/bash-loop-wildcards-nullglob-failglob
shopt -s nocasematch # Case Insensitive
shopt -s expand_aliases # Script to check the alias output

# Issue: 
# https://github.com/aws/aws-codebuild-docker-images/issues/205
echo "Reinstall PHP Version 7.2..."
echo "Installing dependencies..."
rm -f /usr/local/bin/php*
rm -f /usr/local/bin/phar*
rm -f /usr/local/bin/pear*
rm -f /usr/local/bin/pecl*
sudo apt update 
sudo apt-get install -y php8.1-cli php8.1-common php8.1-mysql php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl php8.1-xml php8.1-bcmath

echo "Add .htaccess for Apache Server..."
# echo '
# # BEGIN WordPress
# <IfModule mod_rewrite.c>
# RewriteEngine On
# RewriteBase /
# RewriteRule ^index\.php$ - [L]
# RewriteCond %{REQUEST_FILENAME} !-f
# RewriteCond %{REQUEST_FILENAME} !-d
# RewriteRule . /index.php [L]
# </IfModule>
# # END WordPress
# ' >> .htaccess
if [ "x$BUILD_ENV" = "xprod" ]; then
    cp ./codebuild/prod/.htaccess .htaccess
else
    cp ./codebuild/dev/.htaccess .htaccess
fi

