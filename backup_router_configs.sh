#!/bin/bash
# Fiber Time: Router Configuration Backup Script

# List of routers to back up (Replace with real hostnames)
ROUTERS=("router1.fibertime.com" "router2.fibertime.com")

# SSH admin user
USERNAME="admin"

# Directory to store backups
BACKUP_DIR="router_configs"

# Ensure backup directory exists
mkdir -p $BACKUP_DIR

# Loop through each router and copy its config file
for ROUTER in "${ROUTERS[@]}"; do
  scp $USERNAME@$ROUTER:/etc/router_config.conf $BACKUP_DIR/$ROUTER.conf
done

echo "✅ Router configurations backed up successfully."
