# ~/.bashrc: Made by: Ruben_&_Linux:~ 

# Set default programs
export EDITOR=vim
export TERMINAL=foot
export BROWSER=firefox

# Add scripts path safely
if [[ ":$PATH:" != *":$HOME/Scripts:"* ]]; then
    export PATH="$PATH:$HOME/Scripts"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load starship prompt if starship is installed
if [ -x /usr/bin/starship ]; then
	__main() {
		local major="${BASH_VERSINFO[0]}"
		local minor="${BASH_VERSINFO[1]}"

		if ((major > 4)) || { ((major == 4)) && ((minor >= 1)); }; then
			source <("/usr/bin/starship" init bash --print-full-init)
		else
			source /dev/stdin <<<"$("/usr/bin/starship" init bash --print-full-init)"
		fi
	}
	__main
	unset -f __main
fi

# Advanced command-not-found hook
if [[ -f /usr/share/doc/find-the-command/ftc.bash ]]; then
  source /usr/share/doc/find-the-command/ftc.bash
fi


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${void_chroot:-}" ] && [ -r /etc/void_chroot ]; then
    void_chroot=$(cat /etc/void_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${void_chroot:+($void_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${void_chroot:+($void_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${void_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

## Useful aliases

# enable color support of ls and also add handy aliases
# Replace ls with eza
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'    
    alias ls='eza -al --color=always --group-directories-first --icons'     # preferred listing
    alias la='eza -a --color=always --group-directories-first --icons'      # all files and dirs
    alias ll='eza -l --color=always --group-directories-first --icons'      # long format
    alias lt='eza -aT --color=always --group-directories-first --icons'     # tree listing
    alias l.='eza -ald --color=always --group-directories-first --icons .*' # show only dotfiles
fi

# Replace some more things with better alternatives
if [[ -x /usr/bin/bat ]]; then
  alias cat='bat --style header --style snip --style changes --style header'
fi

# Pacman aliases
    alias p='sudo pacman -S'                                    # install
    alias pu='sudo pacman -Syu'                                 # update, add 'a' to the list of letters to update AUR packages if you use yaourt
    alias pr='sudo pacman -Rs'                                  # remove
    alias ps='sudo pacman -Ss'                                  # search
    alias pi='sudo pacman -Si'                                  # info
    alias plo='sudo pacman -Qdt'                                # list orphans
    alias pro='sudo paclo && sudo pacman -Rns $(pacman -Qtdq)'  # remove orphans
    alias pc='sudo pacman -Scc'                                 # clean cache
    alias plf='sudo pacman -Ql'                                 # list files
    alias pkglist='sudo pacman -Qs --color=always | less -R'    
    alias pkg_size='expac -H M '%m\t%n' | sort -h'
    alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"
    alias ipv6="ip addr show | grep 'inet6 ' | cut -d ' ' -f6 | sed -n '2p'" 
    alias autorem='orphans=$(pacman -Qdtq); [ -z "$orphans" ] && echo "There are no orphaned packages" || sudo pacman -Rsc $orphans'
    alias halt='sudo halt'
    alias poweroff='sudo systemctl poweroff'
    alias reboot='sudo systemctl reboot'
    alias shutdown='sudo systemctl shutdown'

# Common use
    alias grubup="sudo update-grub"
    alias tarnow='tar -acf '
    alias untar='tar -zxvf '
    alias wget='wget -c '
    alias psmem='ps auxf | sort -nr -k 4'
    alias psmem10='ps auxf | sort -nr -k 4 | head -10'
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias .....='cd ../../../..'
    alias ......='cd ../../../../..'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='ugrep --color=auto'
    alias fgrep='ugrep -F --color=auto'
    alias egrep='ugrep -E --color=auto'
    alias hw='hwinfo --short'                          # Hardware Info
    alias big="expac -H M '%m\t%n' | sort -h | nl"     # Sort installed packages according to size in MB (expac must be installed)
    alias ip='ip -color a'

# Help me
    alias please='sudo'
    alias tb='nc termbin.com 9999'
    alias helpme='cht.sh --shell'
    alias pacdiff='sudo -H DIFFPROG=meld pacdiff'

# Get the error messages from journalctl
    alias jctl="journalctl -p 3 -xb"

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
