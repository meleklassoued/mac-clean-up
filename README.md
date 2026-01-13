# Mac Clean Up Script 🧹

A simple, safe script to free up disk space on macOS by cleaning caches, old logs, and Homebrew leftovers.

## What it cleans

- **User caches**: npm, yarn, pip, Homebrew, Safari previews
- **App caches**: Google and Microsoft app caches
- **Old logs**: Files older than 30 days in `~/Library/Logs`
- **Homebrew**: Old downloads and formula versions
- **Trash**: Empties the trash

## Usage

```bash
sh cleanup_mac.sh
```

Or make it executable and run directly:

```bash
chmod +x cleanup_mac.sh
./cleanup_mac.sh
```

## Safety

This script only removes:
- Cached files that apps will regenerate automatically
- Log files older than 30 days
- Old Homebrew downloads (not your installed packages)
- Items in trash

Your applications, settings, and data remain untouched.

## Typical Results

- Frees up 5-20GB of disk space
- Safe to run regularly (weekly/monthly)
- Shows before/after disk usage

## Requirements

- macOS
- Optional: Homebrew (for brew cleanup feature)

---

Co-Authored-By: Warp <agent@warp.dev>
