#
# Common variables
#

# Wallabag version
VERSION=1.9.2

# Wallabag git repository URL
WALLABAG_GIT_URL="https://github.com/wallabag/wallabag.git"

#
# Common helpers
#

# Source app helpers
source /usr/share/yunohost/helpers

# Execute a command as another user
# usage: exec_as USER COMMAND [ARG ...]
exec_as() {
  local USER=$1
  shift 1

  if [[ $USER = $(whoami) ]]; then
    eval $@
  else
    # use sudo twice to be root and be allowed to use another user
    sudo sudo -u "$USER" $@
  fi
}

# Execute a composer command from a given directory
# usage: composer_exec AS_USER WORKDIR COMMAND [ARG ...]
exec_composer() {
  local AS_USER=$1
  local WORKDIR=$2
  shift 2

  exec_as "$AS_USER" COMPOSER_HOME="${WORKDIR}/.composer" \
    php "${WORKDIR}/composer.phar" $@ \
      -d "${WORKDIR}" --quiet --no-interaction
}

# Fetch git repository and initialize Wallabag to the given directory
# usage: init_wallabag DESTDIR
init_wallabag() {
  local DESTDIR=$1

  # clone git repository
  git clone -q "$WALLABAG_GIT_URL" "$DESTDIR" \
    || ynh_die "Unable to fetch Wallabag sources"
  (cd "$DESTDIR" && git checkout -q "$VERSION") \
    || ynh_die "Unable to retrieve Wallabag version"

  # install composer
  curl -sS https://getcomposer.org/installer \
    | COMPOSER_HOME="${DESTDIR}/.composer" \
        php -- --quiet --install-dir="$DESTDIR" \
    || die "Unable to install Composer"
 
  # install dependencies
  exec_composer "$USER" "$DESTDIR" install --no-dev --prefer-dist
}
