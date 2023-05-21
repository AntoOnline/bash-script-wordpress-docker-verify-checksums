# WordPress Docker Verify Checksums

This script, `wordpress-docker-verify-checksums.sh`, checks the integrity of WordPress core files within Docker containers running the WordPress image. It verifies the checksums of the files using `wp-cli`, and sends notifications to a specified Slack channel if any issues are detected or if `wp-cli` is not installed in the container.

## Prerequisites

- Docker
- Docker containers running the WordPress image

## Usage

1. Make sure the script is executable:

   ```bash
   chmod +x wordpress-docker-verify-checksums.sh
   ```

2. Run the script with the Slack webhook URL as the first argument and optionally provide the WordPress image name as the second argument:

   ```bash
   ./wordpress-docker-verify-checksums.sh [SLACK_WEBHOOK_URL] [WORDPRESS_IMAGE]
   ```

   Replace `[SLACK_WEBHOOK_URL]` with the actual Slack webhook URL for the channel you want to receive notifications in. The `[WORDPRESS_IMAGE]` argument is optional and can be used to specify a custom WordPress image name. If not provided, it defaults to "wordpress".

## Configuration

You can customize the script's behavior by modifying the following variables at the beginning of the script:

- `SLACK_ENABLED`: Set to `true` to enable Slack notifications (default: `true`).
- `INSTALL_WP_CLI`: Set to `yes` to automatically download and install `wp-cli` if it's not installed in the container (default: `true`).

## How It Works

The script performs the following steps:

1. Checks if the `SLACK_WEBHOOK_URL` is set and enables Slack notifications accordingly.
2. Checks if `wp-cli` is installed in the system. If not, and `INSTALL_WP_CLI` is set to `yes`, it downloads and installs `wp-cli`.
3. Updates `wp-cli` to the latest version.
4. Retrieves the names of all Docker containers running the specified WordPress image (or default "wordpress" if not provided).
5. Loops through each container and performs the following checks:
   - Verifies the integrity of the WordPress core files using `wp-cli`.
   - Sends a Slack notification if the checksum verification fails (and `SLACK_ENABLED` is `true`).
6. Completes the loop and finishes the script execution.

## Want to connect?

Feel free to contact me on [Twitter](https://twitter.com/OnlineAnto), [DEV Community](https://dev.to/antoonline/) or [LinkedIn](https://www.linkedin.com/in/anto-online) if you have any questions or suggestions.

Or just visit my [website](https://anto.online) to see what I do.
