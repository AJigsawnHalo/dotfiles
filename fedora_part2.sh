#!/bin/bash

# Run lpf to finish spotify install
lpf update

# Install Discord
sudo snap install discord

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
