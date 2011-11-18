README
======
Sifoweb is the source code of the site <http://sifo.me>, which is also a an
instance of [SIFO]. You can use this instance to understand a little bit how to
code a SIFO instance. 

 [SIFO]: https://github.com/alombarte/SIFO

Installation
------------
To install this instance the first thing you need is a full copy of the [SIFO]
code. Then copy the sifoweb project inside the folder `sifo/instances/sifoweb`
(ensure there is no dash: `sifo-web` would be incorrect, the instance must be named `sifoweb`)

Then in your Apache virtualhosts you should add something like:

	# SIFO.ME
	<VirtualHost *:80>
			ServerName static.sifo-web.local
			DocumentRoot /var/www/sifo/instances/sifoweb/public/static
	</VirtualHost>

	<VirtualHost *:80>
			ServerName sifo-web.local
			ServerAlias *.sifo-web.local
			DocumentRoot /var/www/sifo/instances/sifoweb/public/root

			RewriteEngine On
			#Allowed media extensions (includes .txt files for robots or .html, e.g: Google hosted HTMLs):
			RewriteCond %{REQUEST_FILENAME} !^(.+)\.(js|css|gif|png|jpe?g|swf|ico|txt|html)$
			RewriteRule ^/(.+) /index.php [QSA,L]
	</VirtualHost>

**Note** that there are 2 hosts. One for static files, and another for dynamic files.
Change the route `/var/www/sifo/` by the route where your project is.