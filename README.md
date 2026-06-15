# Auto Wallpaper Changer for Linux

Automatically rotate your desktop wallpapers at a custom time interval using a simple Bash script.

> [!IMPORTANT]
> This project is designed for **GNOME-based desktop environments** (Ubuntu GNOME, Fedora GNOME, Pop!_OS, etc.).
>
> If you are using another desktop environment or window manager such as **KDE Plasma**, **Hyprland**, **XFCE**, **i3**, or **Sway**, the wallpaper-changing command may be different and require modifications.

---

## Features

* Recursively scans wallpaper directories and subdirectories
* Supports common image formats:

  * JPG / JPEG
  * PNG
  * WebP
* Random wallpaper selection
* Customizable wallpaper change interval
* Lightweight and dependency-free
* Can run in the background
* Can automatically start on system boot

---

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/SubhadipD9/linux-auto-wallpaper-change.git
cd linux-auto-wallpaper-change
```

### Run the Script

```bash
bash ./auto-wallpaper.sh
```

The script will ask for:

1. Wallpaper directory
2. Wallpaper change interval (in seconds)

Example:

```text
Enter wallpaper directory:
/home/user/Pictures/wallpapers

Choose a timeframe in seconds (default 300):
3600
```

In the above example, the wallpaper changes every **1 hour**.

### Common Time Intervals

| Duration   | Seconds |
| ---------- | ------- |
| 5 Minutes  | 300     |
| 10 Minutes | 600     |
| 30 Minutes | 1800    |
| 1 Hour     | 3600    |
| 6 Hours    | 21600   |
| 12 Hours   | 43200   |
| 24 Hours   | 86400   |

> [!IMPORTANT] You can modify the script based on your preferences, such as hardcoding the directory path or interval.
---

## Directory Structure Example

The script scans all subdirectories recursively.

Example:

```text
wallpapers/
├── Nature/
│   ├── lake.jpg
│   ├── forest.png
│
├── Anime/
│   ├── wallpaper1.webp
│   └── wallpaper2.jpg
│
└── Space/
    └── galaxy.png
```

All wallpapers from every folder will be detected automatically.

---

## Running in the Background

By default, the script runs in the foreground and occupies the terminal session.

To run it in the background:

```bash
chmod +x auto-wallpaper.sh
./auto-wallpaper.sh &
```

You can close the terminal while keeping the process running using:

```bash
nohup ./auto-wallpaper.sh > wallpaper.log 2>&1 &
```

---

## Stopping the Script

Find the process:

```bash
ps aux | grep auto-wallpaper.sh
```

Kill the process:

```bash
kill <PID>
```

Or:

```bash
pkill -f auto-wallpaper.sh
```

---

# Start Automatically on Boot (Recommended)

Since the script already contains its own timer (`sleep` interval), there is **no need to schedule it repeatedly with cron**.

Instead, start it automatically when the system boots.

## Method 1: Startup Applications (Ubuntu GNOME)

Open Startup Applications:

```bash
gnome-session-properties
```

Click **Add** and enter:

**Name**

```text
Wallpaper Changer
```

**Command**

```text
/path/to/auto-wallpaper.sh
```

**Comment**

```text
Automatically rotate wallpapers
```

Save and reboot.

---

## Method 2: Cron @reboot

Open crontab:

```bash
crontab -e
```

Add:

```bash
@reboot DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /home/subhadip/customConfigs/auto-wallpaper-change/auto-wallpaper.sh
```

Save and exit.

Make the script executable:

```bash
chmod +x /path/to/auto-wallpaper.sh
```

> [!NOTE]
> Since the script contains its own interval logic, `@reboot` is sufficient. There is no need to create hourly or daily cron schedules.

---

## Method 3: systemd User Service (Recommended for Advanced Users)

Create a service file:

```bash
mkdir -p ~/.config/systemd/user
nano ~/.config/systemd/user/wallpaper-changer.service
```

Paste:

```ini
[Unit]
Description=Wallpaper Changer

[Service]
ExecStart=/path/to/auto-wallpaper.sh
Restart=always

[Install]
WantedBy=default.target
```

Enable the service:

```bash
systemctl --user daemon-reload
systemctl --user enable wallpaper-changer.service
systemctl --user start wallpaper-changer.service
```

Check status:

```bash
systemctl --user status wallpaper-changer.service
```

This method is generally the most reliable way to run long-lived background scripts.

---

## Supported Image Formats

```text
.jpg
.jpeg
.png
.webp
```

Additional formats can be added by modifying the `find` command in the script.

---

## Troubleshooting

### Wallpaper Doesn't Change

Verify that:

* You are using GNOME.
* The wallpaper directory exists.
* The directory contains supported image formats.
* `gsettings` is available on your system.

Check manually:

```bash
gsettings get org.gnome.desktop.background picture-uri
```

### Script Stops After Login

Ensure the script has execute permissions:

```bash
chmod +x auto-wallpaper.sh
```

---

## License

This project is licensed under the [MIT License](LICENSE).
