#!/bin/bash

# Initialize variables
ARG=$1
essential=("bashrc" "aliases" "zshrc" "vimrc" "tmux.conf")
i3=("bashrc" "aliases" "zshrc" "vimrc" "tmux.conf" "i3" "config" "i3status.conf")
all=("bashrc" "aliases" "zshrc" "vimrc" "tmux.conf" "i3" "config" "i3status.conf" "Xresources")


# Check for OS and version
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

echo "The OS is $OS $VER"

# Update and install needed packages
echo "Checking for required packages"
# For Debian-based distros
if [ "$OS" == "Pop!_OS" ] || [ "$OS" == "Ubuntu" ] || [ "$OS" == "Debian" ]; then
	## Update Installed Packages
	sudo apt update && sudo apt upgrade -y
	## Install Essential Packages
	sudo add-apt-repository ppa:papirus/papirus
	sudo apt install build-essential curl git tmux zsh neovim wget papirus-icon-theme materia-gtk-theme nodejs npm
	## Install Additional/Proprietary Packages
	### VSCode
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	### Spotify
	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	### Discord
	wget --content-disposition 'https://discord.com/api/download?platform=linux&format=deb' -O /tmp/discord.deb

	sudo apt update && sudo apt install /tmp/discord.deb spotify-client code ubuntu-restricted-extras
# For Arch-based distros
elif [ "$OS" == "Arch Linux" ] || [ "$OS" == "Manjaro Linux" ]; then
	## Update Installed Packages
	sudo pacman -Syu
	## Install Essential Packages
	sudo pacman -S curl git tmux zsh neovim wget base-devel materia-gtk-theme papirus-icon-theme nodejs npm
	## yay installation
	mkdir -p ~/Other/src
	cd ~/Other/src
	### Pull yay git
	git clone https://aur.archlinux.org/yay.git yay
	cd yay
	makepkg -si	
	cd ~
	## Install Additional/Proprietary Packages
	### Import gpg key for Spotify
	#curl -sS https://download.spotify.com/debian/pubkey.gpg | gpg --import -
	### Install packages
	yay -Sy discord spotify visual-studio-code-bin
fi

# Clone the dotfiles git if it's not found
if [ ! -f $HOME/.dotfiles ]; then
	echo "Dotfiles directory not found. Cloning git repo."
	git clone https://gitlab.com/AJigsawnHalo/dotfiles.git .dotfiles
fi

# Download plugins and themes for vim and zsh

# Oh-My-ZSH
echo "Installing Oh-My-Zsh"
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# ZSH Spaceship theme
echo "Installing Zsh Spaceship theme"
ZSH_CUSTOM="/home/elskiee/.oh-my-zsh/custom"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Vim-plug plugin manager
echo "Installing Vim-plug plugin manager"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Create symlinks
echo "Creating symlinks"
if [ "$ARG" == "i3" ]; then
	for file in ${i3[@]}; do
		ln -sfv $HOME/.dotfiles/$file $HOME/.$file	
	done
	ln -sfv $HOME/.dotfiles/colors $HOME/.vim/colors
elif [ "$ARG" == "include-all" ]; then
	for file in ${all[@]}; do
		ln -sfv $HOME/.dotfiles/$file $HOME/.$file	
	done
	ln -sfv $HOME/.dotfiles/colors $HOME/.vim/colors
elif [ "$ARG" == "" ]; then 
	for file in ${essential[@]}; do
		ln -sfv $HOME/.dotfiles/$file $HOME/.$file	
	done
	ln -sfv $HOME/.dotfiles/colors $HOME/.vim/colors
fi

# Create package management symlink for the appropriate distro
# For Debian-based distros
if [ "$OS" == "Pop!_OS" ] || [ "$OS" == "Ubuntu" ] || [ "$OS" == "Debian" ]; then
	ln -sfv $HOME/.dotfiles/aptAliases ~/.packman_aliases
# For Arch-based distros
elif [ "$OS" == "Arch Linux" ] || [ "$OS" == "Manjaro Linux" ]; then
	ln -sfv $HOME/.dotfiles/pacmanAliases ~/.packman_aliases
fi

# Use vimrc for neovim
mkdir ~/.config/nvim
echo -e "set runtimepath^=~/.vim runtimepath+=~/.vim/after\n\
	let &packpath = &runtimepath\n\
	source ~/.vimrc" >> ~/.config/nvim/init.vim
# Install vim-plug plugins
	sudo npm install -g yarn
	vim -c 'PlugInstall|q'
	vim -c 'CocInstall -sync coc-sh coc-marketplace \
		coc-rls coc-powershell coc-godot \
		coc-clangd coc-vimlsp coc-tsserver \
		coc-pyright coc-git coc-cord|q'
echo -e "\nInstall Complete."
