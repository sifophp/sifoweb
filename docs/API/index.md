API: Programmer's Reference Guide
=================================
The framework is based in the Model View Controller design pattern. In the navigation there is the list of classes that are included with the SIFO library. Some of this classes are always preloaded by the bootsrap for every execution, you can see which of them are included by default in the file `config/libraries.config.php` of your instance. The rest of them must be included via getClass to use them.

When the Class you want to call has a constructor and can return an object use:

	$class_name_object = $this->getClass( 'ClassName' );
	
When you simply want to include the class without creating a new object or just because the class does not accept a construct (e.g: the ones using Singletons):

	$this->getClass( 'ClassName', false )

See the navigation for the list of classes. *Under construction*