Debug
=====
The debug is a powerful tool for you the developer. Allows you to fine tune your application so you can optimize it.
You should get familiar with it and you will start getting more and more productive quickly.

The Debug basically stores messages, variables, objects, benchmarks and saves them into a local SQLite data base after the page has been generated.

A short sample of the things you can see in the debug are:

* Database queries you executed, how long they took, their resultsets, type, host...
* Controllers loaded with all their parameters
* Templates loaded with the assigned variables (very useful for webmasters)
* Benchmarks (time spent for every operation)
* Data stored in Session
* Data stored in Cookies

Enabling the Debug
------------------
You can configure the debug environment by changing the values found in `config/domains.config.php`:

	$config['sifo.local'] = array(
	    // ...
		'devel' 	=> true,
		'has_debug' => true,
		// ...
	}

These two flags do the following:

 * The `devel` flag marks the environment as **in development**. You can later do some logic only when the execution is in development mode.
 * The `has_debug` flag states if the running domain has the capability of showing the floating debug or not.

By default, if `has_debug` is omitted in the configuration, it has the same value of `devel` var.

<div class="alert alert-block">
<strong>NOTE</strong>: You can show the debug in production environments if you turn the <code>has_debug</code> flag on.<br/>
You shouldn't do this unless you don't care about someone seeing your queries and paths with all the risk this has.
</div>

Analyzing an execution debug
--------------------------
In order to view an execution debug you have to go to the **Sifo Debug Analyzer** tool.
This tool comes with the Sifo _common_ instance and it's accessible through the `/sifo-debug-analyzer` URL.

If you don't specify any GET parameter, the tool will show you the last execution debug.
To be more specific, it'll load the last _parent_ execution, understanding by _parent_ execution an execution launched directly by the user and not by other execution via an AJAX request (what is understood as a _child_ execution).

If you want to view an specific execution debug, you only have to specify its `execution_key` through the GET param: `/sifo-debug-analyzer?execution_key=%xxx%` (Also linked from the mini_debug toolbar).

Upgrading from Sifo <= 2.9
--------------------------
If you're already working with Sifo and used to have the debug rendered at the bottom of the executed page, **you have to add these two new URLs** in order to access to the isolated version of the Debug Analyzer tool and be able to take the maximum profit of the Sifo debug:

* `url.config`

        // Sifo debug
        $config['sifo_debug_analyzer'] = $base . '/sifo-debug-analyzer';
        $config['sifo_debug_actions']  = $base . '/sifo-debug-actions';

* `router.config`

        // Debug analyzer
        $config['sifo-debug-analyzer'] = 'debug/analyzer';
        $config['sifo-debug-actions'] = 'debug/actions';

Here are some of the benefits of this change:

* Avoid rendering all the debug related DOM elements on the same page, with the performance improvement it carries on (specially for JS and CSS selectors).
* The different executions are stored on a local SQLite database located in the `sifo/logs/sifo.sqlite3` file, being able to recover a past execution debug and link to it.
* We automatically clean execution debugs older than 1 day at the moment of generating a new one. If you don't want to delete an execution, you can highlight it as _pinned_ through the star icon link on the Analyzer tool.
* AJAX calls debugs are linked to the caller executions thanks to the _parent_ and _child_ executions concept.
* Now we can execute 2 _Command line scripts_ without overriding the debug of the first one. And we'll store the executed command and arguments as the debug URL!

Enable or disable the debug in runtime
--------------------------------------
Only if you are in development mode you can enable or disable the debug, even if the `has_debug` flag is set to false, by adding to the URLs:

* `http://...?debug=1` -> Turns on the debug.
* `http://...?debug=0` -> Turns off the debug.

If it were necessary, it is also possible to turn on/off the debug directly in the code:

    Domains::getInstance()->setDebugMode( true ); -> Turn on debug mode.
    Domains::getInstance()->setDebugMode( false ); -> Turn off debug mode.

If you want to know in runtime this value do:

    Domains::getInstance()->getDebugMode();

Your own debug messages
-----------------------
Debug class also allows you to **store messages, variables or objects** of your own.

Since the messages are loaded in the debug, they won't be displayed on production. So freely, use this class instead of **var_dump** ;)

This messages can be shown in 3 different ways:

* `html`: Inside the debug loaded in the Analyzer. This is the default mode.
* `browser_console`: In browser console.
* `alert`: Inside a JavaScript alert.

And you can define the type of element:

* `log`: Normal message. This is the default mode. (Compatible: HTML, console, alert)
* `error`: Error message shown in red color. (Compatible: HTML, console )
* `warn`: Warning message shown in orange/yellow color. (Compatible: HTML, console )


*Usage*

Anywhere in your PHP code use this feature as follows:

    \Sifo\Debug::log( 'This message will be shown in browser console.', 'log', 'browser_console' );

__Output:__

![Simple example](<url:static>/docs/API/debugmessages_simple_example.png)

    $variable = 'Variable content';
    \Sifo\DebugMessages::log( $variable, 'log', 'browser_console' );

__Output:__

![Variable example](<url:static>/docs/API/debugmessages_variable_example.png)

    $variable_array = array(
        'first' => 'orange',
        'second' => 'pear',
        'totals' => array( 33, 22 )
    );
    \Sifo\DebugMessages::log( $variable_array, 'log', 'browser_console' );

__Output:__

![Array example](<url:static>/docs/API/debugmessages_array_example.png)


	\Sifo\Debug::log( $this->getParams(), 'log', 'html' );
	\Sifo\Debug::log( $this->getParams(), 'error', 'html' );
	\Sifo\Debug::log( $this->getParams(), 'warn', 'html' );

	\Sifo\Debug::log( $this->getParams(), 'log', 'browser_console' );
	\Sifo\Debug::log( $this->getParams(), 'error', 'browser_console' );
	\Sifo\Debug::log( $this->getParams(), 'warn', 'browser_console' );

__Output:__

![Complete example](<url:static>/docs/API/debugmessages_complete_example.png)


Command Line Debug (Scripts)
----------------------------
It's possible to generate the output Debug when you are executing a Command Line Script as well. The output is stored in `sifo/logs/cli_debug.html`. Remember to set write permissions in this directory.
If the script it's in `devel` environment the file is generated automatically. You can enable or disable the debug in the script call using the debug_mode parameter (`dm`):

    php myScript.php sifo.local -dm 1 -> Turns on debug.
    php myScript.php sifo.local -dm 0 -> Turns off debug.

There is no restriction in turning on/off the debug in production environment.

Customizing the debug
---------------------
It is possible to choose what information should be shown in the debug. In the `common` instance you'll find a `config/debug_config.config` where you can define which modules will be shown in the debug.
If you need to tune this values you should copy this debug_config.config in your instance (and do the rebuild).

If the content of `debug_config.config.php` is empty then the debug will be shown with all its components:

    $config['debug'] = array();

If you want only one module, then you must define it in the config:

    $config['debug']['queries'] = true;

When you use this debug configuration file only those modules stated in the file are shown. Other examples are:

    $config['debug']['queries'] = true;
    $config['debug']['searches'] = true;
    $config['debug']['basic'] = true;



