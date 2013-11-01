#! /bin/sh

PWD=`pwd`

# Create symlinks in ~/ for each of the recognized dotfiles
for dotfile in .{aliases,bash_profile,exports,extra,functions,gitconfig,gitignore,hushlogin}; do
  [ -r "$dotfile" ] && [ -f "$dotfile" ]
  ln -s "$PWD/$dotfile" ~/$dotfile
done
unset dotfile
unset PWD

source ~/.bash_profile