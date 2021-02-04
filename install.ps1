# <------!!! THIS IS CURRENTLY UNTESTED !!!------>
#Requires -RunAsAdministrator
$ErrorActionPreference = "Stop"

# Powershell Check
echo "Checking powershell version..."
pwsh -Version

# Install Scoop
echo "Installing Scoop..."
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex

# Install Chocolatey
echo "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install starship
echo "Installing Starship Prompt..."
scoop install starship

# Install posh-git
echo "Installing posh-git..."
Install-Module posh-git -Scope CurrentUser

# Install Get-ChildItemColor
echo "Installing Get-ChildItemColor..."
Install-Module -AllowClobber Get-ChildItemColor

# Install Packages needed
echo "Installing packages..."
scoop install git neovim less grep bat wget gcc ffmpeg youtube-dl hwmonitor win32-openssh
choco install python3 pip jre8

# Download dotfiles 
echo "Downloading dotfiles..."
git clone https://github.com/AJigsawnHalo/dotfiles.git .dotfiles

# Create symbolic links
echo "Creating symbolic links..."
New-Item -Path $PROFILE -ItemType SymbolicLink -Value $HOME/.dotfiles/Microsoft.PowerShell_profile.ps1
New-Item -Path $HOME/.vimrc -ItemType SymbolicLink -Value $HOME/.dotfiles/vimrc
mkdir $HOME/AppData/Local/nvim
New-Item -Path $HOME/AppData/Local/nvim/init.vim -ItemType SymbolicLink -Value $HOME/.dotfiles/init_win.vim
New-Item -Path $HOME/.starship.toml -ItemType SymbolicLink -Value $HOME/.dotfiles/starship.toml

echo "Install Complete."
