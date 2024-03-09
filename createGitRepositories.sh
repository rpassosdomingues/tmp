#!/bin/bash

# Function to decrypt the credentials file
decrypt_credentials() {
    openssl aes-256-cbc -d -in credentials.enc -out credentials.txt
}

# Function to create a new repository
create_repo() {
    echo "Enter the name for the new repository:"
    read repo_name
    echo "Enter a description for the new repository:"
    read repo_description

    # Decrypt credentials
    decrypt_credentials

    # Extract username and token from decrypted credentials
    username=$(grep "username" credentials.txt | cut -d'=' -f2)
    token=$(grep "token" credentials.txt | cut -d'=' -f2)

    # Make API request to create a new repository
    curl -X POST -H "Authorization: token $token" -d "{\"name\":\"$repo_name\",\"description\":\"$repo_description\",\"default_branch\":\"main\"}" https://api.github.com/user/repos

    # Remove the decrypted credentials file
    rm credentials.txt
}

# Function to delete a repository
delete_repo() {
    echo "Enter the name of the repository to delete:"
    read repo_name

    # Decrypt credentials
    decrypt_credentials

    # Extract username and token from decrypted credentials
    username=$(grep "username" credentials.txt | cut -d'=' -f2)
    token=$(grep "token" credentials.txt | cut -d'=' -f2)

    # Make API request to delete the repository
    curl -X DELETE -H "Authorization: token $token" https://api.github.com/repos/$username/$repo_name

    # Remove the decrypted credentials file
    rm credentials.txt
}

# Function to rename a repository
rename_repo() {
    echo "Enter the current name of the repository:"
    read old_name
    echo "Enter the new name for the repository:"
    read new_name

    # Decrypt credentials
    decrypt_credentials

    # Extract username and token from decrypted credentials
    username=$(grep "username" credentials.txt | cut -d'=' -f2)
    token=$(grep "token" credentials.txt | cut -d'=' -f2)

    # Make API request to rename the repository
    curl -X PATCH -H "Authorization: token $token" -d "{\"name\":\"$new_name\"}" https://api.github.com/repos/$username/$old_name

    # Remove the decrypted credentials file
    rm credentials.txt
}

# Menu
while true
do
    echo "GitHub Repository Management"
    echo "0. Exit"
    echo "1. Create a new repository"
    echo "2. Delete a repository"
    echo "3. Rename a repository"

    read choice

    case $choice in
        0) break;;
        1) create_repo;;
        2) delete_repo;;
        3) rename_repo;;
        *) echo "Invalid choice";;
    esac
done