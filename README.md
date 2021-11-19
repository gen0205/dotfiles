# dotfiles
my dotfiles

## install

```
$ cd ~
$ git clone https://github.com/gen0205/dotfiles.git
$ sh ~/dotfiles/install.sh
```

## manual install

### ~/.bash_profile

- bash-completion

add follows  
`[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"`

### delta

- for git

config to `~/.gitconfig`  
see [dandavison/delta](https://github.com/dandavison/delta)  

sample:  
```
[pager]
  diff = delta
  log = delta
  reflog = delta
  show = delta

[interactive]
  diffFilter = delta --color-only --features=interactive

[delta]
  features = decorations line-numbers
  plus-style = syntax "#008700"
  minus-style = syntax "#3f0001"

[delta "line-numbers"]
  line-numbers-left-style = cyan
  line-numbers-right-style = cyan
  line-numbers-minus-style = 124
  line-numbers-plus-style = 28

[delta "interactive"]
  keep-plus-minus-markers = false

[delta "decorations"]
  commit-decoration-style = bold yellow box ul
  commit-style = raw
  file-style = bold yellow ul
  file-decoration-style = none
  hunk-header-decoration-style = cyan box ul
  hunk-header-file-style = red
  hunk-header-line-number-style = "#067a00"
  hunk-header-style = file line-number syntax
```

- for lazygit

To use delta. need to config lazygit  
see [here](https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Pagers.md#delta)

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
- deopleteから[ddc](https://github.com/Shougo/ddc.vim)に移行する
- asdf-vm dotfiles
  - https://github.com/asdf-vm/asdf

### vim

- gitgutterを廃止して[vim-signify](https://github.com/mhinz/vim-signify)に移行する
