#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '

# Starship config
sprompt() {
  local f="$HOME/.config/starship/$1.toml"
  if [[ -f "$f" ]]; then
    export STARSHIP_CONFIG="$f"
  else
    echo "Available:" && ls ~/.config/starship | sed 's/\.toml$//'
  fi
}

# Tab completion for sprompt
_sprompt_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "$(ls ~/.config/starship 2>/dev/null | sed 's/\.toml$//')" -- "$cur") )
}
complete -F _sprompt_complete sprompt

# Default preset for new terminal
if command -v starship >/dev/null 2>&1; then
    export STARSHIP_CONFIG="$HOME/.config/starship/pastel-powerline.toml"
    eval "$(starship init bash)"
fi
