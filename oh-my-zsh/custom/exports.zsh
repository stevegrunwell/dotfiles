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
export GEM_PATH=~/.gem/ruby/2.7.0
export PATH=$GEM_PATH/bin:$RUBY_HOME:$PATH

# Add /usr/local/sbin to $PATH
export PATH=/usr/local/sbin:$PATH

# WordPress core test suite
export WP_TESTS_DIR="~/Vagrant/VVV/www/wordpress-trunk/public_html/tests/phpunit/"

# Let PHP Coding Standards Fixer use PHP 8.
export PHP_CS_FIXER_IGNORE_ENV=true
