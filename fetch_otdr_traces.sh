#!/bin/bash
# Fiber Time: OTDR Trace Data Fetching and Analysis Script

# Fiber Time's OTDR API endpoint (Replace with actual API URL)
API_URL="https://api.fibertime.com/otdr_traces"

# API Key for authentication (Replace with actual key)
API_KEY="YOUR_FIBERTIME_API_KEY"

# File to store raw OTDR data
OUTPUT_FILE="otdr_traces.json"

# Log file for processed OTDR results
LOG_FILE="fiber_losses.log"

# Fetch OTDR trace data from the API
curl -s -H "Authorization: Bearer $API_KEY" $API_URL -o $OUTPUT_FILE

# Check if data retrieval was successful
if [ $? -ne 0 ]; then
    echo "⚠️ ERROR: Failed to fetch OTDR data."
    exit 1
fi

echo "✅ OTDR trace data fetched successfully."

# Extract fiber loss and splice point details
echo "📊 Fiber Loss Report - $(date)" > $LOG_FILE
cat $OUTPUT_FILE | jq -r '.traces[] | "Fiber: \(.fiber_id) | Loss: \(.fiber_loss) dB | Splice at: \(.splice_points[])"' >> $LOG_FILE

echo "📄 Report saved to $LOG_FILE."
