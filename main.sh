#!/bin/bash

# Wallpaper directory
WALLPAPER_DIR="$HOME/Pictures/wallz-main"
read -p "Enter the path of your wallpaler dir: " WALLPAPER_DIR

# Take interval input
read -p "Choose a timeframe in seconds (default 300): " INTERVAL

# Use 300 if user enters nothing
INTERVAL=${INTERVAL:-300}

while true; do
    # Get all images recursively
    mapfile -t wallpapers < <(
        find "$WALLPAPER_DIR" -type f \
            \( -iname "*.jpg" -o -iname "*.jpeg" -o \
               -iname "*.png" -o -iname "*.webp" \)
    )

    # Exit if no wallpapers found
    [ ${#wallpapers[@]} -eq 0 ] && {
        echo "No wallpapers found."
        exit 1
    }

    # Pick random wallpaper
    wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

    echo "Setting wallpaper: $wallpaper"

    gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$wallpaper"

    sleep "$INTERVAL"
done