#!/bin/bash

# Set to true to enable Slack notification
SLACK_ENABLED=true

# Set to true to install wp-cli if not installed
INSTALL_WP_CLI=true

# Slack webhook URL
SLACK_WEBHOOK_URL=$1

# Check if SLACK_WEBHOOK_URL is set
if [[ -z $SLACK_WEBHOOK_URL ]]; then
    echo "SLACK_WEBHOOK_URL is not set"
    SLACK_ENABLED=false
fi

# Download wp-cli.phar to /tmp directory
echo "Downloading wp-cli.phar..."
curl -o /tmp/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# List all container names associated with the wordpress image
container_names=$(docker ps -aqf "ancestor=wordpress" --format "{{.Names}}")

# Loop through each container name and copy wp-cli.phar
for container_name in $container_names; do
    echo "Checking container: $container_name"

    echo "- Installing latest wp-cli in container: $container_name"
    docker cp /tmp/wp-cli.phar $container_name:/usr/local/bin/wp
    docker exec $container_name chmod +x /usr/local/bin/wp
    # Verify WordPress core using wp-cli
    if ! docker exec --workdir /var/www/html/ --user www-data $container_name wp core verify-checksums; then
        echo "- WordPress Core Checksum verification failed for container: $container_name"
        # Send Slack notification if enabled
        if [[ $SLACK_ENABLED == true ]]; then
            curl -X POST -H 'Content-type: application/json' --data '{"text":"WordPress Core Checksum verification failed for container: '$container_name'"}' $SLACK_WEBHOOK_URL
        fi
    fi

    # Verify WordPress plugins using wp-cli
    if ! docker exec --workdir /var/www/html/ --user www-data $container_name wp plugin verify-checksums --all; then
        echo "- WordPress Plugin Checksum verification failed for container: $container_name"
        # Send Slack notification if enabled
        if [[ $SLACK_ENABLED == true ]]; then
            curl -X POST -H 'Content-type: application/json' --data '{"text":"WordPress Plugin Checksum verification failed for container: '$container_name'"}' $SLACK_WEBHOOK_URL
        fi
    fi

    echo ""
done
