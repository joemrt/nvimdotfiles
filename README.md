# Configuration files for Neovim

My personal configuration of Neovim for usage within Linux or WSL, with a particular focus on writing Python and LaTeX, based on various plugins by other people and self-written VimL and Lua.
As this is designed for private usage, don't expect anything in this repository to work out of the box or to be sufficiently documented. 

## Getting started

+ Install Neovim or download the latest binaries
+ Clone this repository into `~/.config/nvim/`
+ Install [vim-plug](https://github.com/junegunn/vim-plug)
+ `PlugInstall` all plugins
+ For Python and LaTeX procede as indicated below

## Overview of configuration files

All names are relative to `~/.config/nvim`

+  `init.vim` Configuration in VimL
+  `lua/general/init.lua` Configuration in Lua. Will be required within `init.vim`.
+  `ftplugin/` own filetype dependant "plugins" (in VimL and Lua).
+  `autoload/` VimL "plugins" for autoloading to reduce overhead.
+ `snippets/` Contains LaTeX snippets to be included via keymappings, cf. `ftplugin/tex.vim`.
+ `scripts/` A (rather random) collection of scripts in bash and option files (e.g. for coc-nvim) in VimL. This folder can also contain a file `scripts/localsettings.vim` that should not be included in the git repository and can be used for local configuration.


## Usage for python (based on coc-nvim)

+ Download the node binaries in a folder
+ link the node, npm and npx executables to a folder in the PATH
+ Open an arbitrary python file and install `coc-pyright` by running `CocInstall coc-pyright` in command mode.
+ Ensure tmux is installed
+ Ensure ipython is configured with vim keybindings
+ Open Neovim within a venv where `python` starts Python 3

More precisely, `coc-pyright` will look into `~/.config/nvim/coc-settings.json`, where it is told that '~/.config/nvim/scripts/python_interpreter.sh' is the "python interpreter" to be used (which in turn will launch the binary `python` of the shell environment.)
 **Note**: A python interpreter within the working directory will take precedence over this interpreter and might thus lead to unexpected behavior. 
To see which python interpreter is used by `coc-pyright` look at the result of `CocCommand workspace.showOutput` (select `Pyright`).

## Usage for LaTeX
TODO: make more explicit
+ Install LaTeX packages
+ Install/compile mupdf and xdotools with the right options
+ Only compile when an X server is running.
