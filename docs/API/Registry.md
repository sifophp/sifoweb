Registry
=========================

SIFO has this very interesting funcionality, basically save a query asked to the Model and if it has the same query again it doesn't need to ask to the model again and return the same result. This is very useful to decrease our time to load the web page.

For this purpose we need a registry key for every query that we save, so we can load the registry key, and if it doesn't exist we have to ask to the Model, this is an example into a Model:

        
	$registry_key = "goal_" . $id_goal;
	if ( \Sifo\Registry::keyExists( $registry_key ) )
	{
	        return \Sifo\Registry::get( $registry_key );
	}

	$result = $this->GetOne( 'SELECT goal from goals where id_goal=?', array( $id_goal ) );

	//Store query for the same petition
	\Sifo\Registry::getInstance()->set( $registry_key, $result );

	return $result;


Invalidating Registry
---------------------------------

But in some rare situations we will need that the query is thrown again against the model (updates, ...) then we need to aplicate a policy of invalidation of the Registry:

    \Sifo\Registry::getInstance()->invalidate( $registry_key );


From this moment, this registry key is invalidated, and the Controller must ask to the Model again.