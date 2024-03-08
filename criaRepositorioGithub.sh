#!/bin/bash

# Repository information
GITHUB_USER="rpassosdomingues"
REPOS=("cache" "tmp" "main" "insights")
FILE_NAME="README.md"
COMMIT_MESSAGE="first commit"

for REPO_NAME in "${REPOS[@]}"; do
    # Create a new directory
    mkdir $REPO_NAME
    cd $REPO_NAME

    # Initialize the Git repository
    git init

    # Create a README.md file with some content
    echo "# $REPO_NAME" >> $FILE_NAME

    # Add the README.md file to the repository
    git add $FILE_NAME

    # Make the first commit
    git commit -m "$COMMIT_MESSAGE"

    # Associate the local repository with the remote repository on GitHub
    git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git

    # Push the code to GitHub
    git push -u origin master

    # Go back to the parent directory
    cd ..
done
