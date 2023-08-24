#!/bin/bash

vi()
{
    if which nvim &>/dev/null; then
        vim="command nvim"
    else
        vim="command vim"
    fi

    if [[ "${@}" =~ "/" ]]; then
        if [[ $# -eq 1 && -e "src/${1}" ]]; then
            ${vim} "src/${1}"
        else
            ${vim} "${@}"
        fi
    else

        matches=(
            $(find . -maxdepth 1 -type f -name "${@}" -o -name "${@//-/_}")
            $(find . -mindepth 2 -type f -name "${@}" -o -name "${@//-/_}")
        )

        ${vim} -p "${matches[@]}"
    fi
}
