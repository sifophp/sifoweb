Nginx Configuration
===================================
For those of you using Nginx installations, this is supposed to be a "First Aid" guide to translate the framework requirements explained in the apache section for Nginx webservers. For further information about Nginx virtualhosts: <a href="http://wiki.nginx.org/Configuration" title="Nginx Wiki Page">Nginx Wiki Page</a>

Find the damn virtualhost config file
-------------------------------------
Normally Nginx configuration files are located under **/etc/nginx** path. Usually, inside this folder you'll find a /conf.d folder that contains the vhost definitions.

### VirtualHost content ###
Once you've located where you have to write the content and how, this is the content you need to write. Adapt paths to your installation:

    # Fake CDN. Specific entry to serve static content such as CSS, JS or Images
    server
    {
        listen 80;
        server_name static.yourproject.com;
        root /path/to/sifo/instances/yourinstance/public/static;
    }

    # Dynamic content (PHP)
    server
    {
        listen 80;
        server_name www.yourproject.com;

        # First look for the index.php
        index index.php;

        # Where do we log stuff?
        access_log /path/to/your/logs/folder/access.log combined;
        error_log /path/to/your/logs/folder/error.log info;

        # The documentroot of the site.
        root /path/to/sifo/instances/yourinstance/public/root;

        location ~* ^.+\.(jpg|jpeg|gif|css|png|js|ico|html)$
        {
            access_log        off;
        }

        if ( !-e $request_filename) {
            rewrite ^.* /index.php last;
        }

        # Is the file ending in the .php extension?
        location ~\.php$
        {
            include fastcgi_params;

            # Configure the fastCGI
            fastcgi_split_path_info ^(.+\.php)(.*)$;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;

            if (-f $request_filename) {
                # Only throw it at PHP-FPM if the file exists (prevents some PHP exploits)
                fastcgi_pass backend_php;     # The upstream determined above
            }
        }
    }

    # This example configuration is based in a PHP-FPM Backend.
    # Here you'll find an extract of the main server configuration (not the vhosts)
    http
    {
        default_type application/octet-stream;
        include /path/to/mime.types;

        fastcgi_read_timeout 1200;

        log_format main '$remote_addr - $remote_user [$time_local] '
                  '"$request" $status  $body_bytes_sent "$http_referer" '
                  '"$http_user_agent" "$http_x_forwarded_for"';

        # These are good default values.
        tcp_nopush        on;
        tcp_nodelay       off;

        # output compression saves bandwidth
        gzip            on;
        gzip_http_version 1.0;
        gzip_comp_level 2;
        gzip_proxied any;
        gzip_types text/plain text/css application/x-javascript text/xml application/xml application/xml+rss text/javascript;

        upstream backend_php
        {
                server 127.0.0.1:9000;
        }

        # the vhost definitions
        include /path/to/nginx/folder/conf.d/*;
    }

