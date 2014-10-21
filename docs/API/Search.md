Search powered by Sphinx
========================

The `Search` class is a an extension of the original `SphinxClient` published by the Sphinx project (@see `vendor/sifophp/sifo/src/Sphinx/sphinxapi.php`).

Back in 2010 we did test Solr and Lucene as well, but we liked the most Sphinx, which has been performing awesome for the past years. This is why Search for us is a synonym of Sphinx :)

The installation of Sphinx is not covered here, just querying an existing Sphinx installation.

Implementation
--------------
Once you have your Sphinx up and running you need to include the Search class in your **model or controller**

First of all, in your model/controller add the class on runtime:

	use \Sifo\Search as Search;

	class MySphinxclassModel extends Model
	{

	// ...

Then in order to launch a search, this is an example:

	// Returns the first 5 results, let's say we want the "page 1".
	Search::SetLimits( 0, 5 );

	// Only search posts in forums with ID 1, 3 and 7.
	Search::SetFilter( 'forum_id', array ( 1, 3, 7 ) );
 
	// Sort posts found by date, in descending order.
	Search::SetSortMode( SPH_SORT_ATTR_DESC, 'post_date' );

	// Launch Sphinx search.
	Search::Query( '@(title,content) abracadabra', 'main delta' );

In order to properly understand how Sphinx and the PHP client works you should refer to the [Sphinx docs] [S].

[S]: http://sphinxsearch.com/docs/