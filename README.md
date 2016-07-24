Wallabag v1 for Yunohost
------------------------

**Shipped version:** 1.9.2

[Wallabag](https://www.wallabag.org/) is a self hostable application allowing
you to not miss any content anymore. Click, save, read it when you can. It
extracts content so that you can read it when you have time.

Note: Wallabag 1.x versions are no longer developed, has the project went to 2.x version.

## Limitation

This application does not connect to the LDAP, which is needed to retrieve
users information - such as the password. One consequence is that you will
not be able to use third-party applications which are not Web browser add-on -
i.e. the Android application. Conversely, the add-ons for Firefox and Chrome
will work as long as you're connected to the SSO.

## Future...

The new version 2 of Wallabag with many new features is out!
As the upgrade from v1 to v2 need a manual intervention - see the
[migration guide](http://doc.wallabag.org/en/master/user/migration.html),
a new YunoHost package has been made for it. You should consider to use it for
all new installations. For more information, please refer to it
[here](https://github.com/YunoHost-Apps/wallabag2_ynh).

## Links

 * Report a bug: https://dev.yunohost.org/projects/apps/issues
 * Wallabag website: https://www.wallabag.org/
 * YunoHost website: https://yunohost.org/
 * YunoHost package for Wallabag v2: https://github.com/YunoHost-Apps/wallabag2_ynh
