#!/usr/bin/env zsh
# 2025-10-02

sudo -v # adm pw upfront
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> /Users/e/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/e/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
