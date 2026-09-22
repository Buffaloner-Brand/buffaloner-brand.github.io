#!/bin/bash

# Stop execution immediately if any command fails
set -e

# ==========================================
# CONFIGURATION
# ==========================================
# Modify these defaults if your project uses different tools or folders.
BUILD_CMD=${BUILD_CMD:-"uv run properdocs build --clean"}
SITE_DIR=${SITE_DIR:-"site"}
BRANCH=${DEPLOY_BRANCH:-"gh-pages"}
REMOTE=${DEPLOY_REMOTE:-"origin"}

# Dynamically generate a temporary folder name based on the current repository
PROJECT_NAME=$(basename "$PWD")
WORKTREE_DIR="/tmp/${PROJECT_NAME}-${BRANCH}-deploy"

# Accept a commit message as an argument, or fallback to a dynamic default
COMMIT_MSG=${1:-"docs: deploy $PROJECT_NAME to $BRANCH"}
# ==========================================

echo "1. Building the site..."
$BUILD_CMD

echo "2. Setting up git worktree in $WORKTREE_DIR..."
# Clean up the temp directory if a previous run failed and left it behind
if [ -d "$WORKTREE_DIR" ]; then
    git worktree remove --force "$WORKTREE_DIR" 2>/dev/null || rm -rf "$WORKTREE_DIR"
fi

# Link the target branch to our temporary folder
git worktree add "$WORKTREE_DIR" "$BRANCH"

echo "3. Syncing built files..."
# Sync the built folder into the worktree, protecting the branch's .git metadata
rsync -a --delete "${SITE_DIR}/" "$WORKTREE_DIR/" --exclude=".git"

echo "4. Committing and signing..."
cd "$WORKTREE_DIR"
git add .

# Check if there are actually changes to commit
if git diff-index --quiet HEAD --; then
    echo "No changes to deploy. Cleaning up..."
    cd - > /dev/null
    git worktree remove "$WORKTREE_DIR"
    exit 0
fi

# Force GPG to attach to this specific terminal session
export GPG_TTY=$(tty)

# Commit with the -S flag to explicitly force the GPG signature
git commit -S -m "$COMMIT_MSG"

echo "5. Pushing to GitHub ($REMOTE/$BRANCH)..."
git push "$REMOTE" "$BRANCH"

echo "🧹 6. Cleaning up..."
cd - > /dev/null
git worktree remove "$WORKTREE_DIR"

echo "$PROJECT_NAME deployment complete and verified!"