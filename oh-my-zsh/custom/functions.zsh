# Set the system volume (0-10, decimals are permitted)
function set-volume() {
  osascript -e "set Volume "$1""
}

# Configure an upstream remote for a forked GitHub repository.
# https://help.github.com/articles/configuring-a-remote-for-a-fork/
#
# USAGE:
#   set-upstream original-owner/original-repo
#
function set-upstream() {

  # See if there's already an "upstream" remote.
  if [ $# != 1 ]; then
    echo -e "\n\033[0;31mUnable to set upstream, as the original owner and repository are missing, unable to proceed!\033[0m\n"
    echo "Example usage:"
    echo -e "\t$ set-upstream original-owner/original-repo\n"
    return 1

  elif [ $(git remote -v | grep upstream -c) == 2 ]; then
    echo "Remote 'upstream' is already set."
    return
  fi

  git remote add upstream "https://github.com/$1.git"

  echo -e "\n\033[0;32mNew remote 'upstream' has been added:\033[0m"
  git remote -v
  echo
}

# Common system cleanup functions.
function system-cleanup() {
  composer clearcache
  docker system prune
  npm cache clean
  brew cleanup
}

# Extract a PHAR.
#
# USAGE:
#   extract-phar some-file.phar
#
function extract-phar() {
  PHAR=${1:?A PHAR file must be provided}

  php -r "try {
    \$phar = new Phar('${PHAR}');
    \$phar->extractTo('${PHAR}-extracted');
  } catch (Throwable \$e) {
    echo \$e->getMessage() . PHP_EOL;
    exit(\$e->getCode());
  }"
}
