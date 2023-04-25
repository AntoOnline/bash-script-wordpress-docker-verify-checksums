# Verify WordPress Container Checksums using WP-CLI and Send Slack Notifications

This Bash script can be used to verify the checksums of all WordPress containers running on a Docker host using WP-CLI. It also sends Slack notifications if checksum verification fails or if WP-CLI is not found in a container.

## Requirements

- Docker
- Linux

## Usage

1. Set the `SLACK_ENABLED` variable to `true` to enable Slack notifications.
2. Set the `INSTALL_WP_CLI` variable to `true` to install WP-CLI in a container if it is not already installed.
3. Set the `SLACK_WEBHOOK_URL` variable to your Slack webhook URL.
4. Run the script using `bash verify-checksums.sh`.

## Script Logic

1. Get a list of all container names associated with the WordPress image.
2. Loop through each container name and check if WP-CLI is installed in the container.
3. If WP-CLI is not found and `INSTALL_WP_CLI` is set to `true`, install WP-CLI in the container.
4. If WP-CLI is not found, and `SLACK_ENABLED` is set to `true`, send a Slack notification.
5. If WP-CLI is found, verify the checksums of the container using WP-CLI.
6. If checksum verification fails and `SLACK_ENABLED` is set to `true`, send a Slack notification.

Note: The script assumes that the WordPress containers are running on the same Docker host where the script is being executed.

## Disclaimer

This script is provided as-is and is intended for use at your own risk. The author is not responsible for any damage or loss caused by the use of this script.
