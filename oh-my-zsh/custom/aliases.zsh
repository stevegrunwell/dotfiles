# Easier navigation
alias ..="cd ../"
alias ..2="cd ../../"
alias ..3="cd ../../../"

# Shortcuts
alias brew-edit="cd $(brew --repo homebrew/core)"
alias dotfiles="cd ${0:a:h}/../../"
alias dropbox="cd ~/Dropbox"

# Enable aliases to be sudo’ed
alias sudo="sudo "

# Enhanced WHOIS lookups
#alias whois="whois -h whois-servers.net"

# Show/hide hidden files in Finder
alias showhidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# If I try to use the 'artisan' command assume I'm calling `php artisan` on the current directory
alias artisan="php ./artisan"

# Hosts file
alias hosts="sudo vi /etc/hosts"

# Open the iOS Emulator from the Xcode package
alias iphone="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"

# Spotify
alias spotify="osascript /usr/local/spotify-control/SpotifyControl.scpt"

# Look for surrounding networks via the Airport Utility
#
# http://osxdaily.com/2012/02/28/find-scan-wireless-networks-from-the-command-line-in-mac-os-x/
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

# Open up Apache, but run it in the foreground.
alias local-apache="sudo /usr/sbin/httpd -DFOREGROUND"

# Recursively delete .DS_Store files
#
# http://osxdaily.com/2012/07/05/delete-all-ds-store-files-from-mac-os-x/
alias delete-ds-store="find . -name ".DS_Store" -depth -exec rm {} \;"

# Flatten all sub-directories of the current directory
#
# http://osxdaily.com/2015/02/11/flatten-nested-directory-structure-command-line/
alias flatten-directory="find . -mindepth 2 -type f -exec mv -i '{}' . \;"

# Delete empty directories
#
# https://www.cyberciti.biz/faq/howto-find-delete-empty-directories-files-in-unix-linux/
alias delete-empty-dirs="find . -empty -type d -delete"

# Old versions of PHP for testing.
alias php56="docker run --rm -it --name=php-5.6 -v "$PWD":/usr/src/app -w /usr/src/app php:5.6-alpine php"
alias php70="docker run --rm -it --name=php-7.0 -v "$PWD":/usr/src/app -w /usr/src/app php:7.0-alpine php"
alias php71="docker run --rm -it --name=php-7.1 -v "$PWD":/usr/src/app -w /usr/src/app php:7.1-alpine php"
alias php72="docker run --rm -it --name=php-7.2 -v "$PWD":/usr/src/app -w /usr/src/app php:7.2-alpine php"
alias php73="docker run --rm -it --name=php-7.3 -v "$PWD":/usr/src/app -w /usr/src/app php:7.3-alpine php"
alias php74="docker run --rm -it --name=php-7.4 -v "$PWD":/usr/src/app -w /usr/src/app php:7.4-alpine php"
alias php80="docker run --rm -it --name=php-8.0 -v "$PWD":/usr/src/app -w /usr/src/app php:8.0-alpine php"

# SSH into a server, but force password-based authentication
alias ssh-passsword-only="ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no"
