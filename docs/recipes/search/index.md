Setting up sphinx for PHP
=========================
> SIFO comes with all the tools to start working with Sphinx right away. Here's a quick guideline to get started.

Sifo comes with the Search libraries ready to start sending queries and a debug environment that gives you visibility on the queries you are launching to the server. You only need to tell the application where things are.


Application side
----------------
First thing to do is to tell the framework where the server will be running:

In your `sphinx.config.php` set the connection settings for the `default` profile (you can have many profiles, use any name you like). Needless to say these settings have to match the server configuration.

	$config['default'] = array(
		// Sets if sphinx is active or not.
		'active' => true,

		// Connection to Sphinx server.
		'server' => '127.0.0.1',
		'port' => 9401,
	);
	
### Searching code (quick & dirt)
Then you can start searching with a few lines of code.

Here is an example of function:

	public function getSearchResults( $query_string, $params )
	{
		$this->search_adapter = \Sifo\Search::getInstance( 'default' ); // This is the name of one of the profiles you have in sphinx.config

		$match_mode = SPH_MATCH_EXTENDED2; // Or SPH_MATCH_FULLSCAN for listings
		$index = 'your_index_name_goes_here';

		$results = array();


		try
		{
			$this->search_adapter->SetMatchMode( $match_mode );
			$this->search_adapter->SetLimits( 0, 50 );

			$this->search_adapter->SetSortMode( SPH_SORT_RELEVANCE );
			// $this->setFilters( $filters );
			$this->search_adapter->AddQuery( $query_string, $index );
			$results = $this->search_adapter->RunQueries();
		}
		catch ( \Exception $e )
		{
			throw new \Sifo\Exception_500( 'Error detected on search process: ' . $e->getMessage() );
		}

		return $results;
	}

Server side
-----------
The framework search won't work unless you have a sphinx server up. If you have never done such a thing is not that difficult. All you need to do is pretty much specifying the port on which the daemon will listen to, what is the query that indexes the content and raise the service. Let's get started!

### Create the sphinx configuration file

You need to create the configuration file, the following is an example that uses index inheritance. You cannot copy and paste this, every application needs its own values, try to understand it:

	source root
	{
	type			= mysql
	sql_host		= localhost
	sql_user		= root
	sql_pass		= YOURMYSQLPASSWORDHERE
	sql_db		 	= database_name
	sql_port		= 3306
	}

	# Common datasource. Used only to write common values accross different indexers.
	source src_common : root
	{
		sql_query_pre	= SET NAMES utf8
		sql_query_pre	= set group_concat_max_len = 8192

		sql_query_post		=
		sql_ranged_throttle	= 0
	}

	# Fake datasource, used in 'common' index. Not used.
	source src_fake : root
	{
		sql_query = SELECT 1 AS id, 'value' AS value, 0 AS some_date
		sql_attr_timestamp = some_date
	}

	source src_websearch : src_common
	{
		sql_query =                            \
			SELECT                             \
				*                              \
			FROM                               \
				my_content_table m             \
			WHERE                              \
				m.condition = 'blah blah'      \
				AND m.status = 'public'        \

		sql_attr_timestamp	= last_update

		sql_field_string = title

		sql_attr_uint = id_my_content_table
	}

	# source src_tags_tr : src_common
	#{
	#	sql_query = \
	#	SELECT \
	#		id_tag, \
	#		tag \
	#	FROM \
	#		tags \
	#	WHERE \
	#		tags.locale = 'tr_TR'
	#
	#	sql_field_string = tag
	#}

	# Just a collector of configuration for later inheritance. Does nothing.
	index index_common
	{
		# REPLACE IN CHILDREN:
		source = src_fake
		path			= /var/www/sphinx-2.0.4/data/common-web
		#------

		docinfo 		= extern
		mlock			= 0
		# morphology		= libstemmer_tr

		# stopwords		= /var/data/stopwords.txt
		# wordforms		= /var/data/wordforms.txt
		# exceptions	= /var/data/exceptions.txt

		min_word_len	= 3
		html_strip		= 1

		# min_prefix_len	= 0
		# min_infix_len		= 0
		# prefix_fields		= filename
		# infix_fields		= url, domain
		# enable_star		= 1

		charset_type	= utf-8
		# Configuration for almost all languages with "readable" characters, such as A,a,À,Á,Â,Ã,Ä,Å,à,á,â,ã,ä,å,Ā,ā,Ă,ă,Ą,ą
		# For other languages see: http://sphinxsearch.com/wiki/doku.php?id=charset_tables 
		charset_table 	= U+021, U+023, U+025, U+027, U+030..U+039, U+040..U+05a, U+07e, U+0b5, U+0c6, \
		U+0d0, U+0d8, U+0de, U+0df, U+110, U+126, U+132, U+138, U+13f, U+141, U+149, U+14a, \
		U+166, U+2019->U+027, U+061->U+041, U+0c0->U+041, U+0c1->U+041, U+0c2->U+041, \
		U+0c3->U+041, U+0c4->U+041, U+0c5->U+041, U+0e0->U+041, U+0e1->U+041, U+0e2->U+041, \
		U+0e3->U+041, U+0e4->U+041, U+0e5->U+041, U+100->U+041, U+101->U+041, U+102->U+041, \
		U+103->U+041, U+104->U+041, U+105->U+041, U+062->U+042, U+063->U+043, U+0c7->U+043, \
		U+0e7->U+043, U+106->U+043, U+107->U+043, U+108->U+043, U+109->U+043, U+10a->U+043, \
		U+10b->U+043, U+10c->U+043, U+10d->U+043, U+064->U+044, U+10e->U+044, U+10f->U+044, \
		U+065->U+045, U+0c8->U+045, U+0c9->U+045, U+0ca->U+045, U+0cb->U+045, U+0e8->U+045, \
		U+0e9->U+045, U+0ea->U+045, U+0eb->U+045, U+112->U+045, U+113->U+045, U+114->U+045, \
		U+115->U+045, U+116->U+045, U+117->U+045, U+118->U+045, U+119->U+045, U+11a->U+045, \
		U+11b->U+045, U+066->U+046, U+067->U+047, U+11c->U+047, U+11d->U+047, U+11e->U+047, \
		U+11f->U+047, U+120->U+047, U+121->U+047, U+122->U+047, U+123->U+047, U+068->U+048, \
		U+124->U+048, U+125->U+048, U+069->U+049, U+0cc->U+049, U+0cd->U+049, U+0ce->U+049, \
		U+0cf->U+049, U+0ec->U+049, U+0ed->U+049, U+0ee->U+049, U+0ef->U+049, U+128->U+049, \
		U+129->U+049, U+12a->U+049, U+12b->U+049, U+12c->U+049, U+12d->U+049, U+12e->U+049, \
		U+12f->U+049, U+130->U+049, U+131->U+049, U+06a->U+04a, U+134->U+04a, U+135->U+04a, \
		U+06b->U+04b, U+136->U+04b, U+137->U+04b, U+06c->U+04c, U+139->U+04c, U+13a->U+04c, \
		U+13b->U+04c, U+13c->U+04c, U+13d->U+04c, U+13e->U+04c, U+06d->U+04d, U+06e->U+04e, \
		U+0d1->U+04e, U+0f1->U+04e, U+143->U+04e, U+144->U+04e, U+145->U+04e, U+146->U+04e, \
		U+147->U+04e, U+148->U+04e, U+06f->U+04f, U+0d2->U+04f, U+0d3->U+04f, U+0d4->U+04f, \
		U+0d5->U+04f, U+0d6->U+04f, U+0f2->U+04f, U+0f3->U+04f, U+0f4->U+04f, U+0f5->U+04f, \
		U+0f6->U+04f, U+14c->U+04f, U+14d->U+04f, U+14e->U+04f, U+14f->U+04f, U+150->U+04f, \
		U+151->U+04f, U+070->U+050, U+071->U+051, U+072->U+052, U+154->U+052, U+155->U+052, \
		U+156->U+052, U+157->U+052, U+158->U+052, U+159->U+052, U+073->U+053, U+15a->U+053, \
		U+15b->U+053, U+15c->U+053, U+15d->U+053, U+15e->U+053, U+15f->U+053, U+160->U+053, \
		U+161->U+053, U+17f->U+053, U+074->U+054, U+162->U+054, U+163->U+054, U+164->U+054, \
		U+165->U+054, U+075->U+055, U+0d9->U+055, U+0da->U+055, U+0db->U+055, U+0dc->U+055, \
		U+0f9->U+055, U+0fa->U+055, U+0fb->U+055, U+0fc->U+055, U+168->U+055, U+169->U+055, \
		U+16a->U+055, U+16b->U+055, U+16c->U+055, U+16d->U+055, U+16e->U+055, U+16f->U+055, \
		U+170->U+055, U+171->U+055, U+172->U+055, U+173->U+055, U+076->U+056, U+077->U+057, \
		U+174->U+057, U+175->U+057, U+078->U+058, U+079->U+059, U+0dd->U+059, U+0fd->U+059, \
		U+0ff->U+059, U+176->U+059, U+177->U+059, U+178->U+059, U+07a->U+05a, U+179->U+05a, \
		U+17a->U+05a, U+17b->U+05a, U+17c->U+05a, U+17d->U+05a, U+17e->U+05a, U+0e6->U+0c6, \
		U+0f0->U+0d0, U+0f8->U+0d8, U+0fe->U+0de, U+111->U+110, U+127->U+126, U+133->U+132, \
		U+140->U+13f, U+142->U+141, U+14b->U+14a, U+153->U+152, U+167->U+166

	}

	index index_websearch : index_common
	{
		source 			= src_websearch
		path			= /var/www/sphinx-2.0.4/data/search-web
	}

	# Another index as example would go here:
	#index index_tags_tr : index_common
	#{
	#	source 			= src_tags_tr
	#	path			= /var/www/sphinx-2.0.4/data/tags-web
	#}

	indexer
	{
		mem_limit		= 64M
	}

	searchd
	{
		listen		= 9401

		log			= /var/www/sphinx-2.0.4/log/searchd-web.log
		query_log	= /var/www/sphinx-2.0.4/log/query-web.log
		pid_file	= /var/www/sphinx-2.0.4/run/searchd-web.pid

		# Specifies the default collation used for incoming requests
		collation_server = utf8_general_ci

		read_timeout		= 5
		client_timeout		= 300
		max_children		= 30

		max_matches			= 1000
		seamless_rotate		= 1
		preopen_indexes		= 1
		unlink_old			= 1
		mva_updates_pool	= 1M
		max_packet_size		= 8M
		max_filters			= 256
		max_filter_values	= 4096
		max_batch_queries	= 32

		workers				= fork
	}
	# --eof--
	

Then when the configuration file is created (let's say you name the file `websearch.conf`) you have to create the indexes, feed them and start the service.

We assume a paths like this:

	SPHINX_PATH=/your/path/to/sphinx/bin
	SPHINX_CONFIG=/path/to/websearch.conf

	
**Create the Sphinx index**

	${SPHINX_PATH}/indexer -c $SPHINX_CONFIG --all

**Rotate it (reindex)**

If you want to reindex again (launch the whole sql query) then you need to do this:

	${SPHINX_PATH}/indexer -c $SPHINX_CONFIG --all --rotate
	
Of course you can use deltas if the table is heavy

**Start the daemon**

	${SPHINX_PATH}/indexer -c $SPHINX_CONFIG --all --rotate

**Kill the service**

Well, not very fancy:

	killall searchd

