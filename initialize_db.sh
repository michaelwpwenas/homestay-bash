#!/bin/bash

# Define database filename
DB_FILE="yupo-homestay.db"

# Check if SQLite3 is installed
if ! command -v sqlite3 &> /dev/null; then
    echo "SQLite3 not found. Please install SQLite3 and try again."
    exit 1
fi

# Create database and table
sqlite3 "$DB_FILE" <<EOF
CREATE TABLE IF NOT EXISTS persons (
    name TEXT,
    passport_no TEXT,
    country_of_origin TEXT,
    room_no TEXT,
    duration TEXT
);
EOF

# Print confirmation message
echo "Database file '$DB_FILE' created successfully."