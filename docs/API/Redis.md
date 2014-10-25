Working with Redis Key/Value store
==================================
The `RedisModel` allows you to use the Redis key-value storage system from the PHP environment. (see: http://redis.io). The class only handles the connection, the rest is delegated to the fabulous [Predis] library.

[Predis]: https://github.com/nrk/predis/

In order to get started ensure the connection settings are properly defined in the domains.config, or pass a specific array of settings.

Requirements
------------
To start using Redis you need to download the source code of the Predis library first. The code is ready to download, and Sifo includes
Predis as a submodule. Meaning that it is not in your hard disk if you don't really need it. To do it is as easy as populating the git submodule.

To do so, go to the root of the Sifo project and type in the terminal:

    git submodule init
    git submodule update

You only need to do this once. This two instructions will download all the source for you.

Setup
-----
To setup a new Redis database you only need to edit the `domains.config.php` file, which defines the **connection parameters**:

    $config['yourhost.com'] = array(
	    'devel' => true,
        'instance' => 'yourinstance',
        'language' => 'es_ES',
        ...
        'redis' => array(
                'host'     => '127.0.0.1',
                'port'     => 6379,
                'database' => 0 // Numer of Redis database. From 0 to 15, default: 0.

	        ),

Then anywhere include the RedisModel and connect:

	// Include the RedisModel first, e.g:

	$redis_model = new \Sifo\RedisModel();

	$redis = $redis_model->connect();


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

Multiple databases (profiles)
-----------------------------
The `domains.config.php` only defines a single database, as it happens with other engines like Mysql. If you need more
profiles for a single project, you can specify the multiple databases and ports in the file `redis.config.php`.
This file defines in the format `$config['profile_name']` all the profiles recognised by the app.

Then, when connecting you need to specify the profile you want to connect to. For instance,
in a project that has 2 different redis instances, one for tracking, and another as application database we could do this:

    // In redis.config.php:
    $config['application'] = array(
    	'host'     => '127.0.0.1',
    	'port'     => 6379,
    	'database' => 0
    );

    $config['tracking'] = array(
    	'host'     => '192.168.1.18',
    	'port'     => 6390,
    	'database' => 0
    );

In your models, you will need to specify the profile you want to `connect()` to:

    class TrackingVisitsModel extends \Sifo\RedisModel
    {
        public function trackThis( $tracking_data )
        {
            // Connect to the tracking profile:
            $redis = $this->connect( 'tracking' );

            // Operate...
            $redis->zincrby( $redis_key, 1, $area );
            // ...
         }

Still, you can use both redis configurations, the one at `domains.config.php` and the one at `redis.config.php`. Just have in
mind that when you don't specify a profile in the method `connect( $profile = null )` then connection settings are taken
from `domains.config.php` graphically:

 * `$redis = $this->connect()` uses `domains.config.php`
 * `$redis = $this->connect( 'something' )` uses `redis.config.php`, array key 'something'

Remember that you can change the redis database per domain (which is very helpful when having a single app in many languages),
so in most cases you will only need the domains.config.php setting.
