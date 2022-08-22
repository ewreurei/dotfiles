# Note: This file mainly used on windows
alias d := deploy

# This option added from v1.20, see: https://github.com/casey/just/blob/master/CHANGELOG.md#120---2022-5-31
set windows-shell := ["cmd", "/c"]

# Listiong recipes
_default:
    @just --list

# Deploy
deploy:
    sudo dotter deploy

# Dry run deploy
dry:
    sudo dotter deploy -d

# Init on windows (make some symlinks)
init:
    sudo cmd /c mklink /d %userprofile%\.config %appdata%
    sudo cmd /c mklink /d %userprofile%\.vim %userprofile%\vimfiles
