
# Shell Variables
#
SAVEHIST=100000
HISTSIZE=100000
HISTFILE=~/.zhistory

HOST=`hostname`
host=`echo $HOST | sed 's/[0-9]//g'`

#
# Prompt
#
setopt prompt_subst
PROMPT='%{[01;34m%}%n@%m %#%{[m%} '
RPROMPT='%{[01;34m%}[%~]%{[m%}'

#
# WORDCHARS
#
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#
# key bind
#
stty -istrip
case $OSTYPE in
    linux*)
	    stty intr '^c' erase '^h' kill '^u' susp '^z'
	    ;;
    darwin*)
	    stty intr '^c' erase '^h' kill '^u' susp '^z' dsusp '^y'
        ;;
    default)
	    stty intr '^c' erase '^h' kill '^u' susp '^z' dsusp '^y'
        ;;
esac

bindkey -e
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

#
# For zed
#
autoload zed

#
# Options
#
setopt ignore_eof
setopt notify
setopt auto_list
setopt nobeep
setopt auto_pushd

#### option, limit, bindkey
setopt extended_history
setopt hist_ignore_dups
setopt hist_reduce_blanks
#setopt append_history
#setopt inc_append_history
setopt share_history
setopt hist_no_store
setopt hist_ignore_space

#setopt list_packed
setopt print_eight_bit
#setopt menu_complete
setopt no_clobber
setopt no_unset
setopt no_hup
setopt no_beep

setopt extended_glob
setopt numeric_glob_sort
setopt auto_cd
setopt correct
#setopt no_checkjobs
#setopt ignore_eof
setopt pushd_to_home
setopt pushd_ignore_dups
#setopt pushd_silent
setopt interactive_comments
#setopt rm_star_silent
#setopt rm_star_wait
#setopt chase_links
# setopt sun_keyboard_hack
setopt NO_flow_control

#
# Complementarity
#
autoload -U compinit
compinit
compctl -c man which
compctl -g '*.tex' platex jlatex
compctl -g '*.dvi' xdvi dvi2ps
compctl -g '*.ps' gv lpr idraw
compctl -g '*.c' gcc
compctl -k hosts rup ping nslookup ssh scp
compctl -k limitargs limit unlimit

#
# Aliases
#
case $OSTYPE in
    linux*)
        alias ls='ls --color=auto'
        export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
	    ;;
    darwin*)
        alias ls='ls -G'
        export LSCOLORS=ExFxCxDxBxegedabagacad
        ;;
    default)
        ;;
esac


alias ll='ls -G -lAgs | less -r'
alias la='ls -G -A'
alias l='ls -G -l'
alias md='mkdir'
alias cls='clear'
alias mv='mv -i'
alias clean='rm *~ 1> /dev/null 2>&1; rm .*~ 1> /dev/null 2>&1; rm  core 1> /dev/null 2>&1; rm \#* 1> /dev/null 2>&1'
alias res='exec zsh'

#Global Aliases
alias -g L='| less -r'
alias -g G='| grep'
alias -g A='| awk'
alias -g S='| sed -e'
alias -g W='| wc'
alias -g ....='../../'

#
# Functions
#
title () {echo -n "\e]0;$*\a"}
function cd() { builtin cd $@ && ls; }
function popd() { builtin popd && ls; }
function psa() {
    ps auxww | head -1
    ps auxww | grep $1 | grep -v ps | grep -v grep ;
}
