#!bin/bash

#Define the Dir and time interval
WALLPAPER_DIR="$HOME/Pictures/wallz-main"
INTERVAL=300

while true; do
    # Get all images
    mapfile -t wallpapers < < (
        find "$WALLPAPER_DIR" -type f \
            \( -iname "*.jpg" -o iname "*.jpge" -o -iname "*.png" -o -iname "*.webp" \)
    )

    # Exit if no wallpaper found
    [ ${#wallpapers[@]} -eq 0] && exit 1

    # Select a random wallpaper
    wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

    echo "Setting: $wallpaper"

    gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$wallpaper"

    sleep "$INTERVAL"
done