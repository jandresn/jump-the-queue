#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <filename> <wordToReplace> <wordToBeReplacedWith>"
    exit 1
fi

filename="$1"
wordToReplace="$2"
wordToBeReplacedWith="$3"

if [ ! -e "$filename" ]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

sed -i "s/\b$wordToReplace\b/$wordToBeReplacedWith/g" "$filename"

echo "Replacement complete."
