# Set the system volume (0-10, decimals are permitted)
function set-volume() {
  osascript -e "set Volume "$1""
}

# Common system cleanup functions.
function system-cleanup() {
  echo -e "\033[0;36mClearing Composer caches\033[0;0m"
  composer clearcache
  echo

  echo -e "\033[0;36mClearing npm caches\033[0;0m"
  npm cache clean --force
  echo

  echo -e "\033[0;36mPruning the Docker system\033[0;0m"
  if pgrep -q "com.docker.supe"; then
    docker system prune -af --volumes
  else
    echo -e "\033[0;33mDocker is not currently running, skipping"
  fi
  echo

  echo -e "\033[0;36mCleaning up old Vagrant boxes\033[0;0m"
  vagrant box outdated --global
  vagrant box prune
  echo

  echo -e "\033[0;36mCleaning up Homebrew\033[0;0m"
  brew cleanup
  echo

  echo -e "\033[0;32mSystem cleanup has completed successfully!\\033[0;0m"
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
