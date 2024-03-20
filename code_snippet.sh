#!/bin/bash

# Ensure the deployPackage directory structure is in place
mkdir -p deployPackage/added
mkdir -p deployPackage/removed

# Reset or create the added.txt and removed.txt files to store the file names
> added.txt
> removed.txt

# Read each line from file_diff.txt
while IFS=' ' read -r status filepath; do
  # Extract the file name from the path
  filename=$(basename "$filepath")

  # Process files based on their status
  case $status in
    M|A)
      # For modified or added files, write the filename to added.txt and copy it to the added folder
      echo "$filename" >> added.txt
      cp "$filepath" "deployPackage/added/$filename"
      ;;
    R|D)
      # For renamed or deleted files, write the filename to removed.txt and move it to the removed folder
      echo "$filename" >> removed.txt
      mv "$filepath" "deployPackage/removed/$filename"
      ;;
  esac
done < file_diff.txt
