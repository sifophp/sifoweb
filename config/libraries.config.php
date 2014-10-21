<?php
/**
 * The 'default' profile must always exist and contain any existing library.
 *
 * The rest of profiles EXTEND the default profile, so you only have to redeclare
 * the libraries that are different.
 */

/**
 * This classes will be loaded in this order and ALWAYS before starting.
 */
$config['classes_always_preloaded'] = array(
	'Exceptions',
	'Filter',
	'Domains',
	'Urls',
	'Router',
	'Controller',
	'View',
	'Cache',
);

// Contains all the libraries available.
$config['default'] = array(
	'smarty' => 'Smarty-3.1.4',
	'adodb' => 'adodb5',
);
