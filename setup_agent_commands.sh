#!/bin/bash

# Setup script to copy Claude/Agent commands to target repository
# Usage: ./setup_agent_commands.sh [target_directory]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Target directory (default to current directory)
TARGET_DIR="${1:-.}"

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}Error: Target directory does not exist: $TARGET_DIR${NC}"
    exit 1
fi

# Convert to absolute path
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

# Metadata file to track installation
METADATA_FILE="$TARGET_DIR/.agent_commands_metadata"

echo -e "${BLUE}=== Claude/Agent Commands Setup ===${NC}"
echo "Source: $SCRIPT_DIR"
echo "Target: $TARGET_DIR"
echo

# Check if target is a git repository (handle both regular repos and worktrees)
if [ ! -d "$TARGET_DIR/.git" ] && [ ! -f "$TARGET_DIR/.git" ]; then
    echo -e "${YELLOW}Warning: Target directory is not a git repository${NC}"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Get current commit ID from source repository
cd "$SCRIPT_DIR"
CURRENT_COMMIT=$(git rev-parse HEAD 2>/dev/null || echo "unknown")
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")

echo -e "${BLUE}Source repository info:${NC}"
echo "  Branch: $CURRENT_BRANCH"
echo "  Commit: $CURRENT_COMMIT"
echo

# Check for previous installation
if [ -f "$METADATA_FILE" ]; then
    echo -e "${YELLOW}Found previous installation metadata:${NC}"
    cat "$METADATA_FILE" | sed 's/^/  /'
    PREV_COMMIT=$(grep "commit:" "$METADATA_FILE" | cut -d' ' -f2)

    if [ "$PREV_COMMIT" != "unknown" ] && [ "$PREV_COMMIT" != "$CURRENT_COMMIT" ]; then
        echo
        echo -e "${YELLOW}Changes since last installation:${NC}"
        cd "$SCRIPT_DIR"
        git diff --stat "$PREV_COMMIT" HEAD -- .claude/commands .agents/commands 2>/dev/null || echo "  Unable to show changes"
    fi
    echo
fi

# Function to check if file has local modifications
check_modifications() {
    local target_file="$1"
    local source_file="$2"

    if [ -f "$target_file" ]; then
        if ! cmp -s "$source_file" "$target_file"; then
            return 0  # Files are different
        fi
    fi
    return 1  # Files are same or target doesn't exist
}

# Collect all files to be copied
declare -a FILES_TO_COPY
declare -a FILES_MODIFIED
declare -a FILES_NEW
declare -a FILES_UNCHANGED

echo -e "${BLUE}Analyzing files to copy...${NC}"
echo

# Check .claude/commands
if [ -d "$SCRIPT_DIR/.claude/commands" ]; then
    while IFS= read -r -d '' file; do
        rel_path="${file#$SCRIPT_DIR/}"
        target_file="$TARGET_DIR/$rel_path"

        if [ -f "$target_file" ]; then
            if check_modifications "$target_file" "$file"; then
                FILES_MODIFIED+=("$rel_path")
            else
                FILES_UNCHANGED+=("$rel_path")
            fi
        else
            FILES_NEW+=("$rel_path")
        fi
        FILES_TO_COPY+=("$rel_path")
    done < <(find "$SCRIPT_DIR/.claude/commands" -type f \( -name "*.md" -o -name "*.sh" \) -print0)
fi

# Check .agents/commands
if [ -d "$SCRIPT_DIR/.agents/commands" ]; then
    while IFS= read -r -d '' file; do
        rel_path="${file#$SCRIPT_DIR/}"
        target_file="$TARGET_DIR/$rel_path"

        if [ -f "$target_file" ]; then
            if check_modifications "$target_file" "$file"; then
                FILES_MODIFIED+=("$rel_path")
            else
                FILES_UNCHANGED+=("$rel_path")
            fi
        else
            FILES_NEW+=("$rel_path")
        fi
        FILES_TO_COPY+=("$rel_path")
    done < <(find "$SCRIPT_DIR/.agents/commands" -type f \( -name "*.md" -o -name "*.sh" -o ! -name ".*" \) -print0)
fi

# Display summary
echo -e "${GREEN}New files to be added:${NC}"
if [ ${#FILES_NEW[@]} -eq 0 ]; then
    echo "  (none)"
else
    for file in "${FILES_NEW[@]}"; do
        echo "  + $file"
    done
fi
echo

echo -e "${YELLOW}Files to be overwritten (with local changes):${NC}"
if [ ${#FILES_MODIFIED[@]} -eq 0 ]; then
    echo "  (none)"
else
    for file in "${FILES_MODIFIED[@]}"; do
        echo "  ! $file"
    done
fi
echo

echo -e "${BLUE}Files to be updated (no local changes):${NC}"
if [ ${#FILES_UNCHANGED[@]} -eq 0 ]; then
    echo "  (none)"
else
    for file in "${FILES_UNCHANGED[@]}"; do
        echo "  = $file"
    done
fi
echo

# Check for obsolete files
echo -e "${RED}Obsolete files (consider removing):${NC}"
OBSOLETE_FILES=(
    ".claude/commands/issue-from-bug.md"
    ".claude/commands/work-on-issue.md"
    ".agents/commands/work-on-linear-issue"
)

FOUND_OBSOLETE=false
for file in "${OBSOLETE_FILES[@]}"; do
    if [ -f "$TARGET_DIR/$file" ]; then
        echo "  - $file"
        FOUND_OBSOLETE=true
    fi
done

if [ "$FOUND_OBSOLETE" = false ]; then
    echo "  (none)"
fi
echo

# Confirm before proceeding
read -p "Proceed with installation? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

# Perform the copy
echo
echo -e "${BLUE}Copying files...${NC}"

for rel_path in "${FILES_TO_COPY[@]}"; do
    source_file="$SCRIPT_DIR/$rel_path"
    target_file="$TARGET_DIR/$rel_path"
    target_dir="$(dirname "$target_file")"

    # Create target directory if needed
    mkdir -p "$target_dir"

    # Copy file
    cp "$source_file" "$target_file"

    # Preserve executable bit if present
    if [ -x "$source_file" ]; then
        chmod +x "$target_file"
    fi

    echo "  Copied: $rel_path"
done

# Write metadata file
echo
echo -e "${BLUE}Writing metadata...${NC}"
cat > "$METADATA_FILE" << EOF
# Agent Commands Installation Metadata
# Generated by setup_agent_commands.sh
date: $(date -u +"%Y-%m-%d %H:%M:%S UTC")
source: $SCRIPT_DIR
commit: $CURRENT_COMMIT
branch: $CURRENT_BRANCH
files_copied: ${#FILES_TO_COPY[@]}
EOF

echo "  Metadata written to: $METADATA_FILE"

# Summary
echo
echo -e "${GREEN}=== Installation Complete ===${NC}"
echo "Copied ${#FILES_TO_COPY[@]} files to $TARGET_DIR"

if [ "$FOUND_OBSOLETE" = true ]; then
    echo
    echo -e "${YELLOW}Note: Found obsolete files that should be removed manually.${NC}"
fi

echo
echo "To use these commands:"
echo "  - Claude commands: Use /command-name in Claude"
echo "  - Agent commands: Run from .agents/commands/ directory"