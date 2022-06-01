#!/usr/bin/env zsh
#
# Install the dotfiles into a user's home directory.
#
# USAGE
#
#   install.sh [-d|--debug]
#
# OPTIONS
#
#   -d, --debug         Display debug information.
#   -h, --help          Show the help screen.
#   -u, --unattended    Do not attempt steps that require user interaction.

set -e

# The directory this script lives in.
dotfiles_dir=$0:a:h

# The current script name.
script_name=$0:a:t

# Set up colors.
color_cyan="\033[0;36m"
color_green="\033[0;32m"
color_red="\033[0;31m"
color_reset="\033[0;0m"
color_yellow="\033[0;33m"
bold="$(tput bold)"
nobold="$(tput sgr0)"

# Options.
debug_mode=0
unattended=0

# Print the usage instructions.
function print_usage {
    cat <<EOT
Install the dotfiles into a user's home directory.

${bold}USAGE${nobold}

    ${script_name} [-d|--debug] [-u|--unattended]

${bold}OPTIONS${nobold}

    -d, --debug         Display debug information.
    -h, --help          Show this help screen.
    -u, --unattended    Do not attempt steps that require user interaction.

EOT
}

# Symlink a local file into the user's home directory, making a backup if the original
# is a regular file.
#
# Usage:
#     safe-symlink <source_file> <target_file>
#
safe-symlink() {
    source_file=${1:?Invalid source file}
    target_file=${2:?Invalid target file}

    # If a real file exists, back it up with the current timestamp.
    if [[ -f ~/${target_file} && ! -h ~/${target_file} ]]; then
        backup_file="${target_file}-backup-$(date +"%F_%T")"

        debug "Backing up $HOME/${target_file} to $HOME/${backup_file}"
        mv "$HOME/${target_file}" "$HOME/${backup_file}"
    fi

    # Symlink our version into place.
    debug "Symlinking $HOME/${target_file} => ${dotfiles_dir}/${source_file}"
    ln -sf "${dotfiles_dir}/${source_file}" "$HOME/${target_file}"
}

# Output helpers
debug() {
    if [[ $debug_mode -eq 1 ]]; then
        printf "${color_cyan}DEBUG: %s${color_reset}\n" "$1"
    fi
}

error() {
    printf "${color_red}[ERROR]${color_reset} %s\n" "$1"
}

step() {
    echo "$1"
}

warn() {
    printf "${color_yellow}[WARNING]${color_reset} %s\n" "$1"
}

# Parse arguments
while [ $# -gt 0 ]; do
    case "$1" in
        -d|--debug)
            debug_mode=1
            shift
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
         -u|--unattended)
            unattended=1
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Create an empty .config directory in the home directory.
mkdir -p ~/.config/git

# Install Oh My Zsh (if not already present)
if [ ! -d ~/.oh-my-zsh ]; then
    step 'Installing Oh My Zsh'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Symlink custom *.zsh files.
for file in $dotfiles_dir/oh-my-zsh/custom/*(.); do
    debug "Symlinking ~/.oh-my-zsh/custom/${file:a:t} => ${file}"
    ln -sf "$file" ~/.oh-my-zsh/custom/$file:a:t
done

# Replace ~/.zshrc with the version from this repository
safe-symlink oh-my-zsh/.zshrc .zshrc

# Clone external repos.
step 'Downloading third-party Oh My Zsh plugins'
if [ ! -d oh-my-zsh/custom/plugins/zsh-nvm ]; then
    debug 'https://github.com/lukechilds/zsh-nvm'
    git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
fi

# Prevent login messages by adding an empty .hushlogin file to the user's home directory.
debug 'Creating an empty ~/.hushlogin file'
touch ~/.hushlogin

# Custom git configuration.
step 'Applying Git configuration'
safe-symlink git/.gitconfig .gitconfig
safe-symlink git/ignore .config/git/ignore

# Composer configuration.
step 'Preparing Composer'
mkdir -p ~/.composer
safe-symlink composer/composer.json .composer/composer.json
safe-symlink composer/config.json .composer/config.json

if [[ $(command -v composer &> /dev/null) -eq 0 ]]; then
    composer install --working-dir ~/.composer
else
    warn 'Composer is not currently installed, unable to install global packages!'
fi

# Node configuration.
step 'Preparing NodeJS + npm'
safe-symlink npm/.npmrc .npmrc

# RubyGems configuration.
step 'Preparing RubyGems'
safe-symlink ruby/.gemrc .gemrc

# App preferences
step 'Applying application preferences'
safe-symlink "Preferences/Code/settings.json" "Library/Application Support/Code/User/settings.json"

# iTerm2 preferences: http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/
debug "Configuring iTerm2 to read preferences from ${dotfiles_dir}/Preferences/iTerm2"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${dotfiles_dir}/Preferences/iTerm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Custom sudo configuration
if [[ unattended -eq 0 ]]; then
    step 'Enabling password-less use of vagrant-hostsupdater'
    sudo cp -i "${dotfiles_dir}/etc/sudoers.d/vagrant_hostsupdater" /etc/sudoers.d/vagrant_hostsupdater \
        || error 'Unable to copy to /etc/sudoers.d/vagrant_hostsupdater'
else
    debug 'Skipping vagrant-hostsupdater config due to --unattended option'
fi

printf "\n${color_green}%s${color_reset}\n" 'Dotfiles have been installed successfully!'
