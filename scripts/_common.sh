#
# Common variables
#

# Package dependencies
PKG_DEPENDENCIES="php5-cli php5-mysql php5-json php5-gd php5-tidy php5-curl php-gettext"

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

# Define and install dependencies with a equivs control file
# This helper can/should only be called once per app
#
# usage: ynh_install_app_dependencies dep [dep [...]]
# | arg: dep - the package name to install in dependence
ynh_install_app_dependencies () {
    dependencies=$@
    manifest_path="../manifest.json"
    if [ ! -e "$manifest_path" ]; then
    	manifest_path="../settings/manifest.json"	# Into the restore script, the manifest is not at the same place
    fi
    version=$(sudo python3 -c "import sys, json;print(json.load(open(\"$manifest_path\"))['version'])")	# Retrieve the version number in the manifest file.
    dep_app=${app//_/-}	# Replace all '_' by '-'

    if ynh_package_is_installed "${dep_app}-ynh-deps"; then
		echo "A package named ${dep_app}-ynh-deps is already installed" >&2
    else
        cat > ./${dep_app}-ynh-deps.control << EOF	# Make a control file for equivs-build
Section: misc
Priority: optional
Package: ${dep_app}-ynh-deps
Version: ${version}
Depends: ${dependencies// /, }
Architecture: all
Description: Fake package for ${app} (YunoHost app) dependencies
 This meta-package is only responsible of installing its dependencies.
EOF
        ynh_package_install_from_equivs ./${dep_app}-ynh-deps.control \
            || ynh_die "Unable to install dependencies"	# Install the fake package and its dependencies
        ynh_app_setting_set $app apt_dependencies $dependencies
    fi
}


# Remove fake package and its dependencies
#
# Dependencies will removed only if no other package need them.
#
# usage: ynh_remove_app_dependencies
ynh_remove_app_dependencies () {
    dep_app=${app//_/-}	# Replace all '_' by '-'
    ynh_package_autoremove ${dep_app}-ynh-deps	# Remove the fake package and its dependencies if they not still used.
}
