# Preferred editor for local and remote sessions
export EDITOR='vim'

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# Hide the annoying ASCII art for VVV
export VVV_SKIP_LOGO=true

# Enable developer mode for Slack
export SLACK_DEVELOPER_MENU=true

# Favor the Homebrew-installed version of Ruby
export RUBY_HOME=/usr/local/opt/ruby/bin
export GEM_PATH=~/.gem/ruby/2.6.0
export PATH=$GEM_PATH/bin:$RUBY_HOME:$PATH

# Load Node Version Manager (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
