#!/bin/zsh

# Set the local library path, S3 bucket name, and temporary directory path
LOCAL_LIBRARY_PATH="$HOME/Calibre Library"
S3_BUCKET_NAME="calibre-library-cborja36"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null
then
    echo "Error: AWS CLI not found. Please install it and configure your credentials."
    exit 1
fi

aws s3 sync "$LOCAL_LIBRARY_PATH" "s3://$S3_BUCKET_NAME" --exclude "*.DS_Store"

# Print the result
if [ $? -eq 0 ]; then
    echo "Successfully uploaded new books and synced with S3 bucket: $S3_BUCKET_NAME"
else
    echo "Error: Failed to upload new books or sync with S3 bucket: $S3_BUCKET_NAME"
fi
