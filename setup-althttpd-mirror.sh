#!/usr/bin/env bash

# Complete setup script for althttpd mirror repository

set -e  # Exit on error

echo "Setting up althttpd mirror repository..."

# Create README.md
cat > README.md << 'EOF'
# Althttpd Mirror

This repository automatically mirrors the althttpd web server source code from the SQLite project.

## About Althttpd

Althttpd is a simple web server that has run the https://sqlite.org/ website since 2004. Althttpd strives for simplicity, security, and low resource usage.

## License

Althttpd is in the public domain. The original source includes the following notice:

```
The author disclaims copyright to this source code. In place of
a legal notice, here is a blessing:

May you do good and not evil.
May you find forgiveness for yourself and forgive others.
May you share freely, never taking more than you give.
```

## Source

The original source is maintained at: https://sqlite.org/althttpd/

## Automatic Synchronization

This repository is automatically synchronized daily using GitHub Actions.

## Files

- `althttpd.c` - Main source file
- `althttpd.md` - Documentation
- `Makefile` - Build file
- Additional documentation files

## Building

Please refer to the original documentation at https://sqlite.org/althttpd/doc/trunk/althttpd.md for build instructions.
EOF

# Create necessary directories
mkdir -p .github/workflows

# Create GitHub Actions workflow
cat > .github/workflows/sync-althttpd.yml << 'EOF'
name: Sync Althttpd Source

on:
  schedule:
    # Run daily at 00:00 UTC
    - cron: '0 0 * * *'
  workflow_dispatch: # Allow manual trigger

jobs:
  sync:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v4
      with:
        token: ${{ secrets.GITHUB_TOKEN }}

    - name: Download and sync althttpd files
      run: |
        # Create directories
        mkdir -p docs

        # Function to download file from SQLite repository
        download_file() {
          local path=$1
          local filename=$2
          local output=$3

          echo "Downloading $filename..."
          curl -L -o "$output" "https://sqlite.org/althttpd/raw/${path}?at=trunk" || {
            echo "Failed to download $filename"
            return 1
          }
        }

        # Download main files
        download_file "althttpd.c" "althttpd.c" "althttpd.c"
        download_file "Makefile" "Makefile" "Makefile"
        download_file "VERSION.h" "VERSION.h" "VERSION.h"

        # Download documentation files
        download_file "althttpd.md" "althttpd.md" "docs/althttpd.md"
        download_file "standalone-mode.md" "standalone-mode.md" "docs/standalone-mode.md"
        download_file "static-build.md" "static-build.md" "docs/static-build.md"
        download_file "linode-systemd.md" "linode-systemd.md" "docs/linode-systemd.md"
        download_file "xinetd.md" "xinetd.md" "docs/xinetd.md"
        download_file "openrc.md" "openrc.md" "docs/openrc.md"
        download_file "stunnel4.md" "stunnel4.md" "docs/stunnel4.md"

        # Create NOTICE file for attribution
        cat > NOTICE << 'NOTICE_EOF'
        This is a mirror of the althttpd web server from the SQLite project.

        Original source: https://sqlite.org/althttpd/

        The althttpd source code is in the public domain, with the following notice:

        The author disclaims copyright to this source code. In place of
        a legal notice, here is a blessing:

        May you do good and not evil.
        May you find forgiveness for yourself and forgive others.
        May you share freely, never taking more than you give.
        NOTICE_EOF

    - name: Check for changes
      id: changes
      run: |
        git config user.name "GitHub Actions"
        git config user.email "actions@github.com"

        # Add all files
        git add -A

        # Check if there are changes
        if git diff --staged --quiet; then
          echo "No changes detected"
          echo "has_changes=false" >> $GITHUB_OUTPUT
        else
          echo "Changes detected"
          echo "has_changes=true" >> $GITHUB_OUTPUT

          # Get current timestamp
          TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")
          echo "timestamp=$TIMESTAMP" >> $GITHUB_OUTPUT
        fi

    - name: Commit and push changes
      if: steps.changes.outputs.has_changes == 'true'
      run: |
        TIMESTAMP="${{ steps.changes.outputs.timestamp }}"

        # Create commit message
        git commit -m "Sync althttpd source from upstream - $TIMESTAMP" \
                   -m "Automated sync from https://sqlite.org/althttpd/"

        # Push changes
        git push origin main

    - name: Create sync status file
      run: |
        TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")
        cat > LAST_SYNC.txt << EOF_SYNC
        Last sync attempt: $TIMESTAMP
        Status: ${{ steps.changes.outputs.has_changes == 'true' && 'Updated' || 'No changes' }}
        Source: https://sqlite.org/althttpd/
        EOF_SYNC

        git add LAST_SYNC.txt
        git diff --staged --quiet || {
          git commit -m "Update sync status"
          git push origin main
        }
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
# Compiled binaries
althttpd
althttpsd
*.o
*.a

# Editor files
*.swp
*.swo
*~
.vscode/
.idea/

# OS files
.DS_Store
Thumbs.db
EOF

# Create initial NOTICE file
cat > NOTICE << 'EOF'
This is a mirror of the althttpd web server from the SQLite project.

Original source: https://sqlite.org/althttpd/

The althttpd source code is in the public domain, with the following notice:

The author disclaims copyright to this source code. In place of
a legal notice, here is a blessing:

May you do good and not evil.
May you find forgiveness for yourself and forgive others.
May you share freely, never taking more than you give.
EOF

# Add all files and commit
git add -A
git commit -m "Initial setup with GitHub Actions workflow" \
           -m "- Added README.md with project description" \
           -m "- Added GitHub Actions workflow for automatic synchronization" \
           -m "- Daily sync at 00:00 UTC" \
           -m "- Manual trigger available" \
           -m "- Downloads source files from SQLite repository" \
           -m "- Maintains proper attribution"

# Push to GitHub
git push origin main

echo "Setup complete! The repository will now automatically sync daily."
echo ""
echo "To trigger an immediate sync:"
echo "  1. Go to your repository on GitHub"
echo "  2. Click on 'Actions' tab"
echo "  3. Select 'Sync Althttpd Source' workflow"
echo "  4. Click 'Run workflow'"
echo ""
echo "Or use GitHub CLI:"
echo "  gh workflow run 'Sync Althttpd Source'"
