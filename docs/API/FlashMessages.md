FlashMessages
=============
A flash message is a phrase you set in the controller when something went good/bad/.... It is just a colored bar with a notification for the user. If you do not specify what kind of message you are passing it's assumed that is a "success" message.

The usage is the following. In a parent controller:

	// Include the System messages controller:
	$this->addModule( 'system_messages', 'SharedSystemMessages' );

Then in the children controllers, or in any controller you need:

	// Set the messages you need, some samples:
	$this->getClass( 'FlashMessages', false );
	FlashMessages::set( 'Installation correct!' );
	FlashMessages::set( 'Installation failed!', FlashMessages::MSG_KO );
	FlashMessages::set( 'For your information...!', FlashMessages::MSG_INFO );
	FlashMessages::set( 'Your account is incomplete', FlashMessages::MSG_WARNING );

Include the module in the template:
	{$modules.system_messages}

The debug is modified to display the FlashMessages whenever you set them.