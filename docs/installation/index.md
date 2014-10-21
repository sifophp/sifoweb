Installation
============
> Install Sifo in 5 minutes. So to speak.

In order to install Sifo you need to have at least an Apache/Nginx running with PHP. Depending on your needs
a variety of other services can be needed, such as Mysql, Sphinx, Redis... etc. If you want to start playing
with Sifo or if you intend to do local development first the most convenient way to work is install Sifo inside
a Virtual Machine.

## Sifo requirements
* PHP >= 5.3 (We use namespaces!)
* PDO & SQLite3 (In order to [save executions debug](/API/Debug) and being able to recover them, we use a little database managed thanks to the PDO extension, do not worry, it [comes with the default PHP installation since 5.1](http://php.net/manual/en/intro.pdo.php) and the SQLite3 extension also [comes with the default installation since 5.3.0](http://php.net/manual/en/sqlite3.installation.php))

## Install via composer
If you want to have an instance of Sifo running in a minute then you should clone the `sifo-app` which is a sample application using Sifo.

    git clone https://github.com/sifophp/sifo-app.git
    composer install

After this add `sifo-web.local` as a new Virtualhost, pointing to `instances/sifoweb/public/root` (see [Apache configuration](/installation/apache-virtualhosts) for further information)

## Automatic installation using Vagrant
Hold on to the seats, this is all you need to do to have Sifo running in your local machine inside a Virtual machine:

* Download and install [Vagrant](http://www.vagrantup.com/) (do not be scared, this is a double-click installation)
* Automatically download and install the machine by:

Copy/paste:

	git clone --recursive git@bitbucket.org:obokaman/centos-6.3-lamp-with-vagrant-for-sifo.git vmSifo
	cd vmSifo
	vagrant up

That's all. No kidding. These commands will download a [running Sifo via Vagrant](https://bitbucket.org/obokaman/centos-6.3-lamp-with-vagrant-for-sifo)

Now to access the running site:

* Add in your machine as *DNS server* the IP `192.168.33.10` (will resolve any .local or .vm domains)
* Now sifo is accessible in [http://sifo.local](http://sifo.local)
* Read this [README](https://bitbucket.org/obokaman/centos-6.3-lamp-with-vagrant-for-sifo) to understand how Vagrant works with Sifo
* [Start coding your own project](#instance)

## Manual installation
If you are comfortable with a terminal, this is the way to install Sifo. The installation of the Sifo framework basically consists in the following steps:

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
* [Shared hosting configuration](/installation/shared-hosting-webfaction)

## Create your project {#instance}
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
are planning to have multiple and dynamic subdomains a DNS server is recommended (as we suggested with Vagrant installation).

**Example of `hosts`**

    192.168.1.1       mywebapp.local www.mywebapp.local

At this point, if you have configured the web server pointing to the new instance you should be able to see the page
[http://mywebapp.local](http://mywebapp.local)