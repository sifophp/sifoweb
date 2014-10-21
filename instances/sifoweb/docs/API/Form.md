Form
====
The form class helps validating data and making simpler the interaction with the user. The more convenient way to use it
is by creating a configuration file with all the fields used in your form and the conditions for being accepted. You can
also pass the fields instead of creating the configuration form.

The form class needs to know what kind of filter are you going to use (e.g POST, GET, REQUEST...) via the proper Filter class.

The usage is the following. This is an example for a form sent with the POST method:

	$post = \Sifo\FilterPost::getInstance();
	if ( $post->isSent( 'a_field_name' )
	{
        $form = \Sifo\Form::getInstance( $post );
        // Will search the declaration in config/forms/myform.config.php
        $is_valid_form = $form->validateElements( 'forms/myform' );

         if ( !$is_valid_form )
         {
            // Reasons here (you can pass it to the template again)
         	$errors = $form->getErrors();
         }
         else
         {
            // Valid data:
            $form->getFields();
         }
    }

Form configuration file example
-------------------------------
This is an example of form configuration file. Have a look at the syntax.

    // Radio button with 3 known options:
    $config[] = array(
            'name' => 'how_can_see_my_profile', // Input name
            'filter' => 'getInArray', // Filter used. E.g: FilterPost->getInArray()
            'params' => array( array( 'all', 'registered', 'nobody' ) ),
            'error' => 'Hacking radio buttons? That\'s sad', // Error message when the value is not valid
            'required' => true // Value must be passed or not.
    );

    // Validate using regular expression:
    $config[] = array(
            'name' => 'username',
            'filter' => 'Regexp',
            'params' => array( '/[a-z0-9]+/' ),
            'error' => 'Only letters and numbers are accepted.'
    );

    // Validate the age is between 18 and 120.
    $config[] = array(
      	 'name' => 'age',
      	 'filter' => 'getInteger',
      	 // Params are passed in the given order to the function.
      	 'params' => array( 18, 120 )
      	  // So far, the function will be called as
      	  // Filter::getInstance()->getInteger( 'age', 18, 120 );

    // See Form.php for more examples.
