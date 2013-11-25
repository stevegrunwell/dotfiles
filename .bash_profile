export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Load the shell dotfiles
for file in ~/.{exports,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file