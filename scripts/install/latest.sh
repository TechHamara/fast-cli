#!/bin/bash

# Define the API URL
apiUrl="https://api.github.com/repos/jewelshkjony/fast-cli/releases/latest"

# Fetch the JSON response from the API
response=$(curl -s "$apiUrl")

# Check if the API call was successful
if [ $? -ne 0 ] || [ -z "$response" ]; then
    echo "Failed to fetch data from the GitHub API. Check your internet connection or the API URL."
    exit 1
fi

# Extract the URL for fast.zip using grep and sed
zipUrl=$(echo "$response" | grep -o '"browser_download_url": *"[^"]*update.zip"' | sed 's/"browser_download_url": *"//;s/"$//')

# Check if the URL was found
if [ -z "$zipUrl" ]; then
    echo "update.zip not found in the release assets."
    exit 1
fi

# Output the URL
echo "Download URL: $zipUrl"
