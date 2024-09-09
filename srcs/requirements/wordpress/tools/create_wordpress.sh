#!/bin/sh

setup_wordpress() {
  echo "Downloading WordPress..."
  wget http://wordpress.org/latest.tar.gz
  tar xfz latest.tar.gz
  mv wordpress/* .
  rm -rf latest.tar.gz wordpress

  echo "Configuring wp-config.php with environment variables..."
  sed -i "s/username_here/$DB_USER/g" wp-config-sample.php
  sed -i "s/password_here/$DB_PASS/g" wp-config-sample.php
  sed -i "s/localhost/$DB_HOST/g" wp-config-sample.php
  sed -i "s/database_name_here/$DB_NAME/g" wp-config-sample.php
  cp wp-config-sample.php wp-config.php
}

install_wordpress() {
  echo "Installing WordPress..."
  while ! wp core install \
        --title="$WP_TITLE" \
        --url="$WP_HOST" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_MAIL" \
        --allow-root
  do
    sleep 1
  done
  wp plugin update --all
  # wp theme install twentysixteen --activate

	# wp user create $WP_USER $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PWD
  # wp post generate --count=5 --post_title="fvoicu"

}

create_wp_user() {
  if wp user get "$WP_USER" --allow-root > /dev/null 2>&1; then
    echo "User '$WP_USER' already exists, skipping creation."
  else
    echo "Creating new WordPress user..."
    wp user create "$WP_USER" "$WP_MAIL" --user_pass="$WP_PASS" --allow-root
  fi
}

check_wordpress_users() {
  echo "Checking for at least two users and validating the administrator's username..."

  USER_COUNT=$(wp user list --field=ID --allow-root | wc -l)
  ADMIN_USER=$(wp user list --role=administrator --field=user_login --allow-root)

  if [ "$USER_COUNT" -lt 2 ]; then
    echo "Error: There must be at least two users in the WordPress database."
    exit 1
  fi

  if echo "$ADMIN_USER" | grep -iE 'admin|administrator'; then
    echo "Error: Administrator username contains 'admin' or 'administrator'."
    exit 1
  fi

  echo "User validation passed."
}

if [ -f ./wp-config.php ]; then
  echo "WordPress already downloaded."
else
  setup_wordpress
fi

install_wordpress
create_wp_user
check_wordpress_users

exec "$@"
