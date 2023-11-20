#!/bin/bash

logged_in_users=$(who | awk '{print $1}')

echo "Username  Real Name  Last Login Time"

for user in $logged_in_users
do
    real_name=$(grep "^$user:" /etc/passwd | cut -d: -f5 | cut -d, -f1)

    last_login_time=$(last -n 1 "$user" | awk '{print $4, $5, $6, $7}')

    echo "$user  $real_name  $last_login_time"
done

