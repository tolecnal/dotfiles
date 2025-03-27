#!/bin/bash

set -e
cd "$HOME/dotfiles" || exit 1

# Ensure upstream is set
UPSTREAM=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || true)
if [ -z "$UPSTREAM" ]; then
    echo "No upstream configured. Setting upstream to origin/main."
    git branch --set-upstream-to=origin/main main
fi

git fetch origin

LOCAL_COMMIT=$(git rev-parse @)
REMOTE_COMMIT=$(git rev-parse @{u})

if [ "$LOCAL_COMMIT" != "$REMOTE_COMMIT" ]; then
    echo "Updating dotfiles..."
    git pull --rebase --autostash origin main
else
    echo "Dotfiles are up to date."
fi

