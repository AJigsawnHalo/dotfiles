# ssh functions
function akagi{
	ssh -p 1991 elskiee@akagi-pi.local
}
function akagi-pub{
	ssh -p 1991 elskiee@kaga-server.ddns.net
}
function hiryu{
	ssh -p 1991 elskiee@hiryu.local
}
function pwsh-a{
	Start-Process pwsh -Verb RunAs
}
function cmd-a{
	Start-Process cmd -Verb RunAs
}
function ln ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}
function cln{
	if ( $args -eq "-a") {
		scoop cache rm -a
		scoop cleanup -a
	}
	else {
		scoop cleanup @args
	} 
}
function upgd{
	$update = {
		Write-Host "Upgrading Scoop apps..."
		scoop status
		scoop update *
		scoop cache rm -a
		scoop cleanup -a
	}
	$script = {
		Write-Host "Upgrading Scoop apps..."
		scoop status
		scoop update *
		Write-Host "Cleaning Scoop apps..."
		scoop cache rm -a
		scoop cleanup -a
		Write-Host "Upgrading winget apps..."
		winget upgrade --all
	}
	if ( $args -eq "-y") {
		pwsh $update
	}
	elseif ($args -eq "-a") {
		Start-Process pwsh -Verb RunAs -ArgumentList "-noexit -command $script"
	}
	else {
		scoop update @args
	} 
}
function inst{
	scoop install @args
}
function remo{
	scoop uninstall @args
}
function updt{
	scoop update && scoop status
}

# colored ls output
If (-Not (Test-Path Variable:PSise)) {  # Only run this in the console and not in the ISE
    Import-Module Get-ChildItemColor
    
    Set-Alias la Get-ChildItem -option AllScope
    Set-Alias ls Get-ChildItemColorFormatWide -option AllScope
}

# Prompt
#function prompt {
#    Write-Host "PSC $(Get-Location) "
#    return "> "
#}
Import-Module posh-git
#Import-Module oh-my-posh
#Set-PoshPrompt Star
$ENV:STARSHIP_CONFIG = "$HOME\.starship.toml"
Invoke-Expression (&starship init powershell)

Set-Alias make mingw32-make
Set-Alias vim nvim

# Git functions
function gpsho {
		git push origin $args[0]
}
function gpllo {
		git pull origin $args[0]
}
function gcmmt {
	git commit @args
}
function gco {
	$branch = $args[1]
	$param = $args[0]
	git checkout $param $branch
} 


function reboot {
	shutdown /r /f /t 0
}
function poweroff {
	shutdown /s /f /t 0
}
function copy-ssh-key {
	$param = $args
	cat $HOME\.ssh\id_ed25519.pub | ssh $param "cat >> .ssh/authorized_keys"
}
