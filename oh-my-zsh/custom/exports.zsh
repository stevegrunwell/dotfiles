# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# Hide the annoying ASCII art for VVV
export VVV_SKIP_LOGO=true

# Enable developer mode for Slack
export SLACK_DEVELOPER_MENU=true
