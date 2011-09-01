Configuration files (class `Config`)
====================================

The configuration files always end with the `.config.php` extension and MUST contain inside a declared variable named `$config`. The location of this files is under `instances/yourinstance/config` folder.

The content of the file can be anything you want, just keep the `$config` variable. This variable will be returned when using Config within the application.

To retrieve a configuration file from the application you can do:

	Config::getInstance()->getConfig( 'myconfig' ) // Loads yourinstance/config/myconfig.config.php 

If you need to open the configuration file of another instance you can do

	Config::getInstance( 'name_of_other_instance' )->getConfig( 'file' );

A configuration sample
-------------------------
A configuration file could look like this:


	// File config/languages.config.php
	$config = array(
		'ar_AE' => array( 'dir' => 'rtl', 'domain' => 'ar', 'name' => 'Arabic', 'translated' => 'عربي' ),
		'bg_BG' => array( 'dir' => 'ltr', 'domain' => 'bg', 'name' => 'Bulgarian', 'translated' => 'български' ),
		'ca_ES' => array( 'dir' => 'ltr', 'domain' => 'ca', 'name' => 'Catalan', 'translated' => 'Català' ),
		'cz_CZ' => array( 'dir' => 'ltr', 'domain' => 'cz', 'name' => 'Czeck', 'translated' => 'Čeština' ),
		'de_DE' => array( 'dir' => 'ltr', 'domain' => 'de', 'name' => 'German', 'translated' => 'Deutsch' ),
		'en_US' => array( 'dir' => 'ltr', 'domain' => '', 'name' => 'English', 'translated' => 'English' ),
		'es_ES' => array( 'dir' => 'ltr', 'domain' => 'es', 'name' => 'Spanish', 'translated' => 'Español' ),
		'eu_ES' => array( 'dir' => 'ltr', 'domain' => 'eu', 'name' => 'Basque', 'translated' => 'Euskara' ),
		'fr_FR' => array( 'dir' => 'ltr', 'domain' => 'fr', 'name' => 'French', 'translated' => 'Français' ),
		'gl_ES' => array( 'dir' => 'ltr', 'domain' => 'gl', 'name' => 'Galician', 'translated' => 'Galego' ),
		'he_IL' => array( 'dir' => 'ltr', 'domain' => 'he', 'name' => 'Hebrew', 'translated' => 'עִבְרִית' ),
		'hi_IN' => array( 'dir' => 'ltr', 'domain' => 'he', 'name' => 'Hindi', 'translated' => 'हिन्दी' ),
		'it_IT' => array( 'dir' => 'ltr', 'domain' => 'it', 'name' => 'Italian', 'translated' => 'Italiano' ),
		'jp_JP' => array( 'dir' => 'ltr', 'domain' => 'jp', 'name' => 'Japanese', 'translated' => '日本語' ),
		'hu_HU' => array( 'dir' => 'ltr', 'domain' => 'hu', 'name' => 'Hungarian', 'translated' => 'Magyar' ),
		'nl_NL' => array( 'dir' => 'ltr', 'domain' => 'nl', 'name' => 'Dutch', 'translated' => 'Nederlands' ),
		'pl_PL' => array( 'dir' => 'ltr', 'domain' => 'pl', 'name' => 'Polish', 'translated' => 'Polski' ),
		'pt_BR' => array( 'dir' => 'ltr', 'domain' => 'pt', 'name' => 'Portuguese', 'translated' => 'Português' ),
		'ro_RO' => array( 'dir' => 'ltr', 'domain' => 'ro', 'name' => 'Romanian', 'translated' => 'Română' ),
		'ru_RU' => array( 'dir' => 'ltr', 'domain' => 'ru', 'name' => 'Russian', 'translated' => 'Русский' ),
		);
Some access samples:

	Config::getInstance()->getConfig( 'languages' );
	// Returns the whole previous array

	Config::getInstance()->getConfig( 'languages', 'ru_RU' );
	// Returns  array( 'dir' => 'ltr', 'domain' => 'ru', 'name' => 'Russian', 'translated' => 'Русский' )