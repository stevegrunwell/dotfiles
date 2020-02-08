# Easier navigation
alias ..="cd ../"
alias ..2="cd ../../"
alias ..3="cd ../../../"

# Shortcuts
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
