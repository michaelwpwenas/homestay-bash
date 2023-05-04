#!/bin/bash

# Define database filename
DB_FILE="yupo-homestay.db"

# Check if SQLite3 is installed
if ! command -v sqlite3 &> /dev/null; then
    echo "SQLite3 not found. Please install SQLite3 and try again."
    exit 1
fi

# Check if database file exists
if [ ! -f "$DB_FILE" ]; then
    echo "Database file '$DB_FILE' not found. Please create the database using the create_database.sh script."
    exit 1
fi

# Define functions

# Add a new person to the database
add_person() {
    read -p "Enter name: " name
    read -p "Enter passport number: " passport_no
    read -p "Enter country of origin: " country_of_origin
    read -p "Enter room number: " room_no
    read -p "Enter duration of stay: " duration

    sqlite3 "$DB_FILE" "INSERT INTO persons (name, passport_no, country_of_origin, room_no, duration) VALUES ('$name', '$passport_no', '$country_of_origin', '$room_no', '$duration');"

    echo "Person added successfully."
}

# List all persons in the database
list_persons() {
    sqlite3 "$DB_FILE" "SELECT * FROM persons;"
}

# Delete a person from the database
delete_person() {
    read -p "Enter passport number of person to delete: " passport_no

    sqlite3 "$DB_FILE" "DELETE FROM persons WHERE passport_no='$passport_no';"

    echo "Person deleted successfully."
}

# Update a person's information in the database
update_person() {
    read -p "Enter passport number of person to update: " passport_no
    read -p "Enter new room number: " room_no
    read -p "Enter new duration of stay: " duration

    sqlite3 "$DB_FILE" "UPDATE persons SET room_no='$room_no', duration='$duration' WHERE passport_no='$passport_no';"

    echo "Person updated successfully."
}

# Main loop
while true; do
    echo "----------------------------------------------"
    echo "Welcome to Yupo Homestay Database Management"
    echo "----------------------------------------------"
    echo "1. Add a new person"
    echo "2. List all persons"
    echo "3. Delete a person"
    echo "4. Update a person's information"
    echo "5. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            add_person
            ;;
        2)
            list_persons
            ;;
        3)
            delete_person
            ;;
        4)
            update_person
            ;;
        5)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number from 1 to 5."
            ;;
    esac
done
