Cache
=========================


Cache management is used to be problematic for developers. SIFO only need that you include this method in your controller with a 'name' and 'expiration' fields ans extra fields that you can use and he will manage the cache of this controller automatically.


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
            'name'             => get_class($this),
            'list_id'          => $params['path_parts'][0],
            'page'             => $params['page'],
            'global_page_type' => 'list',
            'current_url'      => $this->getParam('current_url'),
            'expiration'       => 60 * 60 * 2,                     // 2 hours.
        );
    
       return $cache_key;
    }


Flush Cache: 
------------------


You can do it by the definition initial or by a tag name that has defined before:


    $cache = \Sifo\Cache::getInstance();

    $cache->deleteCache($cache_definition);

    $cache->deleteCacheByTag($cache_tag, $cache_value));