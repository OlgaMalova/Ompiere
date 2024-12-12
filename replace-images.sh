#!/bin/bash

# Set the source directory (logos) and target directory (project)
TARGET_DIR="$1"
LOGOS_DIR="$2"

# Check if both directories are provided
if [[ -z "$TARGET_DIR" || -z "$LOGOS_DIR" ]]; then
    echo "Usage: $0 <target_directory> <logos_directory>"
    exit 1
fi

# Check if the directories exist
if [[ ! -d "$TARGET_DIR" || ! -d "$LOGOS_DIR" ]]; then
    echo "Error: One or both of the directories do not exist."
    exit 1
fi

# Use find to locate all image files recursively and handle spaces or special characters correctly
find "$TARGET_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.ico" \) | while IFS= read -r target_image; do
    # Get the filename from the target image path
    filename=$(basename "$target_image")
    
    # Check if the logo with the same name exists in the logos directory
    logo_image="$LOGOS_DIR/$filename"
    
    if [[ -f "$logo_image" ]]; then
        # If the logo exists, replace the target image with the logo
        echo "Replacing $target_image with $logo_image"
        cp "$logo_image" "$target_image"
    else
        # If no corresponding logo is found, skip the replacement
        echo "No logo found for $filename in the logos directory. Skipping."
    fi
done

echo "Image replacement process completed."

