#!/bin/bash

# Function to create symbolic link if directory exists
create_symlink() {
    local var=$1
    local target_dir="$HOME/.dotfiles/linux/$var"
    local link_name="$HOME/.config/$var"

    if [[ -d "$target_dir" ]]; then
        if [[ -L "$link_name" ]]; then
            echo "Symbolic link for $var already exists. Skipping."
        elif [[ -e "$link_name" ]]; then
            echo "A file or directory named $var already exists in ~/.config. Skipping."
        else
            ln -s "$target_dir" "$link_name"
            echo "Created symbolic link for $var."
        fi
    else
        echo "Directory $target_dir does not exist. Skipping."
    fi
}

# Ensure at least one variable is provided
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 var1 var2 var3 ..."
    exit 1
fi

# Iterate over all provided variables
for var in "$@"; do
    create_symlink "$var"
done
