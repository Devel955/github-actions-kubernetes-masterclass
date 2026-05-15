#!/bin/bash

# MySQL Backup Script
# This script takes a backup of the MySQL database

# Variables
DB_NAME=${DB_NAME:-skillpulse}
DB_USER=${DB_USER:-root}
DB_PASSWORD=${DB_PASSWORD:-rootpassword}
DB_HOST=${DB_HOST:-localhost}
BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.sql"

# Create backup directory if not exists
mkdir -p $BACKUP_DIR

echo "🔄 Starting MySQL backup..."

# Take backup
docker exec skillpulse-db-1 mysqldump \
  -u$DB_USER \
  -p$DB_PASSWORD \
  $DB_NAME > $BACKUP_FILE

# Check if backup was successful
if [ $? -eq 0 ]; then
  echo "✅ Backup successful: $BACKUP_FILE"
else
  echo "❌ Backup failed!"
  exit 1
fi

# Delete backups older than 7 days
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
echo "🧹 Old backups cleaned up"

echo "✅ Done!"