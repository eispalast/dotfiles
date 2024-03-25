# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
EDITOR=nvim
VISUAL=code
bindkey -v

# source ~/.fonts/*.sh
# get this plugin at https://github.com/agkozak/zsh-z/blob/master/zsh-z.plugin.zsh
source ~/scripts/zsh-z.plugin.zsh  
source ~/.local/share/icons-in-terminal/icons_bash.sh
setopt PROMPT_SUBST
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/timo/.zshrc'
autoload -Uz compinit
compinit
if [[ -x /usr/lib/command-not-found ]] ; then
        function command_not_found_handler() {
                /usr/lib/command-not-found --no-failure-msg -- $1
        }
fi
# End of lines added by compinstall

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/timo/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/timo/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/timo/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/timo/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# autocompletion with ctrl+i using fzf 
# do some research to configure it so it only triggers with ctrl+i and not with tab
# source ~/scripts/fzf-zsh-completion.sh
# bindkey '^I' fzf_completion

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
				  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

vf(){
	local filename
	filename=$(find ${1:-.} -type f -print 2> /dev/null |fzf) &&
	nvim "$filename"
}
color_decider(){
	if (( $(pwd | grep "home" | wc -l ) > 0)) then
        echo "%F{green}"
	else
		echo "%F{blue}"
	fi
}
print_ubuntu_icon(){
	if (( $(cat /proc/version | grep arch | wc -l) > 0)) then
		echo -e $linux_archlinux
	elif (( $(cat /proc/version | grep ubuntu | wc -l) > 0)) then
		echo -e $linux_ubuntu
	else
		echo -e $linux_tux
	fi
}
parse_git_branch(){
	if (( $(git branch 2>/dev/null | sed -n -e 's/^\* \(.*\)/[\1] /p' | wc -l ) > 0)) then
        echo -e $dev_git$(git branch 2>/dev/null | sed -n -e 's/^\* \(.*\)/ \1 /p')
    fi
}
parse_git_status(){
    if (( $(git status 2> /dev/null| grep "git add" | wc -l) > 0)) then
        echo "%F{red}"
    elif (($(git status 2> /dev/null| grep "git restore" | wc -l) > 0)) then
        echo "%F{green}"
    fi
}
#psvar=1
PROMPT='%(?..%F{red})$(print_ubuntu_icon)%f$(color_decider) %B%2~%f%b%# '
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
    RPROMPT='$(parse_git_status)$(parse_git_branch)'
    function zle-line-init zle-keymap-select {
	    NORMAL_PROMPT='%(?..%F{red})$(print_ubuntu_icon)%f$(color_decider) %B%2~%f%b%# '
	    VIM_PROMPT='%(?..%F{red})%f$(color_decider) %B%2~%f%b%# '

	  # Set the prompt based on the current keymap
	  if [ "${KEYMAP}" = vicmd ]; then
		  PS1="$VIM_PROMPT"
	  else
		  PS1="$NORMAL_PROMPT"
	  fi
	  zle reset-prompt
	}
	zle -N zle-line-init
	zle -N zle-keymap-select
fi
setopt auto_cd
if [ -f ~/.zsh_aliases ]; then
	. ~/.zsh_aliases
fi
if [ -f /usr/share/fzf/completion.zsh ]; then
	source /usr/share/fzf/completion.zsh	 
fi
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
	source /usr/share/fzf/key-bindings.zsh	 
fi



export PATH="/home/timo/exchange/software:/home/timo/scripts:$PATH"
export EDITOR="nvim"

