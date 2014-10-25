Cache
=========================


Cache management is usually problematic for developers, but with SIFO we tried to make it simple and you only need to include a method named `getCacheDefinition` in your controller returning an array with at least the `name` and `expiration`. You can return in the array any other keys that represent the variants of the page that make the controller behave differently.


Create controller cache
------------------


Assigning cache to a Controller:


    /**
     * Returns the cache definition of this controller.
     *
     * A string with the cache key can be returned or an array with 'name' and 'expiration' (both mandatory).
     *
     * @return string|array|false
     */
    public function getCacheDefinition()
    {
        $params = $this->getParams();
    
        $cache_key = array(
            'name'              => get_class($this),
            'list_id'           => $params['path_parts'][0],
            'page'              => $params['page'],
            'page_type'         => 'list',
            'expiration'        => 60 * 60 * 2,                     // 2 hours expressed in seconds.
        );
    
       return $cache_key;
    }

Note that in this example we are adding variants for this controller, being `list_id`, `page` and `page_type`. This means that whenever one of this parameters is different a new cache entry will be saved/retrieved. The more variants your controller has, the less chances to have a `hit` and less performance for your application.

Flush Cache: 
------------------

At certain events you might want to delete the existing cache. To invalidate the cache and force the generation of new content before the declared expiration you can proceed in two different ways:

- By deleting the specific cache entry
- By deleting a `cache tag` that groups a lot of different cache definitions.
 
The `cache tags` are defined in the `cache.config.php` file. When you have a tag declared in the config, every time a controller returns in the `getCacheDefinition()` an array key containing the declared name, then it's grouped in the tag. By deleting the tag you are actually invalidating all cache keys under that umbrella. Use this wisely.

**To delete a single cache entry**:

    $cache = \Sifo\Cache::getInstance();
    $cache->deleteCache($cache_definition);

Note the `$cache_definition` contains the array of the function `getCacheDefinition()` with the desired values (expiration will be ignored)

**To delete all cache entries matching a tag**
    
    $cache = \Sifo\Cache::getInstance();
    $cache->deleteCacheByTag($cache_tag, $cache_value);
    
    // Real example: Delete all the cache entries related with id_user=1234
    $cache->deleteCacheByTag( 'id_user', 1234 );
