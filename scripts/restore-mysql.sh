#!/bin/bash

# MySQL Restore Script
# This script restores a MySQL database from backup

# Variables
DB_NAME=${DB_NAME:-skillpulse}
DB_USER=${DB_USER:-skillpulse}
DB_PASSWORD=${DB_PASSWORD:-skillpulse123}
BACKUP_DIR="./backups"

# Check if backup file is provided
if [ -z "$1" ]; then
  echo "❌ Error: Please provide backup file path"
  echo "Usage: ./restore-mysql.sh ./backups/skillpulse_20240101_120000.sql"
  exit 1
fi

BACKUP_FILE=$1

# Check if file exists
if [ ! -f "$BACKUP_FILE" ]; then
  echo "❌ Error: Backup file not found: $BACKUP_FILE"
  exit 1
fi

echo "🔄 Starting MySQL restore from: $BACKUP_FILE"

# Restore backup
docker compose exec -T db mysql \
  -u$DB_USER \
  -p$DB_PASSWORD \
  $DB_NAME < $BACKUP_FILE

# Check if restore was successful
if [ $? -eq 0 ]; then
  echo "✅ Restore successful!"
else
  echo "❌ Restore failed!"
  exit 1
fi
