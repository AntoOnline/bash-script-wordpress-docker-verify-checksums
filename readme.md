Sure, here's an updated version of the `README.md` file:

# WP-CLI Verify Checksums Script

This script lists all running containers associated with the `wordpress` Docker image and runs the `wp core verify-checksums` command on each container.

## Requirements

- Docker must be installed on the host machine.
- The `wordpress` Docker image must be running in one or more containers.

## Usage

1. Download the script to your local machine.
2. Make the script executable: `chmod +x wp-cli-verify-checksums.sh`.
3. Run the script: `./wp-cli-verify-checksums.sh`.

## Installation of WP-CLI in Docker container

If the `wp` command is not found in a container, you can install it by running the following command on the container:

```
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && sudo mv wp-cli.phar /usr/local/bin/wp
```

## Configuration

- The script is currently set to use the `wordpress` Docker image. You can modify this by changing the `docker ps` command in the script to use a different image.
- If the `wp` command is not found in a container, the script will send a notification to a Slack webhook URL. To disable this feature, set the `SLACK_WEBHOOK_URL` environment variable to an empty string: `export SLACK_WEBHOOK_URL=""`.
