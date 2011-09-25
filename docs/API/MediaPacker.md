MediaPacker
===========
The `MediaPacker` class is an utility to **merge several CSS or JS files into single files**. Through the configuration files you define how you'd like to group the files. It is thought to run with the **Core-js library** alltogether.

The concept is very simple: Any site usually has several JS or CSS files that are included in the HTML code one by one. Be for better management or modularization, or because you load external tools, the thing is very negative for the page load performance to call one by one all these files. If there is a bunch of file that you want to load always together (e.g: My own JS code doesn't work without jquery and analytics) you create a group and **load all this files together merged in a single file**. The group definition goes on your own, try to find a balance between what is usually loaded always and the most successful combinations. The things you rarely use should be called asynchronously when needed.

Example, you have a code like:

	<script type="text/javascript" src="/js/jquery.js" />
	<script type="text/javascript" src="/js/mysite.js" />
	<script type="text/javascript" src="/js/ga.js" />

The `MediaPacker` helps you to automatically convert this 3 files in a single file with the same content, so you only need something like:

	<script type="text/javascript" src="/js/generated/my-site-basics.js" />

In this specific example, all the clients accessing your site would start doing a single HTTP request instead of three. Result: **page loads faster**

Packing JS files
----------------
To start packing JS files you need basically to:

 * Create the folder under your instance: `public/static/js/generated`
 * Edit your `js.config.php` file (you should put a copy in your instance and `rebuild`) and define the groups.
 * Add the packing code somewhere in your code **when in development**

Code:

	// On development create all the packed files on the fly:
	if ( Domains::getInstance()->getDevMode() )
	{
		$this->getClass( 'MediaPacker', false );
		$packer = new JsPacker();
		$packer->packMedia();
		// $packer = new CssPacker();
		// $packer->packMedia();
	}	
	
This is already working in the `default` instance. You can have a look at the file `controllers/shared/head.ctrl.php`, function `assignMedia()`. It is very handy to have this code in development time, but you can also pack your files with a script.

**IMPORTANT**: If you create your own packing functions ensure the files are only packed and merged in the development environment, so there is no performance effect on production.

### JS groups: Understanding the `js.config.php` file###
Let's start with a piece of the `js.config.php` file to get you started:

	$config['default'] = array(
		10 => array(
			'name' => 'jquery',
			'filename' => 'libs/Core-js/libs/jquery/jquery-1.6.4.min.js',
		),
		20 => array(
			'name' => 'labs',
			'filename' => 'libs/Core-js/libs/labjs/LAB.js',
		),
		30 => array(
			'name' => 'namespace',
			'filename' => 'libs/Core-js/core/namespace.js',
		),
		40 => array(
			'name' => 'utilities_common',
			'filename' => 'libs/Core-js/core/utilities.js',
		),
		50 => array(
			'name' => 'page_behaviours',
			'filename' => 'libs/Core-js/core/page-behaviours.js',
		),
		1000 => array(
			'name' => 'init',
			'filename' => 'libs/Core-js/core/init.js',
		)
	);

The array key (`default` in the example) is the name of the group. To create more groups create another block like this one with a different name. This example will create a file under `/js/generated/default.js`

**The numbers** represent the **priority** on merge time. The lower the number is, the sooner the JS file will appear in the final merged file.

The **name** attribute is just an alias to help you understand the final file when you open it.

The **filename** field is the relative path to the file, starting from the SIFO folder installation.

### Special notes for the `default` array ###
If the group file is named `default` the `MediaPacker` will preppend at the beginning of the file a javascript array with all the paths of the other groups. With this you will be able to load from Javascript the rest of packed groups. Like this one:

	sHostStatic = window.sHostStatic ? window.sHostStatic : "http://static.yoursite.local";
	Hash = window.Hash ? window.Hash : "unset";
	var basePathConfig = {
		'default': sHostStatic + '/js/generated/default.js?rev=' + Hash,
		'graphs': sHostStatic + '/js/generated/graphs.js?rev=' + Hash,
		'modal': sHostStatic + '/js/generated/modal.js?rev=' + Hash,
		// ...
	};

This means that in your site HEAD template you should have a couple of variables set that will help automatically load the rest of javascripts. In smarty is as easy as:

	<script type="text/javascript">
		var Hash = "{$url.static_rev}"
		var sHostStatic = "{$url.static}";
	</script>
	
Packing CSS files
-----------------
The CSS files use the same concept, although it's a little bit more simple.

 * Create the folder under your instance: `public/static/css/generated`
 * Edit your `css.config.php` file (you should put a copy in your instance and `rebuild`) and define the groups and media.
 * Add the packing code somewhere in your code **when in development**

Code:

	// On development create all the packed files on the fly:
	if ( Domains::getInstance()->getDevMode() )
	{
		$this->getClass( 'MediaPacker', false );
		// $packer = new JsPacker();
		// $packer->packMedia();
		$packer = new CssPacker();
		$packer->packMedia();
	}	

### Understanding the `css.config.php` file###
The file looks like this:

	$config['default'] = array(
		'media' => 'screen',
		'files' => array(
			'instances/myinstance/public/static/css/layout.css'
			'instances/myinstance/public/static/css/main.css'
			'instances/myinstance/public/static/css/colors.css'
		)
	);

	$config['print'] = array(
		'media' => 'print',
		'files' => array(
			'instances/myinstance/public/static/css/print.css'
		)
	);
	
 * #1# The *array key* (`default` or `print` in the example) is the name of the final CSS group file.
 * #2# The `media` attributes, usually `screen` or `print` is the media HTML attribute in the link
 * #3# Under `files` write the path to all the CSS files that will be merged in the final file. In the exact order.

Sample:

	<link rel="stylesheet" type="text/css" media="#2#" href="{$url.static}/css/generated/#1#.css" />
