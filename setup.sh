#!/bin/bash
# GitHub Token Setup and Validation
echo "Setting up GitHub Token..."
read -p "Enter your GitHub token: " GITHUB_TOKEN
if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "No token provided. Exiting."
  exit 1
fi
echo "GitHub Token is set."