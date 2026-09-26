eval "$(ssh-agent -s)"
export EDITOR=vim

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.config/bash/{path,exports,aliases,prompt,functions/*,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Git completion
if [ -f ~/.config/bash/completions/git-completion.bash ]; then
  . ~/.config/bash/completions/git-completion.bash
fi

. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Source all completion files:
for file in ~/.bash_completion.d/*; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Mammouth Code
export PATH="$HOME/.mammouth/bin:$PATH"
