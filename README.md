# dotfiles
my dotfiles

## install

```
$ cd ~
$ git clone https://github.com/gen0205/dotfiles.git
$ sh ~/dotfiles/install.sh
```

## ~/.bash_profile

- bash-completion

add follows
`[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"`

## requirements

### neovim

- nvim-0.4.2 <

for `liuchengxu/vim-clap` plugin

### python3

- pyenv recommended
  - TODO: replace to asdf.vm
- after install python3.x

`pip3 install --user pynvim`

after. launch nvim and execute follow command.

`:UpdateRemotePlugins`

### nodejs

- nodenv recommended
  - TODO: replace to asdf.vm
- require v8.10.0 <

### tmux

### exa

A modern version of ‘ls’.

> https://the.exa.website/

### ripgrep

ripgrep recursively searches directories for a regex pattern

> https://github.com/BurntSushi/ripgrep

### bat

A cat(1) clone with wings.

> https://github.com/sharkdp/bat

### fd

A simple, fast and user-friendly alternative to 'find'

> https://github.com/sharkdp/fd

## recommends(not require)

### lazygit

simple terminal UI for git commands

> https://github.com/jesseduffield/lazygit

## TODO

- vim LSP
  - COCが有力？
  - LSP Settings plugin
    - https://github.com/mattn/vim-lsp-settings
- zsh settings
  - https://github.com/junegunn/fzf/wiki/examples
- asdf-vm dotfiles
  - https://github.com/asdf-vm/asdf
