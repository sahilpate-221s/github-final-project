#!/bin/bash

########################
# [TASK 1]
# Set target and destination directories
########################
targetDirectory="/home/user/source"
destinationDirectory="/home/user/backup"

########################
# [TASK 2]
# Display directory values
########################
echo "Target directory: $targetDirectory"
echo "Destination directory: $destinationDirectory"

########################
# [TASK 3]
# Set current timestamp (in seconds)
########################
currentTS=$(date +%s)

########################
# [TASK 4]
# Set backup file name
########################
backupFileName="backup-$currentTS.tar.gz"

########################
# [TASK 5]
# Define absolute path of target directory
########################
origAbsPath=$(realpath "$targetDirectory")

########################
# [TASK 6]
# Define absolute path of destination directory
########################
destAbsPath=$(realpath "$destinationDirectory")

########################
# [TASK 7]
# Change to target directory
########################
cd "$targetDirectory" || exit 1

########################
# [TASK 8]
# Timestamp of 24 hours ago
########################
yesterdayTS=$((currentTS - 86400))

########################
# [TASK 9]
# List all files and directories
########################
files=$(ls)

########################
# [TASK 10 & 11]
# Check modified files and add to array
########################
toBackup=()

for file in $files
do
  if [ $(date -r "$file" +%s) -gt $yesterdayTS ]
  then
    toBackup+=("$file")
  fi
done

########################
# [TASK 12]
# Create compressed backup file
########################
tar -czf "$backupFileName" "${toBackup[@]}"

########################
# [TASK 13]
# Move backup to destination directory
########################
mv "$backupFileName" "$destAbsPath"
