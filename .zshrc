# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt autocd beep nomatch
unsetopt menu_complete
setopt noautomenu
setopt HIST_SAVE_NO_DUPS
# bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/alagyn/.zshrc'

autoload -Uz compinit; compinit
# End of lines added by compinstall
zstyle ':completion:*' insert-unambiguous true

# Use `cat` to get control codes
bindkey '\t' expand-or-complete
bindkey '^[[3~' delete-char
bindkey '^H' backward-kill-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

precmd()
{
    local RET_CODE=$?

    # Green
    local G=$'%{\e[1;32m%}'
    # Cyan
    local C=$'%{\e[1;36m%}'
    # Brown
    local B=$'%{\e[1;33m%}'
    # Red
    local R=$'%{\e[1;31m%}'
    # End
    local E=$'%{\e[0m%}'
    # Gets the name of the current git branch for the CWD
    # Modified from:
    # https://gist.github.com/Ragnoroct/c4c3bf37913afb9469d8fc8cffea5b2f?permalink_comment_id=3560622#gistcomment-3560622
    local headfile head branch
    local dir="$PWD"
    local prevError=""

    local NL=$'\n'

    if [ $RET_CODE -ne 0 ]
    then
        prevError="[${R}Command returned code ${RET_CODE}${E}]${NL}"
    fi

    while [ -n "$dir" ]; do
        if [ -e "$dir/.git/HEAD" ]; then
            headfile="$dir/.git/HEAD"
            break
        fi
        dir="${dir%/*}"
    done

    if [ -e "$headfile" ]; then
        read -r head < "$headfile" || return
        case "$head" in
            ref:*)
                branch="${head##*/}"
                ;;
            "") 
                branch=""
                ;;
            *) 
                #Detached head, check if we are pointing at a tagged commit
                tags=`git tag --points-at HEAD`

                if [ -e "$tags" ]
                then
                    # if not, just use a bit of the hash
                    branch="${head:0:7}"
                else
                    # else use the tag(s) as the branch
                    branch=$tags
                fi
                ;;
        esac
    fi

    if [ -n "$branch" ]
    then
        branch="(󰘬 ${B}$branch${E})"
    fi

    # Check for a python virtual env
    if [ -z "$VIRTUAL_ENV" ]
    then
        venv=""
    else
        venv="[ ${G}`realpath --relative-to=$HOME $VIRTUAL_ENV`${E}]"
    fi

    #\n[user@host cwd] (branch) (venv)\n$
    export PROMPT="${E}${NL}${prevError}[${G}%n${E}@${C}%M${E} %~] ${branch} ${venv}${NL}$ "
}

alias ls="ls --color=auto"
alias ll="ls --color=auto -alh"

# . "$HOME/.cargo/env"

source <(fzf --zsh)
# _fzf_setup_completion path nano
