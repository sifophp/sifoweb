Installation
============
> Install Sifo in 5 minutes. So to speak.

If you are comfortable with a terminal, this is the easiest way to install Sifo. The installation of the Sifo framework basically consists in the following steps:

 * [Clone or download the project](#clone)
 * [Configure the web server](#webserver)
 * [Create your project](#instance)

Let's get started!

### Clone the project {#clone}
To get a copy of the code all you have to copy/paste in the terminal is a:

    git clone git://github.com/alombarte/SIFO.git sifo

If you don't want to do it this way and prefer a ZIP file you can still visit the [download](/download) page for all the available options, bells and whistles.

### Configure the web server {#webserver}
This is the part where you tell your webserver where to point to, where the code is. To do so you need to create a VirtualHost in your server.
Depending on the technology you use the procedure is different, we provide detailed instructions for Apache and Nginx.

If you have a **shared hosting** where you can't tune your server configuration there are instructions too, but we can't
cover all specific services so we used Webfaction as a sample.

* [Apache configuration](/installation/apache-virtualhosts)
* [Nginx configuration](/installation/nginx-virtualhosts)
* [Shared hosting configuration](/installation/webfaction)

### Create your project {#instance}
After downloading the code you have to create your own `instance`. This is how we call your specific project. Creating
an instance can be easily done by executing one time only script.

    bash scripts/create_instance.sh <instance_name>  <your_domain>

The script takes two arguments:

 * `<instance_name>`: The name you want to put to your instance (project) and to your PHP namespace. Lowercase, letters only or underscore if it is not in the beginning.
 * `<your_domain>`: The domain you are going to use to access this page. Example: mysite.local (development)

#### Important note
It is recommended that you start building your application with a **fake domain** that will be used for development.
We usually use the fake top level domain `.local`, so if we want to create in the internet an app named `mywebapp.com` then
we create the instance like this:

    bash scripts/create_instance.sh mywebapp mywebapp.local

You'll need to add in your `/etc/hosts` (Linux and Mac) an entry `mywebapp.local` with the IP of the server. In case you
are planning to have multiple and dynamic subdomains a DNS server is recommended.

**Example of `hosts`**

    192.168.1.1       mywebapp.local www.mywebapp.local

At this point, if you have configured the web server pointing to the new instance you should be able to see the page
[http://mywebapp.local](http://mywebapp.local)