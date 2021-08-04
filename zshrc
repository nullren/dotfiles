# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# use vim editing
bindkey -v

autoload -U compinit promptinit colors
compinit
promptinit
colors

# This will set the default prompt to the walters theme
prompt off

# Set title
precmd() {
  printf "\033]0;%s:%s\007" "${USER}" "${PWD/#$HOME/~}"
}

# Note, some environment variables contain sensitive information like
# HOMEBREW_GITHUB_API_TOKEN which should not be in git. Most of these
# are goign to be found in `~/.zshenv` which were set manually.

# History
export HISTSIZE=99999
export SAVEHIST=99999
export HISTFILE=~/.zhistory
setopt inc_append_history


# Report CPU usage for commands running longer than REPORTTIME seconds
export REPORTTIME=10

# use neovim
alias vi=vim
alias vim=nvim

work-gist() {
  export GITHUB_URL=https://gist.ghe.io/
  gist $*
}

random-words() {
  gshuf -n ${1:-1} /usr/share/dict/words
}

function lsop() {
  lsof -iTCP -sTCP:LISTEN -P
}

# this plays weird with intellij and our projects
unset GOFLAGS

# set path -- do this last
typeset -U path
path=(~/local/bin /usr/local/opt/mysql@5.7/bin $path[@])

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## this is slow without the `--no-use` flag which requires you to run
## `nvm use node` manually when you want to use node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

## ruby environments
eval "$(rbenv init -)"

## rust development
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
