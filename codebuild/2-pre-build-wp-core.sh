
#!/bin/bash


# Set working directory / alias
cd $CODEBUILD_SRC_DIR/src
alias wp='php wp-cli.phar --allow-root'
echo "Running script: $(basename -- "$0")"

echo "Retrieve values from AWS Secret Manager..."
DB_HOST="database-1.cr8mc00ii2ac.eu-north-1.rds.amazonaws.com"  # Hostname of the database
DB_PORT="3306"                     # Default MySQL port
DB_NAME="mydb"             # Name of your WordPress database
DB_USERNAME="Deep"       # Database user
DB_PASSWORD="8SjhoTfVz2GAcADVJcor"    # User's password

echo "Installing WordPress CLI..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

echo "Install Wordpress core files..."
wp core download --locale=en_US --skip-content

echo "Install WordPress Database Configurations..."
wp config create --dbhost=$DB_HOST:$DB_PORT --dbname=$DB_NAME --dbuser=$DB_USERNAME --dbpass=$DB_PASSWORD

if ! $( wp core is-installed ); then
    echo "Install WordPress Database..."
    # Change Options value
    wp core install --url='http://example-elb-url.ap-southeast-1.elb.amazonaws.com/' \
        --title='WordPress' \
        --admin_user='admin' \
        --admin_password='admin' \
        --admin_email='admin@admin.com' \
        --skip-email
fi

