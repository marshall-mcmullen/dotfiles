#!/bin/bash

echo

if [[ -f ~/.ssh/agent.env ]]; then
    source ~/.ssh/agent.env >/dev/null
fi

if [[ ! -v SSH_AGENT_PID ]] || ! kill -0 "${SSH_AGENT_PID}" &>/dev/null; then
  echo -e "${COLOR_MAGENTA}Starting new SSH agent...${COLOR_NONE}"
  eval "$(ssh-agent -s)" >/dev/null
  echo "export SSH_AUTH_SOCK=${SSH_AUTH_SOCK}" >  ~/.ssh/agent.env
  echo "export SSH_AGENT_PID=${SSH_AGENT_PID}" >> ~/.ssh/agent.env
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
