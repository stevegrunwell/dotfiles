# Custom shell functions.

# Set up colors.
color_cyan="\033[0;36m"
color_green="\033[0;32m"
color_reset="\033[0;0m"
color_yellow="\033[0;33m"

# Set the system volume (0-10, decimals are permitted)
function set-volume() {
  osascript -e "set Volume "$1""
}

# Common system cleanup functions.
function system-cleanup() {
  printf "${color_cyan}%s${color_reset}\n" "Clearing Composer caches"
  composer clearcache

  printf "\n${color_cyan}%s${color_reset}\n" "Clearing npm caches"
  npm cache clean --force

  printf "\n${color_cyan}%s${color_reset}\n" "Pruning the docker system"
  if pgrep -q "com.docker.hyperkit"; then
    docker system prune -af --volumes
  else
    printf "${color_yellow}%s${color_reset}\n" "Docker is not currently running, skipping"
  fi

  printf "\n${color_cyan}%s${color_reset}\n" "Cleaning up old Vagrant boxes"
  vagrant box outdated --global
  vagrant box prune

  printf "\n${color_cyan}%s${color_reset}\n" "Cleaning up Homebrew"
  brew cleanup

  printf "\n${color_green}%s${color_reset}\n" "System cleanup has completed successfully!"
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
