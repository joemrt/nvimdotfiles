
# Configuration file for neovim

This configures neovim in Linux for writing Python and LaTeX code based on
various plugins and self-written vimscript and lua.

## General

+ Place this file under ~/.config/nvim/init.vim
+ Install vim-plug
+ `PlugInstall` all plugins

## Configuration files

All names are relative to `~/.config/nvim`

+  `init.vim` Configuration in VimL
+  `lua/general/init.lua` Configuration in Lua. Will be required in `init.vim`.
+  `ftplugin/` own filetype dependant "plugins" (in VimL and Lua).
+  `autoload/` VimL "plugins" for autoloading to reduce overhead.
+ `snippets/` Contains LaTeX snippets to be included via keymappings, cf. `ftplugin/tex.vim`.
+ `scripts/` A (rather random) collection of scripts in bash and option files (e.g. for coc-vim) in VimL. This folder can also contain a file `scripts/localsettings.vim` that should not be included in the git repository and can be used for local configuration.


## Usage for python (based on coc-vim)

+ Download the node binaries in a folder

+ link the node, npm and npx executables to a folder in the PATH

+ Install `coc-pyright` by running `CocInstall coc-pyright` in command mode.

+ Ensure tmux is installed

+ Ensure ipython is configured with vim keybindings

## Usage for LaTeX

+ Install LaTeX packages
+ Install mupdf, compiled with the right options (TODO: include)
