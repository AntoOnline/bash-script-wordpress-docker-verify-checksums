# WordPress Docker Verify Checksums

This script, `wordpress-docker-verify-checksums.sh`, checks the integrity of WordPress core files within Docker containers running the WordPress image. It verifies the checksums of the files using `wp-cli`, and sends notifications to a specified Slack channel if any issues are detected or if `wp-cli` is not installed in the container.

## Prerequisites

- Docker
- Docker containers running the WordPress image

## Usage

```bash
./wordpress-docker-verify-checksums.sh --slack-webhook-url <webhook-url> [--wordpress-image-name <image-name>] [--install-wp-cli <yes|no>]
```

Options:

- `--slack-webhook-url`: The Slack webhook URL for the channel you want to receive notifications in (required).
- `--wordpress-image-name`: The name of the WordPress image to check (default: "wordpress").
- `--install-wp-cli`: Specify whether to install `wp-cli` if not installed in the container. Accepted values are "yes" or "no" (default: "yes").

Example:

```bash
./wordpress-docker-verify-checksums.sh --slack-webhook-url <webhook-url> --wordpress-image-name custom-wordpress --install-wp-cli no
```

## How It Works

The script performs the following steps:

1. Parses the command line arguments to get the Slack webhook URL, WordPress image name, and `INSTALL_WP_CLI` value.
2. Checks if the Slack webhook URL is set and enables Slack notifications accordingly.
3. Checks if `wp-cli` is installed in the system. If not, and `INSTALL_WP_CLI` is set to "yes", it downloads and installs `wp-cli`.
4. Updates `wp-cli` to the latest version.
5. Retrieves the names of all Docker containers running the specified WordPress image (or default "wordpress" if not provided).
6. Loops through each container and performs the following checks:
   - Verifies the integrity of the WordPress core files using `wp-cli`.
   - Sends a Slack notification if the checksum verification fails (and Slack notifications are enabled).
7. Completes the loop and finishes the script execution.

## Want to connect?

Feel free to contact me on [Twitter](https://twitter.com/OnlineAnto), [DEV Community](https://dev.to/antoonline/) or [LinkedIn](https://www.linkedin.com/in/anto-online) if you have any questions or suggestions.

Or just visit my [website](https://anto.online) to see what I do.
