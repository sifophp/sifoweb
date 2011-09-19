Install SIFO in a shared hosting/Webfaction
===========================================
If you want to install SIFO in a shared server and you don't have the possibility to modify the VirtualHosts here is a trick. The following example
is for Webfaction, but others are similar.

	* Create a new App _Static/CGI/PHP-5.2_
	* Create the domain and website, and link the just created app.
	* Enter the shell and create a new folder, with the whole checkout of the code. Ensure the code is not under the hosting control (e.g: out of the 'webapps' folder)
	* cd webapps/your_application (wherever your hosting points to)
	* Delete any sample files (index.html)
	* Create a new `.htaccess` file:

	RewriteEngine On
	#Allowed media extensions (includes .txt files for robots or .html, e.g: Google hosted HTMLs):
	RewriteCond %{REQUEST_FILENAME} !^(.+)\.(js|css|gif|png|jpe?g|swf|ico|txt|html)$
	RewriteRule ^([^.]+)/?$ /index.php

	* Link the dispatcher to the public folder:
	ln -s ../../path_to_checkout/instances/*yourinstance*/public/root/index.php .

And that's it.
