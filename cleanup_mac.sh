#!/bin/zsh

echo "Starting Mac cleanup..."
echo ""

# Show current disk usage
echo "Current disk usage:"
df -h / | tail -1 | awk '{print "   Used: " $3 " / Available: " $4 " (" $5 " capacity)"}'
echo ""

# Clean user caches
echo "🗑️  Cleaning user caches..."
CACHE_SIZE_BEFORE=$(du -sh ~/Library/Caches 2>/dev/null | awk '{print $1}')
echo "   Cache size before: $CACHE_SIZE_BEFORE"

# Clean safe app caches
rm -rf ~/Library/Caches/pip 2>/dev/null
rm -rf ~/Library/Caches/npm 2>/dev/null
rm -rf ~/Library/Caches/yarn 2>/dev/null
rm -rf ~/Library/Caches/Homebrew 2>/dev/null
rm -rf ~/Library/Caches/com.apple.Safari/Webpage\ Previews 2>/dev/null

# Clean development tool caches
rm -rf ~/Library/Caches/com.google.* 2>/dev/null
rm -rf ~/Library/Caches/com.microsoft.* 2>/dev/null

CACHE_SIZE_AFTER=$(du -sh ~/Library/Caches 2>/dev/null | awk '{print $1}')
echo "   Cache size after: $CACHE_SIZE_AFTER"
echo ""

# Clean old logs (30+ days)
echo "Cleaning old log files (30+ days)..."
LOG_COUNT=$(find ~/Library/Logs -type f -mtime +30 2>/dev/null | wc -l | xargs)
if [ "$LOG_COUNT" -gt 0 ]; then
    find ~/Library/Logs -type f -mtime +30 2>/dev/null | xargs rm -f 2>/dev/null
    echo "   Deleted $LOG_COUNT old log files"
else
    echo "   No old logs to clean"
fi
echo ""

# Clean Homebrew
if command -v brew >/dev/null 2>&1; then
    echo "Cleaning Homebrew..."
    brew cleanup -s 2>&1 | grep -E "(Removing|freed|Warning)" | grep -v "Warning: Skipping"
    echo ""
else
    echo "⏭️  Homebrew not installed, skipping..."
    echo ""
fi

# Empty trash
echo "Emptying trash:"
TRASH_SIZE=$(du -sh ~/.Trash 2>/dev/null | awk '{print $1}')
if [ "$TRASH_SIZE" != "0B" ] && [ -n "$TRASH_SIZE" ]; then
    rm -rf ~/.Trash/* 2>/dev/null
    echo "   Emptied trash (was $TRASH_SIZE)"
else
    echo "   Trash already empty"
fi
echo ""

# Final disk usage
echo "Cleanup complete!"
echo ""
echo "Final disk usage:"
df -h / | tail -1 | awk '{print "   Used: " $3 " / Available: " $4 " (" $5 " capacity)"}'
echo ""
echo "Run this script anytime with: sh ~/cleanup_mac.sh"
