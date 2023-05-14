# WordPress Docker Verify Checksums

This script, `wordpress-docker-verify-checksums.sh`, checks the integrity of WordPress core files within Docker containers running the WordPress image. It verifies the checksums of the files using `wp-cli`, and sends notifications to a specified Slack channel if any issues are detected or if `wp-cli` is not installed in the container.

## Prerequisites

- Docker
- Docker containers running the WordPress image

## Usage

1. Make sure the script is executable:

   ```
   chmod +x wordpress-docker-verify-checksums.sh
   ```

2. Run the script with the Slack webhook URL as an argument:

   ```
   ./wordpress-docker-verify-checksums.sh [SLACK_WEBHOOK_URL]
   ```

   Replace `[SLACK_WEBHOOK_URL]` with the actual Slack webhook URL for the channel you want to receive notifications in.

## Configuration

You can customize the script's behavior by modifying the following variables at the beginning of the script:

- `SLACK_ENABLED`: Set to `true` to enable Slack notifications (default: `true`).
- `INSTALL_WP_CLI`: Set to `true` to automatically install `wp-cli` if it's not installed in the container (default: `true`).

## How It Works

The script does the following:

1. Retrieves the names of all Docker containers running the WordPress image.
2. Loops through each container and checks if `wp-cli` is installed.
3. If `wp-cli` is not installed and `INSTALL_WP_CLI` is set to `true`, it installs `wp-cli`.
4. Sends a Slack notification if `wp-cli` is not installed (and `SLACK_ENABLED` is `true`).
5. Runs the `wp core verify-checksums` command using `wp-cli` to verify the integrity of the WordPress core files.
6. Sends a Slack notification if the checksum verification fails (and `SLACK_ENABLED` is `true`).

## Want to connect?

Feel free to contact me on [Twitter](https://twitter.com/OnlineAnto), [DEV Community](https://dev.to/antoonline/) or [LinkedIn](https://www.linkedin.com/in/anto-online) if you have any questions or suggestions.

Or just visit my [website](https://anto.online) to see what I do.
