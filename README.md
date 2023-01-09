# Neovim from scratch

**Another Update** This repo is updated to work with Neovim 0.8. All packages are pinned in `master` so it should remain stable. Branches will be updated eventually.

## Try out this config

Run `nvim` and wait for the plugins to be installed. (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim) 

**NOTE** [Mason](https://github.com/williamboman/mason.nvim) is now used to install and manage LSP servers, DAP servers, linters, and formatters via the `:Mason` command.

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```
  sudo apt install xsel
  ```

- On Arch Linux

  ```
  sudo pacman -S xsel
  ```
  
- Wayland users

  [wl-clipboard](https://github.com/bugaevc/wl-clipboard)


Next we need to install python support (node is optional)

- Neovim python support

  ```
  pip install pynvim
  ```

- Neovim node support

  ```
  npm i -g neovim
  ```
---

**NOTE** make sure you have [node](https://nodejs.org/en/) installed, I recommend a node manager like [fnm](https://github.com/Schniz/fnm).

### Upgrade to latest release

Assuming you [built from source](https://github.com/neovim/neovim/wiki/Building-Neovim#quick-start), `cd` into the folder where you cloned `neovim` and run the following commands. 
```
git pull
make distclean && make CMAKE_BUILD_TYPE=Release
git checkout v0.8.0
sudo make install
nvim -v
```

> The computing scientist's main challenge is not to get confused by the complexities of his own making. 

\- Edsger W. Dijkstra
