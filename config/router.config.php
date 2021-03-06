<?php

/**
 * Routes known by the application.
 *
 * The key of the array is the part of the URL that matches, and the value the controller used.
 *
 * Example:
 *
 * Given the address http://list.seoframework.local/blah
 * $config['list'] = 'list/index';
 * This tells that the subdomain list uses the ListIndexController
 *
 * $config['blah'] = 'blah/something'
 * This tells that the BlahSomethingController is used instead.
 *
 * If a subdomain matches a routing is used instead of any other part of the URL. With the given
 * example if the two routes were given, only the list/index would apply.
 *
 * The following values cannot be erased and are necessary for the proper working of the  framework,
 * although you can change their values:
 *
 * __NO_ROUTE_FOUND__
 * __HOME__
 * rebuild
 */
// ____________________________________________________________________________
// When the router doesn't know what to do with the URL, who is going to handle it?:
$config['__NO_ROUTE_FOUND__'] = 'static/markdown';

// Controller used when no path is passed (home page).
$config['__HOME__'] = 'home/index';

// Rebuild/regenerate the configuration files:
$config['rebuild'] = 'manager/rebuild';

// Used in debug mode Mail Interception.
$config['mail-continue'] = 'debug/mail';

// Sifo Debug
$config['sifo-debug-analyzer'] = 'debug/analyzer';
$config['sifo-debug-actions'] = 'debug/actions';