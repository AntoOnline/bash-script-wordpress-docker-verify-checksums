#!/bin/bash

# Set to true to enable Slack notification
SLACK_ENABLED=false

# Set to true to install wp-cli if not installed
INSTALL_WP_CLI=true

# Slack webhook URL
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/your/slack/webhook/url"

# List all container names associated with the wordpress image
container_names=$(docker ps -aqf "ancestor=wordpress" --format "{{.Names}}")

# Loop through each container name and run the wp core verify-checksums command
for container_name in $container_names; do
    echo "Checking container: $container_name"
    # Check if wp-cli is installed in the container
    if ! docker exec $container_name which wp > /dev/null; then
        echo "wp-cli not found in container: $container_name"
        # Install wp-cli if INSTALL_WP_CLI is true
        if [[ $INSTALL_WP_CLI == true ]]; then
            echo "Installing wp-cli in container: $container_name"
            docker exec $container_name sh -c "curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp"
        fi
        # Send Slack notification if enabled
        if [[ $SLACK_ENABLED == true ]]; then
            curl -X POST -H 'Content-type: application/json' --data '{"text":"wp-cli not found in container: '$container_name'"}' $SLACK_WEBHOOK_URL
        fi
    else
        # Verify checksums using wp-cli
        if ! docker exec --workdir /var/www/html/ --user www-data $container_name wp core verify-checksums; then
            echo "Checksum verification failed for container: $container_name"
            # Send Slack notification if enabled
            if [[ $SLACK_ENABLED == true ]]; then
                curl -X POST -H 'Content-type: application/json' --data '{"text":"Checksum verification failed for container: '$container_name'"}' $SLACK_WEBHOOK_URL
            fi
        fi
    fi
done
