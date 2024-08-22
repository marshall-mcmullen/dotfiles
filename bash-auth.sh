#!/bin/bash

echo

if [[ -z "${SSH_AGENT_PID}" ]]; then
    eval $(ssh-agent -s)
else
    echo -e " ${COLOR_GREEN}>>${COLOR_NONE} Found existing ssh-agent: ${COLOR_CYAN}${SSH_AGENT_PID}${COLOR_NONE}"
fi

# Add all private keys
for key in ~/.ssh/id_*; do
    if [[ ! -f "${key}" || "${key}" =~ pub ]]; then
        continue
    fi

    if ! ssh-add -l | grep -q "$(ssh-keygen -lf "${key}" | awk '{print $2}')"; then
        echo -e " ${COLOR_GREEN}>>${COLOR_NONE} Adding SSH key: ${COLOR_CYAN}${key}${COLOR_NONE}"
        ssh-add "${key}"
    else
        echo -e " ${COLOR_GREEN}>>${COLOR_NONE} Known ssh key: ${COLOR_CYAN}${key}${COLOR_NONE}"
    fi
done

echo
