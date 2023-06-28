#!/bin/sh

# Check that a directory path was provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Set the directory to clean up
DIR="$1"

# Change to the target directory
cd "$DIR" || exit 1

# Find all files in the directory, excluding directories
FILES=$(find . -maxdepth 1 -type f)

# Sort the files by modification time in descending order
SORTED=$(echo "$FILES" | xargs stat --format '%Y %n' | sort -rn | cut -d ' ' -f 2-)

# Count the number of files
COUNT=$(echo "$SORTED" | wc -l)

# Set the number of files to keep from env variable
KEEP=${KEEP:-1}

# Set the maximum age of files to delete from env variable
MAX_AGE=${MAX_AGE:-604800} # 7 days in seconds (7 * 24 * 60 * 60)

# Loop over the sorted files and delete the old ones
i=1
for FILE in $SORTED; do
    if [ $i -le $KEEP ]; then
        # Keep the file
        echo "Keeping $FILE"
    elif [ $(date +%s) -le $(stat -c %Y "$FILE") + $MAX_AGE ]; then
        # File is newer than MAX_AGE, so keep it
        echo "Keeping $FILE"
    else
        # Delete the file
        echo "Deleting $FILE"
        rm "$FILE"
    fi
    i=$(( i + 1 ))
done
