#!/bin/bash

all_users=$(cut -d: -f1 /etc/passwd | sort)

echo "All Users (First 5 Alphabetically):"
echo "-----------------------------------"

echo "$all_users" | head -n 5

last_logged_in_user=$(who | awk 'END{print $1}')

removed_user_name=$(grep "^$last_logged_in_user:" /etc/passwd | cut -d: -f5 | cut -d, -f1)
last_login_date=$(last -n 1 "$last_logged_in_user" | awk '{print $4, $5, $6, $7}')

all_users=$(echo "$all_users" | grep -v "^$last_logged_in_user$")

echo -e "\nUser Removed: $removed_user_name"
echo "Last Login Date: $last_login_date"
