#!/bin/zsh

# Set the local library path, S3 bucket name, and temporary directory path
LOCAL_LIBRARY_PATH="$HOME/Calibre Library"
S3_BUCKET_NAME="borja-books"
TEMP_DIR="/tmp/borja_books_temp"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null
then
    echo "Error: AWS CLI not found. Please install it and configure your credentials."
    exit 1
fi

# Remove the temporary directory if it exists
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi

# Create the temporary directory
mkdir -p "$TEMP_DIR"

# Copy PDF and EPUB files to the temporary directory with the desired structure
find "$LOCAL_LIBRARY_PATH" -type f \( -iname \*.pdf -o -iname \*.epub \) | while read -r file; do
    author=$(basename "$(dirname "$(dirname "$file")")")
    title=$(basename "$(dirname "$file")")
    ext="${file##*.}"
    target_dir="$TEMP_DIR/$author"
    mkdir -p "$target_dir"
    
    # Remove the number at the end of the title
    clean_title=$(echo "$title" | gsed -E 's/\s\(([0-9]+)\)$//')
    cp "$file" "$target_dir - ${clean_title}.${ext}"
done

# Upload new books to the S3 bucket and sync with the temporary directory
aws s3 sync "$TEMP_DIR" "s3://$S3_BUCKET_NAME" --exclude ".*" --exclude "*.tmp"

# Print the result
if [ $? -eq 0 ]; then
    echo "Successfully uploaded new books and synced with S3 bucket: $S3_BUCKET_NAME"
else
    echo "Error: Failed to upload new books or sync with S3 bucket: $S3_BUCKET_NAME"
fi

# Remove the temporary directory
rm -rf "$TEMP_DIR"
