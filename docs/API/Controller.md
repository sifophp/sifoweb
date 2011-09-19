Controller
==========
Not all methods are explained here in detail. This is a quick overview, the classes are comented itself. You can use phpDocumentor if you want over the whole project if you feel more confortable with it.

Creating your Controller
------------------------
To create a controller create or pick a folder inside the `controllers` folder an put a file with the extension `.ctrl.php`. To make the system recognise the just created file (this applies to any model, class or template as well) you have to **rebuild** the configuration.

If your just created file is `myinstance/controllers/myfolder/mycontroller.ctrl.php` then the class has to be named `MyfolderMycontrollerMyinstanceController`.

Then you need to implement the `build()` method, and at least call the `setLayout( $template )` function defining the smarty template that will be taken to display the output.

So far, the controller would look like this:

	<?php
	
	class MyfolderMycontrollerMyinstanceController extends Controller
	{
		public function build()
		{
			$this->setLayout( 'home/index.tpl' );
		}
	}

With this file you would be able to render the `templates/home/index.tpl` file.

### Ajax controllers ###
It is common to create a controller that returns JSON output as part of an AJAX response. When doing so, the Controller instead of setting a layout (`setLayout()`) all you need is to return the desired data in the build() method and will be automatically json encoded and headers set.

This distinction between HTML output and JSON response is set by the attribute `protected $is_json = true`. When you set the `$this->is_json` to true, the return of your build method will be automatically json_encoded and the headers will be set for application/json.

### Retrieveing parameters ###
To retrieve the current parameters (such as the current path) you can use the `getParams()` function. This parameters can be also seen in the debug.

Function `getUrlParam( $number )` returns **ONLY** the parameters additional that aren't ment to resolve the controller. Think that part of the path can be used just to map the URL with a specific controller.

For instance, for http://yourdomain.com/user/John:profile, if "user" resolves the controller (maps URL->controller), then in the getUrlParam( 0 ) there is the word "profile". The John parameter can be extracted via getParams()

### Cookies ###
To get cookies you only have to use `$this->getCookie( $cookie_name )`.

### Pass values to the template ###
Pass values to your templates using the `assign( $tpl_var, $value )` function. Example:
	
	$this->assign( 'user', array( 'name' => 'John', 'age' => 35 ) );

Then in your template (Smarty) access the values like this:

	{$user.name} is {$user.age} old

### Caching the output ###
Since it is not cheap to calculate a page when you have a certain volume of visits, there is a way to define the cache keys. Every key must be unique and has to match only when for an input is expected always the same output.

IMPORTANT: When a POST is sent to the controller, the cache is automatically invalidated to allow the build to be entirely processed.

#### Cache definition ###
Every controller has the possibility to define its own cache space via the `getCacheDefinition` function. This function is an array with keys=>values of all the possible variants of the page.

If you don't want cache you can delete the entire function from your extended controller, or just make it return false. 

If you want caching, then 2 possible returns are possible:

* A single string with the cache key (default expiration)
* An array with all the variations. There are 2 special items: **name** and **expiration**

	public function getCacheDefinition()
	{
	        return array( 'name' => 'my_key', 'expiration' => 14400 ); // Time in seconds.
	}

### Deleting cache ###
If you don't want to wait until the cache expires the controller can force the cache deletion. The `deleteCache( $key )` function does that. Depending on how you set the cache, you will have to delete it accordingly (pass an array or a mere string)

### Compile a template into a variable ###
Sometimes you need some piece of HTML code processed by the template and set to a variable (imagine an application that loops users and sends a custom email per user). Then you can use the `fetch` function.

	$body = $this->fetch( 'email/confirmation.tpl' );
	Mail::send( $email, $subject, $body ) );
	
### Translations in Controller ###
Is not always possible to translate everything in the template. When you need to do this in a controller you can use:

	$this->translate( $message, [$var1], [$var2],...[$var_n] )

Translates a string and places the variables in the order of insertion. You can pass as many variables as you need (or none). The translations must have the identifiers %1, %2, %3 etc... to place the content. For instance:

	$this->translate( 'Hello %1, welcome to %2', 'John', 'SIFO' );
	
This code would output *Hello John, welcome to SIFO*. This is useful when the controller sets a message, but your template is already capable of doing this via:

	{t 1='John' 2='SIFO'}Hello %1, welcome to %2{/t}
	
The most common use of the translations in the controller context is for setting a FlashMessage after a successful or invalid operation. For example:

	FlashMessages::set( $this->translate(
		'Error while updating %1.', $email ),
		FlashMessages::MSG_KO
	);  // K.O. message
	FlashMessages::set( $this->translate(
		'Sucessfully updated %1.', $email ),
		FlashMessages::MSG_OK
	);  // Success. message

### Redispatch: An ugly hack ###	
`$this->reDispatch( $controller )`

Stop the execution of the current controller and dispatch the controller passed in the $controller variable using the format folder/controller. E.g:.

	$this->reDispatch( 'home/index' );

It is an ugly hack because you start over again with a new Controller and the memory is full with the previous execution. A good programmer would never use it :)

### Before and after executing your controller###
The methods `preDispatch()` and `postDispatch()` are called before and after the dispatch of the controller.

`$this->preDispatch();`
Include this function in your code to execute code even **before the cache of the controller** is queried and right before the dispatch is executed.

`$this->postDispatch();`
Include this function in your code to execute code after the controller has been finished (or fetched from cache) but right before the content is sent to the browser.
