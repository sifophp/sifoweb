Quick Start Guide
=================
> Understanding how the Sifo works and how is used to create your own app.

This document will give you a quick overview on Sifo so you can get started with your own application. The first thing you
should do is [install] the framework so you can start playing with it.

There is a whole chapter explaining how to get the code and make it run, see the [installation].

Fundamentals
------------
Sifo is a [MVC](/quick-start/what-is-mvc) PHP5 framework focused on project inheritance. Meaning that you can have several sites that use capabilities
of the others. Just the same way in PHP you can make a class `extend` from another, you can make a site extend (inherit) from another.

Let's see how this works and how to make it run. Get familiar with the [directory structure](/quick-start/directory-structure) first.

### Default inheritance
Sifo comes with a default `instance` that contains some basic structure and tools that you can use. This instance is named
`common`. When you create your project it is going to inherit from this instance by default. You can create as many instances
as you like and make them inherit as you like as well. There is no limit in the depth you want to reach.

The inheritance of your instance is defined in the file `domains.config.php` under the key `instance_inheritance`.

The file is self-explanatory but for a little bit more information, see the [Domains documentation](/API/Domains)

### Defining the domains and connection parameters
Your application will answer to requests coming from a set of domains you define in the `config/domains.config.php`. This
file defines all of them and all the connection parameters per domain. Chances are that in your computer you have a dummy
database with a root/root user password but you don't want such an atrocity in production.

The `domains.config.php` allows to set development flags in order to show the [Debug](/API/Debug). See the
[Domains documentation](/API/Domains) for further info.


### Rebuild (`/rebuild`)
This is the first thing you need to learn when you start touching the code. Whenever you add a new file under your
instance folder, you need to let the application know that there is a new file it can make use of. Sifo **doesn't make
file scans** on runtime so it performs better in a real world scenario and that's why you need to create an index of files.

The `rebuild` process is a simple script that reflects the project inheritance, and scans all the instances that your
instances extends from, creating and index that will be used by the application. In order to run it all you need to do
is access the URL `/rebuild`. The script will regenerate the following files:

* `yourinstance/config/classes.config.php` Contains all the PHP Classes available in your project, and in what namespace they are
* `yourinstance/config/configuration_files.config.php` Contains all available configuration files (deepest in inheritance prevails)
* `yourinstance/config/templates.config.php` All the templates available to the `setLayout()` function in controllers.

### Routing (`router.config.php`)
At this point you still don't know how do you map a URL to a controller. How it will respond to the request?

The `Router` class is the responsible to do such a mapping. But you don't need to interact with it directly. All you need
to do is create an entry in the `router.config.php` file.

If you open the file right away you'll see that the config array has a key named `rebuild`. It is just what you used in the
previous explanation. Change it and write anything you like, for instance, `reindex` and after saving the URL for rebuilding
will be `/reindex`.

The anatomy of this file is pretty straightforward. The `key` of the array maps directly the URL (without any parameters)
and the value is the controller that will handle the request. The controller needs to be specified as `folder/file_without_extensions`

Example:

    // The URL /account maps to user/account.ctrl.php
    $config['account'] = 'user/account';

In the config file you'll find also **two special keys**:

    // Controller used when no path is passed (home page).
    $config['__HOME__'] = 'home/index';

    $config['__NO_ROUTE_FOUND__'] = 'static/index';

When there is no path, the router will load the controller specified in `__HOME__` and when no route can be resolved,
the controller specified at `__NO_ROUTE_FOUND__` will be used. A practical example of what can you do when a route is not
found are the "static pages". Maybe you can handle with a single controller all that typical HTML only pages like `/about-us`,
`/legal`...

### A real working instance
A good way to understand how things works is by looking a real-life instance. You can download this whole site instance
to see how is coded and understand how it works. But this site makes no use of database :)

[Download sifo web instance](https://github.com/alombarte/sifo-web) here.

### Writing code
At this poing you will be able to create your [first controller].


[download]: /download
[install]: /installation
[installation]: /installation
[first controller]: /quick-start/first-controller
