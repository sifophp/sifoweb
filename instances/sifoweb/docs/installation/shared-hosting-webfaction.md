Installation in a shared hosting
================================
If you want to install Sifo in a shared server and you don't have the possibility to modify the VirtualHosts here is a trick. The following example
is for **Webfaction**, but others are similar.

 * Create a new App _Static/CGI/PHP-5.3_
 * Create the domain and website, and link the just created app.
 * Enter the shell and create a new folder, place all the code inside. Ensure the code **is not** under the folder the hosting created for you to hold the app (e.g: out of the 'webapps' folder)
 * Go to this folder the hosting created for you and where you don't have the code. E.g: `cd webapps/your_application`
 * Delete any sample files (index.html)
 * Create a new `.htaccess` file:

Content of .htaccess:

	RewriteEngine On
	RewriteCond %{DOCUMENT_ROOT}%{REQUEST_FILENAME} !-f
	RewriteRule ^([^.]+)/?$ /index.php

And finally:

 * Create a link from the hosting folder to the dispatcher in the other folder you have created.
 E.g: `ln -s ../../path_to_checkout/instances/*yourinstance*/public/root/index.php .`

And that's it.
