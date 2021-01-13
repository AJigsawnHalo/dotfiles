# ssh functions
function akagi{
	ssh -p 1991 elskiee@192.168.18.144
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
	param(
		[array] $AppList
	)
	ForEach ($App in $AppList) {
		scoop update $App
	}
}
function inst{
	param(
		[array] $AppList
	)
	ForEach ($App in $AppList) {
		scoop install $App
	}
}
function remo{
	param(
		[array] $AppList
	)
	ForEach ($App in $AppList) {
		scoop uninstall $App
	}
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
Set-Theme Star

Set-Alias make mingw32-make

# Git functions
function gpsho {
	param(
		[array] $ArgList
	)
	ForEach ($Arg in $ArgList) {
		git push origin $Arg
	}	
}
function gpllo {
	param(
		[array] $ArgList
	)
	ForEach ($Arg in $ArgList) {
		git pull origin $Arg
	}	
}
function gcmmt {
	git commit
}
