Domains
=======
The `Domains` class is surely the most important file in the framework. It has several functions and in conjunction with the configuration file `config/domains.config.php` defines a lot of settings of your application. This file defines the domain, database configuration, known languages, the static files host, if the debug is enabled and other parameters for every possible listening domain.

Checks that a given URL is inside a known domain and depending on the domain makes the whole framework to behave in a specific way. Here is a sample of the configuration file:

	<?php
	Syntax of the domains:

	        $config['domain.com'] = array(
	        'devel' => true,
	        'instance' => 'default',
	        'auth' => 'user,password',  // Apache auth required.
	        'lang_in_subdomain' => true, // Language in subdomain, e.g: fr.subdomain.com
	        'www_as_subdomain' => true, // "www" as the default subdomain.
	        'language' => 'es_ES', // Language by default, e.g. Spanish
	        'language_domain' =>'messages' // File containing the translations,
	        'static_host' => 'http://static.seoframework.local',
	        'media_host' => 'http://media.seoframework.local', // Avatars and other media
	        'database' => array(
	                'db_driver' => 'mysql',
	                'db_host' => '127.0.0.1',
	                'db_user' => 'root',
	                'db_password' => 'root',
	                'db_name' => 'mydatabase',
	                'db_init_commands' => array( 'SET NAMES utf8' )
	                )
	        );

Based on this configuration file, the class offers several methods that give you Domain based information such as:

* `\Sifo\Domains::getDomain()`
* `\Sifo\Domains::getSubDomain()`
* `\Sifo\Domains::getDevMode()` To know if the instance you are working is in development mode.
* `\Sifo\Domains::getLanguage()` The language of this domain.
* ... See the class for the rest of methods.