#!/bin/bash

vi()
{
    if which nvim &>/dev/null; then
        vim="command nvim"
    else
        vim="command vim"
    fi

    if [[ "${@}" =~ "/" ]]; then
        ${vim} "${@}"
    elif which fzf &>/dev/null && [[ $# -eq 1 ]]; then
        ${vim} -p "$(fzf --multi --select-1 --exact --query "${1}")"
    else
        ${vim} -p "${@}"
    fi
}
