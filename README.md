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

## License
Basically, files published under the [CC0 License][CC0] explicitly  
But if codes have via links (in vimrc), some rights might be returned into them so maybe you have to check it  
Anyway, feel free to steal my snippets I wrote :)  

[dotter]: https://github.com/SuperCuber/dotter
[just]: https://github.com/casey/just
[CC0]: https://creativecommons.org/publicdomain/zero/1.0/deed
