#!/bin/bash

directory="$HOME/Pictures/wallz-main"

[ -d "$directory" ] || exit 1

find "$directory" -type f | while IFS= read -r file; do
    echo "$file"
    # do something with "$file"
done