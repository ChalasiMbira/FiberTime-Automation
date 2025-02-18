#!/bin/bash
# Fiber Time: SSH Unauthorized Login Monitoring Script

# Path to the authentication log file
LOG_FILE="/var/log/auth.log"

# File to store unauthorized SSH attempts
OUTPUT_FILE="unauthorized_ssh.log"

# Admin email for security alerts
ALERT_EMAIL="security@fibertime.com"

# Extract failed SSH login attempts and log them
echo "Unauthorized SSH login attempts:" > $OUTPUT_FILE
grep "Failed password" $LOG_FILE | awk '{print $1, $2, $3, $11, $13}' >> $OUTPUT_FILE

# If unauthorized attempts are detected, send an alert email
if [ -s $OUTPUT_FILE ]; then
    cat $OUTPUT_FILE | mail -s "⚠️ Fiber Time Unauthorized SSH Alert" $ALERT_EMAIL
fi
