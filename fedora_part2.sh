#!/bin/bash

# Install Discord
sudo snap install discord spotify

# Install nodejs
dnf module list nodejs
echo -e "Pick a node version:"
read $ver
sudo dnf module install nodejs:$ver

# Install Coc extensions
sudo npm install -g yarn
nvim -c 'CocInstall -sync coc-sh coc-marketplace \
		coc-rls coc-powershell coc-godot \
		coc-clangd coc-vimlsp coc-tsserver \
		coc-pyright coc-git coc-cord|q'
