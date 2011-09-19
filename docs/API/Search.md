Search powered by Sphinx
========================

The `Search` class is a wrapper for SphinxClient. The class has a `__call` function that will pass all the unknown functions to the `SphinxClient` (@see `libs/Sphinx/sphinxapi.php`).

The installation of Sphinx is not covered here, just querying an existing Sphinx installation.

Implementation
--------------
Once you have your Sphinx up and running you need to include the Search class in your **model or controller**

First of all, in your model/controller add the class on runtime:

	class MySphinxclassModel extends Model
	{

	/**
	 * List of classes that will be included in first place.
	 */
	protected $include_classes = array( 'Search' );
	// ...

Once the class `Search` is included, to launch a search:

	// Returns the first 5 results. "page 1".
	Search::SetLimits(0, 5);

	// Only search posts in sub-forums 1, 3 and 7.
	Search::SetFilter('forum_id', array (1,3,7));
 
	// Sort found posts by posting date in descending order.
	Search::SetSortMode(SPH_SORT_ATTR_DESC, 'post_date');

	// Launch Sphinx search.
	Search::Query('test', 'main delta');

In order to properly understand how Sphinx and the PHP client works you should refer to the [Sphinx docs] [S].

[S]: http://sphinxsearch.com/docs/