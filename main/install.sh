#!/bin/bash

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}Starting Gatus setup...${NC}"

# Update system packages
echo -e "${GREEN}Updating system packages...${NC}"
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Docker if not installed
if ! command -v docker &>/dev/null; then
    echo -e "${GREEN}Installing Docker...${NC}"
    curl -fsSL https://get.docker.com | sh
fi

# Check if required environment variables are set
if [[ -z "$GATUS_USERNAME" || -z "$GATUS_PASSWORD" || -z "$MONITORING_URL" || -z "$MONITORING_INTERVAL" || -z "$PORT" ]]; then
    echo -e "${RED}Required environment variables are missing. Please ensure GATUS_USERNAME, GATUS_PASSWORD, MONITORING_URL, MONITORING_INTERVAL, and PORT are set.${NC}"
    exit 1
fi

# Create bcrypt hash of the password
echo -e "${GREEN}Hashing the password...${NC}"
HASHED_PASSWORD=$(echo -n "$GATUS_PASSWORD" | openssl passwd -6 -stdin)

# Fetch public IP
PUBLIC_IP=$(curl -s ifconfig.me)

# Generate config.yaml
echo -e "${GREEN}Generating config.yaml...${NC}"

cat <<EOF >config.yaml
web:
  port: $PORT
  address: 0.0.0.0

security:
  basic:
    username: "$GATUS_USERNAME"
    password-bcrypt-base64: "$HASHED_PASSWORD"

endpoints:
  - name: website
    url: "$MONITORING_URL"
    interval: "$MONITORING_INTERVAL"
    conditions:
      - "[STATUS] == 200"
EOF

# Run Gatus in Docker
echo -e "${GREEN}Starting Gatus in Docker...${NC}"
docker run -d --name gatus \
    -v $(pwd)/config.yaml:/config/config.yaml \
    -p $PORT:$PORT \
    twinproduction/gatus

# Output success message
echo -e "${GREEN}Gatus setup complete!${NC}"
echo -e "You can access the dashboard at: http://$PUBLIC_IP:$PORT"
echo -e "Username: ${GATUS_USERNAME}"
echo -e "Password: ${GATUS_PASSWORD}"
