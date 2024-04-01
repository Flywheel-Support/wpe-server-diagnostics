#!/bin/bash

OUTPUT_FILE="trafficanalyzer.txt"

# Ask the user to enter the installation name
read -p "Please enter install name: " INSTALL_NAME

# Ensure that the installation name is provided
if [ -z "$INSTALL_NAME" ]; then
    echo "Installation name cannot be empty. Exiting..."
    exit 1
fi


{
echo "Top 10 User Agents:"
zcat -f "/var/log/fpm/${INSTALL_NAME}.access.log" "/var/log/fpm/${INSTALL_NAME}.access.log.1" 2>/dev/null | awk '{print $NF}' | sort | uniq -c | sort -rn | head -10

echo ""
echo "Top 10 IP Addresses:"
zcat -f "/var/log/fpm/${INSTALL_NAME}.access.log" "/var/log/fpm/${INSTALL_NAME}.access.log.1" 2>/dev/null | awk '{print $1}' | sort | uniq -c | sort -rn | head -10

echo ""
echo "Requests hour by hour:"
zcat -f "/var/log/fpm/${INSTALL_NAME}.access.log" "/var/log/fpm/${INSTALL_NAME}.access.log.1" 2>/dev/null | awk '{print substr($4, 14, 2)}' | sort | uniq -c

echo ""
echo "Top 10 User Agents:"
zcat -f "/var/log/fpm/${INSTALL_NAME}.access.log" "/var/log/fpm/${INSTALL_NAME}.access.log.1" 2>/dev/null | awk '{print $12}' | sort | uniq -c | sort -rn | head -n 10

echo ""
echo "Top 10 URLs:"
zcat -f "/var/log/fpm/${INSTALL_NAME}.access.log" "/var/log/fpm/${INSTALL_NAME}.access.log.1" 2>/dev/null | awk '{print $7}' | sort | uniq -c | sort -rn | head -n 10

echo ""
echo "Top 10 404 errors:"
zcat -f "/var/log/fpm/${INSTALL_NAME}.access.log" "/var/log/fpm/${INSTALL_NAME}.access.log.1" 2>/dev/null | awk '$9 == "404" {print $7}' | sort | uniq -c | sort -rn | head -n 10

echo ""
echo "Top 10 POST requests:"
zcat -f "/var/log/fpm/${INSTALL_NAME}.access.log" "/var/log/fpm/${INSTALL_NAME}.access.log.1" 2>/dev/null | awk '$6 == "\"POST" {print $7}' | sort | uniq -c | sort -rn | head -n 10
} > "$OUTPUT_FOLDER/$OUTPUT_FILE"

cat "$OUTPUT_FILE"
