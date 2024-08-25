# Setup fzf
# ---------
if [[ ! "$PATH" == *${HOME}/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}${HOME}/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOME}/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
if [[ -f "${HOME}/.fzf/shell/key-bindings.bash" ]]; then
    source "${HOME}/.fzf/shell/key-bindings.bash"
fi

# Searching Tool
# --------------

# Use 'fd' instead of 'find' if available as it honors .gitignore
if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
fi
