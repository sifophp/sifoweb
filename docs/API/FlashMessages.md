FlashMessages
=============
A flash message is a phrase you set in the controller when something went good/bad/.... It is just a colored bar with a notification for the user. If you do not specify what kind of message you are passing it's assumed that is a "success" message.

The class itself is a simple stack that controls what messages are needed to display and what type. But with the `common` instance a module is provided so you can display these messages in your site. The module contains the controllers and templates necessary.

The usage is the following. In a parent controller:

	// Include the System messages controller:
	$this->addModule( 'system_messages', 'SharedSystemMessages' );

Then in the children controllers (if applies), or in any controller you need:

    use \Sifo\FlashMessages as FlashMessages;
    //...

	// Set the messages you need, some samples:
	FlashMessages::set( 'Installation correct!' );
	FlashMessages::set( 'Installation failed!', FlashMessages::MSG_KO );
	FlashMessages::set( 'For your information...!', FlashMessages::MSG_INFO );
	FlashMessages::set( 'Your account is incomplete', FlashMessages::MSG_WARNING );

Then include the module in your template:
	{$modules.system_messages}

Voilà!

By using the \Sifo\FlashMessages class, the debug is modified to display the FlashMessages whenever you set them as well.