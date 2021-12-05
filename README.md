# Configuration files for Neovim

My personal configuration of Neovim for usage within Linux or WSL, with a particular focus on writing Python and LaTeX, based on various plugins by other people and self-written VimL and Lua.
As this is designed for private usage, don't expect anything in this repository to work out of the box or to be sufficiently documented. 

## Getting started

+ Install Neovim or download the [latest binaries](https://github.com/neovim/neovim/releases/)
+ Clone this repository into `~/.config/nvim/`
+ Install [vim-plug](https://github.com/junegunn/vim-plug)
+ `:PlugInstall` all plugins
+ For Python and LaTeX procede as indicated below

## Overview of configuration files

All names are relative to `~/.config/nvim`

+  `init.vim` Configuration in VimL
+  `lua/general/init.lua` Configuration in Lua. Will be required within `init.vim`.
+  `ftplugin/` own filetype dependant "plugins" (in VimL and Lua).
+  `autoload/` VimL "plugins" for autoloading to reduce overhead.
+ `snippets/` Contains LaTeX snippets to be included via keymappings, cf. `ftplugin/tex.vim`.
+ `scripts/` A (rather random) collection of scripts in bash and option files (e.g. for coc-nvim) in VimL. This folder can also contains the files `scripts/localsettings.vim` and `scripts/locallua.lua` that should not be included in the git repository and can be used for local configuration.


## Usage for python (based on [coc-nvim](https://github.com/neoclide/coc.nvim), [tmux](https://wiki.ubuntuusers.de/tmux/) and [nvim-dap](https://github.com/mfussenegger/nvim-dap))

### Setting up coc-nvim

+ Download the node binaries from [nodejs](https://nodejs.org/en/download/) in a folder
+ link the node, npm and npx executables to a folder in the $PATH
+ Open an arbitrary python file and install [coc-pyright](https://github.com/fannheyward/coc-pyright) by running `:CocInstall coc-pyright` in command mode.
+ Open Neovim within a venv where `python` starts Python 3

More precisely, `coc-pyright` will look into `~/.config/nvim/coc-settings.json`, where it is told that `~/.config/nvim/scripts/python_interpreter.sh` is the "python interpreter" to be used (which in turn will launch the binary `python` of the shell environment.)

**Note**: A python interpreter within the working directory will take precedence over this interpreter and might thus lead to unexpected behavior. 
To see which python interpreter is used by `coc-pyright` look at the result of `:CocCommand workspace.showOutput` (select `Pyright`).

To update all extensions use

```
:CocUpdate
```

### Usage with tmux

+ Ensure tmux is installed
+ Ensure ipython is installed in the used venv and configured with vim keybindings, that is add `c.TerminalInteractiveShell.editing_mode = 'vi'` to `~/.ipython/profile_default/ipython_config.py`.

Make a vertical split within tmux. Open `ipython --no-autoindent` in the lower pane. Parts of the code or the whole (saved) file can be send to this pane via

+ `gä` Takes a motion and sends the code up to the end position of the motion to the lower pane.  For instance `gäG` will send all code from the cursor position to the last line of the file to the lower pane. 
+ `gää` Sends the current line to the lower pane
+ `gÄ` Sends an execution command for the entire file to the lower pane. This will execute the saved file.

The pane to which code will be send can be changed via `g:python_tmux_window` (defaults to 1, which is the lower pane in a vertical split). 

### Usage of dap for debugging python

In the same framework that is used for your python interpreter (e.g. Anaconda) create a virtual environment `debugpy` and install `pip` and `debugpy`. 

The debugger can then be used as follows

+ `<leader>dd`: Start/continue debugging
+ `<leader>dx`: Toggle REPL
+ `<leader>dc`: Close debugging and go back to the last file where `<leader>dd` was pressed
+ `<leader>dn`: Go down the stack trace
+ `<leader>dp`: Go up the stack trace
+ `<leader>dj`: Step forward

## Usage for LaTeX
TODO: make more explicit
+ Install LaTeX packages
+ Install/compile mupdf and xdotools with the right options
+ Only compile when an X server is running.

## Improved syntax highlighting via the [treesitter plugin](https://github.com/nvim-treesitter/nvim-treesitter)

Install the language parsers of your choice, e.g. Python via

```
:TSInstall python
```

Add the following to your `scripts/locallua.lua` (open via `<leader>ela`):

```
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {"bash"},  -- bash highlighting unhelpful
    additional_vim_regex_highlighting = false,
  },
}
```
To update all installed parsers use

```
:TSUpdate
```


