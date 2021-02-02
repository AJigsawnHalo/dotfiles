# ssh functions
function akagi{
	ssh -p 1991 elskiee@192.168.1.144
}
function akagi-pub{
	ssh -p 1991 elskiee@kaga-server.ddns.net
}
function kaga{
	ssh nightlock0326@kaga-server.ddns.net -p 1992
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
function upgd{
	scoop update @args
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

#function prompt {
#    Write-Host "PSC $(Get-Location) "
#    return "> "
#}
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt Star

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
