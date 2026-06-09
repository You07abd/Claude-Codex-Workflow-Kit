#!/usr/bin/env bash
# Claude+Codex workflow installer
# Run from inside the target project:
#   bash path/to/install.sh

SOURCE="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:-$(pwd)}"

echo "Installing Claude+Codex workflow into: $TARGET"

# Copy tasks/ directory
if [ ! -d "$TARGET/tasks" ]; then
    cp -r "$SOURCE/tasks" "$TARGET/tasks"
    echo "  Created tasks/"
else
    cp "$SOURCE/tasks/_template.md" "$TARGET/tasks/_template.md"
    echo "  Updated tasks/_template.md"
fi

# Merge or create CLAUDE.md
if [ -f "$TARGET/CLAUDE.md" ]; then
    if ! grep -q "Claude + Codex Workflow" "$TARGET/CLAUDE.md"; then
        printf "\n\n---\n\n" >> "$TARGET/CLAUDE.md"
        cat "$SOURCE/CLAUDE.md" >> "$TARGET/CLAUDE.md"
        echo "  Merged workflow into existing CLAUDE.md"
    else
        echo "  CLAUDE.md already contains workflow — skipped"
    fi
else
    cp "$SOURCE/CLAUDE.md" "$TARGET/CLAUDE.md"
    echo "  Created CLAUDE.md"
fi

echo ""
echo "Done. Open the project in Claude Code — the workflow is active."
echo "Next: copy tasks/_template.md -> tasks/your-task.md and fill it in."
