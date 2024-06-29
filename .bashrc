# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

set_prompt()
{
    # Green
    local G="\[\e[1;32m\]"
    # Cyan
    local C="\[\e[1;36m\]"
    # Brown
    local B="\[\e[1;33m\]"
    # End
    local E="\[\e[0m\]"
    # Gets the name of the current git branch for the CWD
    # Modified from:
    # https://gist.github.com/Ragnoroct/c4c3bf37913afb9469d8fc8cffea5b2f?permalink_comment_id=3560622#gistcomment-3560622
    local headfile head branch
    local dir="$PWD"

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
        branch="(${B}$branch${E})"
    fi

    # Check for a python virtual env
    if [ -z "$VIRTUAL_ENV" ]
    then
        venv=""
    else
        venv="[${G}`realpath --relative-to=$HOME $VIRTUAL_ENV`${E}]"
    fi

    #\n[user@host cwd] (branch) (venv)\n$
    export PS1="${E}\n[${G}\u${E}@${C}\h${E} \w] ${branch} ${venv}\n$ "
}

export PROMPT_COMMAND=set_prompt
export HISTCONTROL=ignoreboth

alias ll="ls -alh"

