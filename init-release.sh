#!/bin/bash

# Exit on error
set -e

# Check if pom.xml exists
if [ ! -f "pom.xml" ]; then
    echo "Error: pom.xml not found in current directory"
    exit 1
fi

# Remove -SNAPSHOT from parent pom reference only
echo "Removing -SNAPSHOT from parent pom reference..."
sed -i.bak '/<parent>/,/<\/parent>/s/<version>\([^<]*\)-SNAPSHOT<\/version>/<version>\1<\/version>/' pom.xml

# Check if changes were made
if ! diff pom.xml pom.xml.bak > /dev/null 2>&1; then
    echo "Successfully removed -SNAPSHOT from pom.xml"
    rm pom.xml.bak
else
    echo "No -SNAPSHOT found in pom.xml for parenet pom"
    rm pom.xml.bak
fi

# Git add pom.xml
echo "Adding pom.xml to git..."
git add pom.xml

# Open emacs to edit release notes
echo "Opening emacs to edit release notes..."
emacs -nw release-notes/VERSION*
echo "Adding release-notes/VERSION* to git..."
git add release-notes/VERSION*

git diff --staged
