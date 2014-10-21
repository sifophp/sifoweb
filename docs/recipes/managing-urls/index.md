Managing nice URLs with multiple parameters
===========================================
> SIFO comes with all the tools to manage URLs, construct URLs as well as parsing the different params. In this recipe we are only going to talk about how to parse and construct URLs with multiple parameters (filters, ordering, etc.).
 
Most of this features are managed using `\Sifo\Controller` methods.

Understanding the URL
------------------
The following URL will be used as example. This represents a list of wines in a wine store:

    http://www.vinetes/wines:o:cheap:p:20-50:y:2011

The by default solution proposed by SIFO consists in a series of key-value params sepparated by colon (`:`)

And this would be the meaning:

- `o:cheap` -> **Order** products using cheapest first
- `p:20-50` -> **Price** range between 20 and 50
- `y:2011` -> **Year** 2011 products only
 
  
How to Parse a URL
------------------

We can see in the example different pairs of key-values, being the **keys** `o`, `p`, `y`, and the **values** `cheap`, `20-50`, `2011` respectively.  
	
SIFO allows to parse URL with a specific pattern that you can define with the function: `getParamsDefinition`

This is an example in the Controller (using one of those parameters):

	protected function getParamsDefinition()
	{
		return array(
			'order' => array(
				'internal_key'      => 'o',
				'is_list'           => false,
				'apply_translation' => false,
				'accepted_values'   => array( 'cheapest', 'most-expensive' )
			)
		);
	}

In this function you are defining the **expected parameters**, the ones you are able to recognize in the URL. The above function would only recognize as parameters the two following URLs:

	/wines:o:cheapest
	/wines:o:most-expensive

When using multiple params SIFO will sort them alphabetically.
	
The other values defined in this function are:
    
* `is_list`: `boolean` value that defines if it's accepted a list of comma sepparated values. **Important**: when `is_list` is true, it will return always an array of values, even if there is a single parameter.
	
* `apply_translation`: `boolean` value that defines if SIFO must recognize the translated version of the value (E.g: `o:baratos` in Spanish site).
	
* `accepted_values`: `array` that includes the allowed values. (optional) 

If you want to get some param in the Controller you just need to call the getParam function, with the name of the param that you want (that's the key of the returned array in `getParamsDefinition()`).

An example:

	$order_by = getParam( 'order' );
	echo $order_by;						// 'cheapest'


How to Construct the URLs
-------------------------
Constructing URLs automatically, like a list of items it could become a hard, dangerous and difficult issue since we could duplicate URLs or present them with the parameters disordered and that would be bad for SEO.

For a safe and consistent generation of the URLs we can write this URLs using the Smarty's `genurl` (plugin written by Sifo itself).

### genurl

When we are using genurl to construct URLs dynamically we need to pass to the template all the information that is needed to create all the different URLs:

* `subject`: Base URL on which the parameters will be put.
* `params`: The params we need to construct the URL.
* `params_definition`: The parameter definition (set in controller) that we expect that contain the URL.

This is an example of `genurl` in the template:

    {genurl subject=$url.wines_list params=$parsed_params params_definition=$params_definition price=20-50 year=2011}

And after compiling generates this URL:

    http://www.vinetes.com/wines:p:20-50:y:2011

----------
Originally written by `Daniel Madurell` (minor changes by Albert Lombarte)