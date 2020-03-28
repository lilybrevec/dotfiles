##################################################
##### ZPLUGIN
##################################################

### Added by Zplugin's installer
source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin light "zsh-users/zsh-completions"
zplugin light "mollifier/cd-bookmark"
zplugin light "mollifier/cd-gitroot"
zplugin light "mollifier/anyframe"
zplugin load  "zsh-users/zsh-syntax-highlighting"


# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

##################################################
##### Functions
##################################################
############### peco ###############
# https://qiita.com/vintersnow/items/08852df841e8d5faa7c2
# 20190510 fc(using peco)
function find_cd() {
    cd "$(find . -type d | peco)"
}
alias fc="find_cd"

# 20190510 pecoでkill
function peco-pkill() {
  for pid in `ps aux | peco | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
alias pkill="peco-pkill"

# 20190510 pecoでhistory検索
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

##################################################
##### Peco ALIAS
##################################################
alias fc='find_cd'
alias pkill='peco-pkill'
alias cdb='cd-bookmark'
alias cdg='cd-gitroot'
alias ptmux='anyframe-source-tmux-sessions'

##################################################
##### FOR LANGUAGE
##################################################
# anyenv
eval "$(anyenv init -)"
export PATH="$HOME/.anyenv/bin:$PATH"

# OCaml
eval `opam config env`
export OCAMLMAKEFILE=".opam/default/lib/ocaml-makefile/OCamlMakefile"

# rust
source $HOME/.cargo/env
export PATH=$HOME/.cargo/bin:$PATH

# ruby
# If you need to have ruby first in your PATH run:
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/ncurses/bin:$PATH"
# For compilers to find ruby you may need to set:
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export LDFLAGS="-L/usr/local/opt/ncurses/lib"
export CPPFLAGS="-I/usr/local/opt/ncurses/include"
# For pkg-config to find ruby you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
export PKG_CONFIG_PATH="/usr/local/opt/ncurses/lib/pkgconfig"
#export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export LC_CTYPE="en_US.UTF-8"

# goenv
export GOPATH=$HOME/go/1.12.7
export PATH=$GOPATH/bin:$PATH

##################################################
##### OTHER ALIAS
##################################################
alias ls='exa'
alias ll='exa -ahl'
alias lg='exa --git'
alias la='gls --color=auto -aFG'
alias emacs='emacs -nw'
alias rmc='rm -f *~; rm -f ./\#*'
alias rmf='rm -rf '
alias ud='cd ..'
alias uud='cd ../../'
alias jiq='.local/lib/go/1.12.7/bin/jiq'
alias reload="(exec $SHELL -l)"
alias vim='nvim'
alias vi='nvim'

alias g='git'
alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias -g R='`git remote | peco --prompt "GIT REMOTE>" | head -n 1`'
alias -g H='`curl -sL https://api.github.com/users/chojuku/repos | jq -r ".[].full_name" | peco --prompt "GITHUB REPOS>" | head -n 1`'
alias -g LR='`git branch -a | peco --query "remotes/ " --prompt "GIT REMOTE BRANCH>" | head -n 1 | sed "s/remotes\/[^\/]*\/\(\S*\)/\1 \0/"`'
alias '..'='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias -g G='| grep'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g S='| sed'
alias -g C='| cat'


if [ "$(uname)" = "Darwin" ]; then
  source $HOME/dotfiles/config/.zshrc-alias-mac
fi
##################################################
##### PATH
##################################################
export PATH="$HOME/.local/bin:/usr/local/lib:/usr/local/bin:$HOME/dotfiles/bin:$HOME/.config/bin:$PATH"
