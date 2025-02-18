#!/bin/bash
# Fiber Time: Automated Latency Monitoring Script

# Define fiber network nodes (Replace with actual network endpoints)
NODES=("fiber1.fibertime.com" "fiber2.fibertime.com" "core-router.fibertime.com")

# Log file to store latency test results
LOG_FILE="fiber_latency.log"

# Define threshold for alerting (in milliseconds)
ALERT_THRESHOLD=50

# Write header to log file
echo "Fiber Link Latency Check - $(date)" >> $LOG_FILE
echo "--------------------------------------" >> $LOG_FILE

# Loop through each fiber node and test latency
for NODE in "${NODES[@]}"; do
  # Ping the node 5 times and extract the average latency
  LATENCY=$(ping -c 5 $NODE | tail -1 | awk '{print $4}' | cut -d '/' -f 2)
  
  # Log the latency result
  echo "$NODE - Avg Latency: ${LATENCY}ms" >> $LOG_FILE
  
  # Check if latency exceeds threshold
  if (( $(echo "$LATENCY > $ALERT_THRESHOLD" | bc -l) )); then
    # Send an alert email if latency is too high
    echo "⚠️ ALERT: High latency detected on $NODE ($LATENCY ms)" | mail -s "Fiber Time Latency Alert" admin@fibertime.com
  fi
done

echo "--------------------------------------" >> $LOG_FILE
echo "✅ Latency test completed and logged."
