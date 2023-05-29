#!/bin/bash
set -e

# Clone the repository
git clone https://github.com/kevinalavik/cpkg
cd cpkg

# Make cpkg.sh executable
chmod +x src/cpkg.sh

# Create a directory for user executables if it doesn't exist
mkdir -p ~/.local/bin

# Copy cpkg.sh to the user's executable directory
cp src/cpkg.sh ~/.local/bin/cpkg

# Add the user's executable directory to the PATH, if not already present
if ! echo $PATH | grep -q "~/.local/bin"; then
  echo "export PATH=\$PATH:~/.local/bin" >> ~/.bashrc
  source ~/.bashrc
fi

# Cleanup
cd ..
rm -rf cpkg
