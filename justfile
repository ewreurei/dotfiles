# Note: This file mainly used on windows, and need casey/just to use

# This option added from v1.20, see: https://github.com/casey/just/blob/master/CHANGELOG.md#120---2022-5-31
set windows-shell := ["cmd", "/c"]
alias d := deploy

# variables
sudo := if os() == "windows" { "sudo " } else { "" }
deploy_cmd := sudo + "dotter deploy"
dry_cmd := deploy_cmd + " -d"

# Listing recipes
_default:
    @just --list

# Deploy
deploy:
    {{ deploy_cmd }}

# Dry run deploy
dry:
    {{ dry_cmd }}

# Init on windows (make some symlinks)
init:
    sudo cmd /c mklink /d %userprofile%\.config %appdata%
    sudo cmd /c mklink /d %userprofile%\.vim %userprofile%\vimfiles
