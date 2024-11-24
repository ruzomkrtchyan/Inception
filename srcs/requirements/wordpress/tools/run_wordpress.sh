#!/bin/bash

mkdir -p /var/www/html
cd /var/www/html

chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html

if [ ! -e ./wp-config.php ]; then
    rm -rf *
    wp core download --allow-root

    sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
    sed -i "s/database_name_here/$MYSQL_DB/g" wp-config-sample.php
    cp wp-config-sample.php wp-config.php

    wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ROOT_USER_USERNAME --admin_password=$WP_ROOT_USER_PASSWORD --admin_email=$WP_ROOT_USER_EMAIL --skip-email --allow-root
    wp user create $WP_USER_USERNAME $WP_USER_EMAIL --role=$WP_USER_ROLE --user_pass=$WP_USER_PASSWORD --allow-root
    wp plugin update --all --allow-root

    chmod -R a+w wp-config.php wp-content wp-content/plugins wp-content/themes wp-content/uploads
	chown -R www-data:www-data wp-config.php wp-content wp-content/plugins wp-content/themes wp-content/uploads

	rm -rf ./wp-config-sample.php

fi

if wp core update --allow-root; then
    echo "WordPress core updated successfully."
else
    echo "Failed to update WordPress core."
fi

sleep 10

# wp redis enable --allow-root

/usr/sbin/php-fpm8.2 -F
