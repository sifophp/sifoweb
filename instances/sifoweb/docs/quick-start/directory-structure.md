Directory structure
===================
When you have downloaded the Sifo code, the directory structure looks like this:

    sifo/
	 |_ instances --> Each web project you create should place a folder here
	   |_ common --> Instance by default
	   |_ yourinstance -> You should have created your own instance
	 |_ libs --> External libraries needed to make your project work (including Sifo)
	 |_ logs --> Directory where the php errors and other stuff is written
	 |_ scripts --> Scripts that will run via PHP-CLI
	 |_ tests --> Unit testing

The most important folder is the `instances` folder, which contains your project, and is the place where you will work.
When you build your app you only have to focus in `sifo/instances/yourowninstance`. Every instance should have, at least,
the following structure:

    sifo/instances/yourinstance
	 |_ classes -> OPTIONAL. Allows to redefine the Sifo classes and other libraries.
	 |_ config -> Configuration files are here.
	 |_ controllers
	 |_ locale -> Translations used in you templates will be stored here
	 |_ logs
	 |_ models
	 |_ public
	   |_ static --> The static files are stored here
	   |_ root -> Where the dispatcher is kept
