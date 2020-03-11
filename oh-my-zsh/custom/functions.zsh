# Set the system volume (0-10, decimals are permitted)
function set-volume() {
  osascript -e "set Volume "$1""
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
