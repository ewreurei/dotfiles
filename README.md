My configuration files  
Using [dotter] for management, and this files mainly used on windows  

## if windows:
```sh
# initial
sudo cmd /c mklink /d %userprofile%\.config %appdata%
sudo cmd /c mklink /d %userprofile%\.vim %userprofile%\vimfiles
# before checking
sudo dotter deploy -d
# deploy
sudo dotter deploy
```
## or other (not tested):
```sh
# before checking
dotter deploy -d
# deploy
dotter deploy
```
## or using [just]:
```sh
# (some info about recipes)
just -l
# or
just
```
```sh
# if windows
just init
# before checking
just dry
# deploy
just deploy
```

[dotter]: https://github.com/SuperCuber/dotter
[just]: https://github.com/casey/just
