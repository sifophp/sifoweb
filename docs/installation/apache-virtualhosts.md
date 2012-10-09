Configuring the Apache VirtualHosts
===================================
Although we do use several web servers with Sifo such as Lighhttpd or Nginx (mainly for static files), truth is that almost all installations user Apache2 as their web server. We do provide step by step installations to run Sifo under apache, but this can be done in any other webserver.

In production, if you want to run a single project it performs better not using VirtualHosts at all, but since is very convenient in development time to manage several projects at once we present this configuration.

Find the damn virtualhost config file
-------------------------------------
Depending on the Linux/Mac/BSD whatever flavour you are using the location for the default configuration files might change their path, or even the way they work.

The most common paths are:

* For **RedHat/CentOS** and other familiars: A single file under: `/etc/httpd/conf.d/virtual.conf`
* **Debian/Ubuntu** and others: Several files under `/etc/apache2/sites-available/` and then linked in `/etc/apache2/sites-enabled/`
* Other systems directly write the VirtualHost content inside the `httpd.conf` file.

### VirtualHost content ###
Once you've located where you have to write the content and how, this is the content you need to write. Adapt paths to your installation:

    # Do not forget this line!
    NameVirtualHost *:80

	# Fake CDN. Specific entry to serve static content such as CSS, JS or Images
	<VirtualHost *:80>
	        ServerName static.yourproject.com
	        DocumentRoot /path/to/sifo/instances/yourinstance/public/static
	        # Recommended, uncomment to GZIP all CSS, JS, JSON, HTML, and TXT
	        # AddOutputFilterByType DEFLATE text/plain text/html text/javascript text/css application/json
	</VirtualHost>

	# Dynamic content (PHP)
	<VirtualHost *:80>
	        ServerName www.yourproject.com
	        # ServerAlias yourproject.com
	        DocumentRoot /path/to/sifo/instances/yourinstance/public/root

	        RewriteEngine On
	        #Allowed media extensions (includes .txt files for robots or .html, e.g: Google hosted HTMLs):
	        RewriteCond %{REQUEST_FILENAME} !^(.+)\.(js|css|gif|png|jpg|swf|ico|txt|html?)$
	        RewriteRule ^/(.+) /index.php [QSA,L]
	</VirtualHost>

**IMPORTANT** Verify that the `VirtualHost *:80` block matches EXACTLY with the entry NameServer of your apache, otherwise it won't work.
