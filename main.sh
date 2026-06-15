#!bin/bash

#Define the Dir and time interval
WALLPAPER_DIR="$HOME/Pictures/wallz-main"
INTERVAL=300

while true; do
    # Get all images
    mapfile -t wallpapers < < (
        find "$WALLPAPER_DIR" -type f \
            \( -iname "*.jpg" -o iname )
    )