#!/usr/bin/env zsh

# The directory this script lives in.
DOTFILES_DIR=$0:a:h

# Symlink a local file into the user's home directory, making a backup if the original
# is a regular file.
#
# Usage:
#     safe-symlink <source_file> <target_file>
#
safe-symlink() {
    SOURCE_FILE=${1:?Invalid source file}
    TARGET_FILE=${2:?Invalid target file}

    # If a real file exists, back it up with the current timestamp.
    if [[ -f ~/${TARGET_FILE} && ! -h ~/${TARGET_FILE} ]]; then
        mv ~/${TARGET_FILE} ~/"${TARGET_FILE}-backup-$(date +"%F_%T")"
    fi

    # Symlink our version into place.
    ln -sf "${DOTFILES_DIR}/${SOURCE_FILE}" ~/${TARGET_FILE}
}

# Clone external repos
git clone https://github.com/lukechilds/zsh-nvm oh-my-zsh/custom/plugins/zsh-nvm

# Replace ~/.zshrc with the version from this repository
safe-symlink oh-my-zsh/.zshrc .zshrc

# Prevent login messages by adding an empty .hushlogin file to the user's home directory.
touch ~/.hushlogin

# Load the .gitconfig file from the dotfiles.
safe-symlink git/.gitconfig .gitconfig

# Composer configuration
mkdir -p ~/.composer
safe-symlink composer/composer.json .composer/composer.json
safe-symlink composer/composer.lock .composer/composer.lock
safe-symlink composer/config.json .composer/config.json

# Node configuration
safe-symlink npm/.npmrc .npmrc

# RubyGems configuration
safe-symlink ruby/.gemrc .gemrc

# Symlink the ~/.config directory
safe-symlink config .config

# App preferences
safe-symlink "Preferences/Code/settings.json" "Library/Application Support/Code/User/settings.json"

# iTerm2 preferences: http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${DOTFILES_DIR}/Preferences/iTerm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Custom sudo configuration
sudo cp -n "${DOTFILES_DIR}/etc/sudoers.d/vagrant_hostsupdater" /etc/sudoers.d/vagrant_hostsupdater \
    || echo 'Unable to copy to /etc/sudoers.d/vagrant_hostsupdater'

echo "Dotfiles have been installed successfully!"
