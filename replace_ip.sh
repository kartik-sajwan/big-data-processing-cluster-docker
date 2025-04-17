#!/bin/bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <target-file> <ip-address>"
  exit 1
fi

TARGET_FILE="$1"
IP_ARG="$2"


# Get IP address (use provided or detect automatically)
if [ -n "$IP_ARG" ]; then
  LOCAL_IP="$IP_ARG"
else
  LOCAL_IP=$(hostname -I | awk '{print $1}')
  echo "No IP provided. Detected local IP: $LOCAL_IP"
fi

# File to be processed
TARGET_FILE=$1

# Check if file was provided
if [ -z "$TARGET_FILE" ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

# Backup the original file
cp "$TARGET_FILE" "$TARGET_FILE.bak"

# Use sed to find and replace IP address pattern with the local IP
# This will replace patterns like 192.168.x.x or any 4-octet IP
sed -E -i "s/[0-9]{1,3}(\.[0-9]{1,3}){3}/$LOCAL_IP/g" "$TARGET_FILE"

echo "Replaced IPs with $LOCAL_IP in $TARGET_FILE"


