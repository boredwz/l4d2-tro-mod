# l4d2-tro-mod

Left 4 Dead 2 sound mod.

## How to install (or update)

- `Win` + `R`
- Type `powershell`
- Paste the code below and press `Enter`
```
set-executionPolicy bypass -scope process -force
[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12
iwr -useb 'https://raw.githubusercontent.com/wvzxn/l4d2-tro-mod/main/setup.ps1'|iex
```

### OR

- Download and run [l4d2-tro-mod-setup.cmd](https://github.com/wvzxn/l4d2-tro-mod/releases/latest/download/l4d2-tro-mod-setup.cmd)
