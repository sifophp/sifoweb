Metadata
========
The Metadata of any site usually responds to patterns that are filled with variables. The `Metadata` class eases the interaction between your controllers and the final metadata output.

Your metadata patterns are stored under the files `config/lang/metadata_xx_XX.config.php` where `xx_XX` are the intended language and country of your audience (of course your application could use a single combination)

To set the metadata you'll need:

* Metadata patterns file
* Controllers setting the variables and picking the patterns.
* Grab the Metadata and assign it to your Head Controller

Working with Metadata
---------------------
Here you have a graphical example on how to use it:

### 1) Write the patterns in the configuration files ###
Let's say your application uses the locale (language) `en_US`, then open the file `yourInstance/config/lang/metadata_en_US.config.php` and define a key descriptive for the pattern you are setting. Example:

	$config['article_for_sale'] = array(
	        'title' => "Buy %name% - %section% at ACME Inc.",
	        'description' => "Buy %name%, %section%",
	        'keywords' => "Cheap %name%, bargains on %section%"
	);

The pattern is ready for being used by the controller.

To translate your metadata files to other languages all you have to do is create the files under `yourInstance/config/lang/` directory. For example: yourInstance/config/lang/metadata_es_ES.config.php

### 2) Set the metadata in the controller ###
Now we are in the articles controller and we'd like to pick up the "article_for_sale" pattern and fill it with the current article. In the controller we place:

	use \Sifo\Metadata as Metadata;
	// ...

	Metadata::setKey( 'article_for_sale' );
	Metadata::setValues( 'name', 'Monkey Wrench' );
	Metadata::setValues( 'section', 'Do it yourself tools' );

The association has been made and ready to use, the internal values are:

	$config['article_for_sale'] = array(
	        'title' => "Buy Monkey Wrench - Do it yourself tools at ACME Inc.",
	        'description' => "Buy Monkey Wrench, Do it yourself tools",
	        'keywords' => "Cheap Monkey Wrench, bargains on Do it yourself tools"
	);

### 3) Execute the controller rendering the metadata ###
It is time to display the metadata. There is a controller under the `default` instance that you can use for this purpose: `shared/head.ctrl.php`. Use it or not, to pass all the metadata to the template all you have to do is:

	$this->assign( 'metadata', Metadata::get() );
	
### 4) Create the HTML tags defining the metadata ###	
In the template (e.g: head.tpl) use the variables you just assigned in the controller:

	<meta name="title" content="{$metadata.title}" />
	<meta name="description" content="{$metadata.description}" />
	<meta name="keywords" content="{$metadata.keywords}" />