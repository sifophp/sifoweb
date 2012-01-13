Working with Redis Key/Value store
==================================
The `RedisModel` allows you to use the Redis key-value storage system from the PHP environment. (see: http://redis.io). The class only handles the connection, the rest is delegated to the favulous [Predis] library.

[Predis]: https://github.com/nrk/predis/

In order to get started ensure the connection settings are properly defined in the domains.config, or pass a specific array of settings.

Requirements
------------
To start using Redis you need to download the source code first. The code is ready to download, is as easy as populating the git submodule.
To do so:

    git submodule init
    git submodule update

This two instructions will download all the source for you.

How it works
------------

If in domains.config.php looks like:

	$config['yourhost.com'] = array(
	        'devel' => true,
	        'instance' => 'yourinstance',
	        'language' => 'es_ES',
	        ...
	        'database' => array(
	                'host'     => '127.0.0.1',
	                'port'     => 6379,
	                'database' => 0 // Numer of Redis database. From 0 to 15, default: 0.

	        ),
Then anywhere include the RedisModel an connect:

	// Include the RedisModel first, e.g:

	$redis_model = new \Sifo\RedisModel();

	$redis = $redis_model->connect(); // Takes connection settings from domains.config.php

	// or force the settings:
	$redis = $redis_model->connect( array(
	                'host'     => '127.0.0.1',
	                'port'     => 6379,
	                'database' => 0 // Numer of Redis database. From 0 to 15, default: 0.
	        ) );

Then Predis will use the [redis commands] as class methods. Some basic examples:

	// Increment a counter in one unit (e.g: track visits):
	$redis->incr( 'site_visits' );

	// Get the number of visits so far:
	echo $redis->get( 'site_visits' );

	// Increment it again:
	$redis->incr( 'site_visits' );
	echo $redis->get( 'site_visits' );

	// Delete the counter:
	$redis->del( 'site_visits' );

[redis commands]: http://redis.io/commands