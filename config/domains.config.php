<?php
$config['redirections'] = array(
	array( 'from' => 'www.sifo.me', 'to' => 'http://sifo.me' ),
	array( 'from' => 'www.sifo-web.local', 'to' => 'http://sifo-web.local' )
);

$config['core_inheritance'] = array( 'Sifo' );
// Define the inheritance of this instance (which instances are their parents:
$config['instance_inheritance'] = array( 'common', 'sifoweb' );

$config['sifo.me'] = array(
	'devel' => false,
	'instance' => 'sifoweb',
	'language' => 'en_US',
	'language_domain' =>'messages',
	'lang_in_subdomain' => false,
	'www_as_subdomain' => false,
	'static_host' => 'http://static.sifo.me',
	// 'media_host' => 'http://static.sifo.local', // Alternative static content (media). Comment to disable.
	/*
	'database' => array(
		// 'profile' => 'PRODUCTION' // Use this option for MASTER/SLAVE configurations and fill db_profiles.config.php with credentials.
		'db_driver' => 'mysqli', // For use transactions you must use mysqli driver.
		'db_host' => '127.0.0.1',
		'db_user' => 'root',
		'db_password' => 'root',
		'db_name' => 'no database needed',
		'db_init_commands' => array( 'SET NAMES utf8' )
	),
	REDIS syntax:
	'database' => array(
		'database' => array(
		'host'     => '127.0.0.1',
		'port'     => 6379,
		'database' => 0
	),
	 */
	'php_ini_sets' => array( // Empty array if don't want changes.
		// Log errors to 'logs' folder:
		'log_errors' => 'On',
		'error_log' => ROOT_PATH . '/logs/sifoweb_errors.log',
	),
	//'libraries_profile' => 'bleeding_edge'
);

$config['sifo-web.local'] = $config['sifo.me'];
$config['sifo-web.local']['devel'] = true;
$config['sifo-web.local']['static_host'] = 'http://static.sifo-web.local';
