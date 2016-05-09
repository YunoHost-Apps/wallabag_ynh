<?php
/**
 * wallabag, self hostable application allowing you to not miss any content anymore
 *
 * @category   wallabag
 * @author     Nicolas Lœuillet <nicolas@loeuillet.org>
 * @copyright  2013
 * @license    http://www.wtfpl.net/ see COPYING file
 */

define ('SALT', '#DESKEY#'); # put a strong string here
define ('LANG', 'en_EN.utf8');

define ('STORAGE', 'mysql'); # postgres, mysql or sqlite

define ('STORAGE_SQLITE', ROOT . '/db/poche.sqlite'); # if you are using sqlite, where the database file is located

# only for postgres & mysql
define ('STORAGE_SERVER', 'localhost');
define ('STORAGE_DB', '#DBNAME#');
define ('STORAGE_USER', '#DBUSER#');
define ('STORAGE_PASSWORD', '#DBPASS#');

#################################################################################
# Do not trespass unless you know what you are doing
#################################################################################

// Change this if not using the standart port for SSL - i.e you server is behind sslh
define ('SSL_PORT', 443); 

define ('MODE_DEMO', FALSE);
define ('DEBUG_POCHE', FALSE);
define ('DOWNLOAD_PICTURES', TRUE);
define ('CONVERT_LINKS_FOOTNOTES', FALSE);
define ('REVERT_FORCED_PARAGRAPH_ELEMENTS', FALSE);
define ('SHARE_TWITTER', TRUE);
define ('SHARE_MAIL', TRUE);
define ('SHARE_SHAARLI', FALSE);
define ('SHAARLI_URL', 'http://myshaarliurl.com');
define ('FLATTR', TRUE);
define ('FLATTR_API', 'https://api.flattr.com/rest/v2/things/lookup/?url=');
define ('NOT_FLATTRABLE', '0');
define ('FLATTRABLE', '1');
define ('FLATTRED', '2');
define ('ABS_PATH', 'assets/');

define ('DEFAULT_THEME', 'baggy');

define ('THEME', ROOT . '/themes');
define ('LOCALE', ROOT . '/locale');
define ('CACHE', ROOT . '/cache');

define ('PAGINATION', '10');

//limit for download of articles during import
define ('IMPORT_LIMIT', 5);
//delay between downloads (in sec)
define ('IMPORT_DELAY', 5);

