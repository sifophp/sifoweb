Working with Directories
========================
The `DirectoryList` class returns the content inside the given path. You can decide if you want to see only files, folder and files, and set some filters to see only a subset of the content.

The content returned by the `DirectoryList` can be looped and use internal [SPL] functions to retrieve interesting information. This is an example of usage inside a Controller

[SPL]: http://www.php.net/manual/en/book.spl.php

	$dir = \Sifo\DirectoryList();
	
	// Get immediate files with .html extension:
	$parse_folder = ROOT_PATH . '/instances/sifoweb/docs';
	$files = $dir->getList( $parse_folder, array( 'html' ) );
	foreach ( $files as $path => $info )
	{
		echo "<h1>Path: $path</h1>";
		if ( $info->isDir() )
		{
			echo " (directory)";
		}
		else
		{
			// See methods: http://www.php.net/manual/en/class.directoryiterator.php
			echo "<br/>File weights: {$info->getSize()}";
			echo "<br/>Basename: {$info->getBasename()}";
			echo "<br/>Type: {$info->getType()}";
			echo "<br/>Modified last time: {$info->getMTime()}";
			echo "<br/>Owned by: {$info->getOwner()}";
			echo "<br/>Permissions: {$info->getPerms()}";
		}
	}
	
	// Get recursive list of html files and dirs:
	$files = $dir->getRecursiveList( $parse_folder, true, array( 'md' ) );
	// ... loop again
	die;
