{extends file=$_tpls['layout/basic.tpl']}
{block name='content'}
<div id="masthead">
	<div class="inner">
        <div class="container">
			<h1>SIFO, framework for PHP</h1>
			<p class="lead">
				SIFO is a flexible PHP5 framework for real-world web applications.<br />
				Glues Memcached, Redis, Sphinx, Mysql and other RDBMS inside a Model-View-Controller context.
			</p>
        </div> <!-- /container -->
	</div>
</div>

<div id="quickstart">
	<div class="container">
		<section id="introduction">
			<div class="row">
				<div class="span5 columns">
					<img alt="SIFO logo" src="{$url.static}/css/images/logo.jpg" />
				</div>
				<div class="span11 columns">

					<p><a href="http://sifo.me">SIFO</a> is a well-proben open source PHP5 framework currently running on several
						sites, from small installations to large websites with multiple servers.</p>

					<p>SIFO is free and very easy to use. Contains a lot of libraries and classes that
						allow you to get your projects running in a breeze.</p>

					<p>Checkout from the official SVN repository at Google Code or clone, pull, fork... from the Github mirror.</p>
					<p><a target="_blank" href="http://code.google.com/p/sifo/" class="btn primary">SIFO on Google Code »</a> or <a target="_blank" href="https://github.com/alombarte/SIFO" class="btn primary">SIFO on GitHub »</a></p>
					<p>Quick checkout:</p>
					<form>
						<textarea rows="1">svn checkout http://sifo.googlecode.com/svn/trunk/ sifo</textarea>
					</form>

				</div>
			</div> <!-- /row -->

			<div id="overview">
				<div class="row">
					<div class="span16 columns"><h1>Architecture</h1></div>
				</div>

				<div class="row">
					<div class="span8 columns">
						<h3>MVC pattern</h3>

						<p>SIFO uses the MVC pattern to sepparate your project in 3 different areas:</p>

						<ul>
							<li>Models: Contain the bussiness logic. Where all the data is taken from (e.g: Queries to database)</li>
							<li>Views: HTML templates with a little bit of logic such as iterations. It's just the presentation of your web. <a href="http://www.smarty.net">Smarty</a> by default.</li>
							<li>Controllers: The ones that put it all together with any necessary logic.</li>
						</ul>

						<p>If you never used this pattern before, you should start now if you don't want to
							become insane once your applications start to grow. Don't feel overwhelmed, it's easy.</p>
					</div>
					<div class="span8 columns">
						<img src="{$url.static}/docs/mvc.png" />
					</div>
				</div>
				<div class="row">
					<div class="span11 columns">
						<h3>Multiple environments</h3>

						<p>Via a single file, the mighty <code>config/domains.config.php</code>, you set-up your application.
							In this file you declare the domains your application will listen to and set the
							configuration for each one of them. For instance, if you want to code the webpage
							<strong>http://sifo.me</strong> you might want to set at least 2 domains: The real production
							domain <em>sifo.me</em> and a fake one for local development <em>sifo.local</em></p>

						<p>In the <code>config/domains.config.php</code> you can set up things like:</p>

						<ul>
							<li>Show/hide the debug (<code>devel</code> flag)</li>
							<li>Languages accepted by your application</li>
							<li>Credentials to several services, init commands, master/slave configurations (e.g: mysql)</li>
							<li>Related hostnames, error reporting and other specific PHP tasks.</li>
						</ul>

					</div>
					<div class="span5 columns">
						<img src="{$url.static}/docs/servers.png" />
					</div>
					<div class="row">
						<div class="span16 columns">
							<p><em>Portion of the file</em>:</p>

							<pre class="prettyprint"><code>$config['sifo.me'] = array(
    'devel' =&gt; false, // No debug in production.
    'instance' =&gt; 'sifoweb',
    'language' =&gt; 'en_US',
    'database' =&gt; array(
        'profile' =&gt; 'PRODUCTION' // Master/slave profiled taken from db_profiles.config.php.
        'db_driver' =&gt; 'mysqli',
        'db_host' =&gt; '127.0.0.1',
        'db_user' =&gt; 'root',
        'db_password' =&gt; 'root',
        'db_name' =&gt; 'mydatabase',
        'db_init_commands' =&gt; array( 'SET NAMES utf8' )
    ),
    /*  REDIS syntax:
    'database' =&gt; array(
        'database' =&gt; array(
        'host'     =&gt; '127.0.0.1',
        'port'     =&gt; 6379,
        'database' =&gt; 0
    */
    ),
    'php_ini_sets' =&gt; array( // Empty array if don't want changes.
        // Log errors to 'logs' folder:
        'log_errors' =&gt; 'On',
        'error_log' =&gt; ROOT_PATH . '/logs/sifoweb_errors.log',
    ),
    'libraries_profile' =&gt; 'stable_libraries'
    );

    $config['sifo.local'] = $config['sifo.me']; // Take all the config from production
    // Redefine some vars for local domain:
    $config['sifo.local']['devel'] = true;
    $config['sifo.local']['static_host'] = 'http://static.sifo.local';
    $config['libraries_profile'] = 'unstable_libraries'
</code></pre>

						</div>
					</div>
				</div>
				<div class="row">
					<div class="span8 columns">
						<img src="{$url.static}/docs/router.jpg" />
					</div>
					<div class="span8 columns">
						<h3>Routing</h3>

						<p>When you type an URL there is a mapping between what you are typing in the address bar
							and the controller that should reply to that request. Is what we call the <em>router</em> and
							is located under <code>config/router.config.php</code>. If your application has urls translated
							you can also use the <code>router_xx_XX.config.php</code> files, where the xx_XX is the language
							and country code of your app. SIFO supports as much languages as you need.</p>
					</div>

				</div>
				<div class="row">
					<div class="span5 columns">
						<h3>Powerful Debug</h3>

						<p>The SIFO debug contains a lot of interesting stuff to debug your application:</p>

						<ul>
							<li>Benchmark: Full decomposition and analysis of times of execution per file and method</li>
							<li>Parameters that every Controller received</li>
							<li>Variables every template received (smarty)</li>
							<li>Queries launched to the database

								<ul>
									<li>Automatic commenting of the queries</li>
									<li>Nice print of the final SQL launched</li>
									<li>Different coloring for write/read operations, with times</li>
									<li>Slow query alert</li>
									<li>Printed recordset returned in tabular data</li>
									<li>Host, database, and replica the query went in</li>
								</ul></li>
							<li>Data stored in Session (and <em>kill session</em>)</li>
							<li>Data stored in user Cookies</li>
							<li>Cache control (names of the keys, remaining TTL...)</li>
							<li>Sphinx Debug</li>
							<li>Cache invalidation

								<ul>
									<li>AUTOMATIC: While browsing</li>
									<li>Manual: By flag</li>
								</ul></li>
						</ul>
					</div>
					<div class="span11 columns">
						<img src="{$url.static}/docs/debug.jpg" />
					</div>
				</div>
				<div class="row">
					<div class="span16 columns">
						<h3>Multilanguage</h3>

						<p>Almost every SIFO programmer has multi-lingual projects, because it is very easy.
							We even have translation tools based on config files or in database, so you can
							pass the URLs to your non-programmers colleagues the URLs for proper translation.</p>

						<p>All the smarty templates come with the i18n plugins that allow you to write your
							files in a single language. Example: If we had an application with three possible
							languages, we could have in the template something like:</p>

						{literal}
						<pre class="prettyprint">
<code>&lt;h1&gt;{t 1=$username}Hello %1, welcome back!{/t}&lt;/h1&gt;

This code would produce a different output depending on the current active language:

&lt;h1&gt;Hello John, welcome back!&lt;/h1&gt;
&lt;h1&gt;Hola Juan, bienvenido de nuevo!&lt;/h1&gt;
&lt;h1&gt;Hola Joan, benvingut de nou!&lt;/h1&gt;
</code></pre>
						{/literal}

						<p>Your application languages are set on the <code>config/domains.config.php</code> file.</p>

						<p>Sometimes we've been asked, yes, there is support for non-latin alphabets. We do
							have several installations in Russian, Arabic, Japanese, Chinese, Hebrew... so yes,
							and also design with RTL text.</p>
					</div>
				</div>


				<div class="row">
					<div class="span11 columns">
						<h3>Inheritance across different projects</h3>

						<p>Let's say you have several sites running. Doesn't make sense to you that a project
						inherits the functionality from another one, or even configurations? Wouldn't be good to reuse the code from
						a "parent" project?</p>
						<p>Project inheritance allows you to create several projects (we call it <em>instances</em>) based on a
						previous one. Be configuration, templates, controllers, models or other libraries. Create an instance
						that inherits from another one and just overwritte/extend/limit the desired functionality</p>
					</div>
					<div class="span5 columns">
						<img class="nomargin" src="{$url.static}/docs/tree.png" />
					</div>
				</div>


				<div class="row">
					<div class="span5 columns">
						<h3> Lazy loading</h3>

						<p><strong>The less classes are in-memory, the better</strong>. We stick to the principle of loading
							the classe only if they are going to be used.</p>
						<p>The configuration file <code>config/libraries.config.php</code>
							defines what classes are loaded per execution, and what versions of the libraries
							do you use.</p>
						<p>You can even create several profiles of libraries: maybe you want to
							play with the latest unstable library in local, while keeping the stable one in production.</p>
					</div>
					<div class="span11 columns">
						<p>A piece of <code>config/libraries.config.php</code>:</p>

						<pre class="prettyprint"><code>$config['classes_always_preloaded'] = array(
    'Exceptions',
    'Registry',
    'Cache',
    'CantLiveWithoutThisClass'
);

// Contains all the libraries available.
$config['default'] = array(
    'mylibrary' =&gt; 'Mylibrary-1.5-stable'
);
$config['bleeding_edge_insane'] = array(
    'mylibrary' =&gt; 'Mylibrary-2.0alpha-unstable'
);
</code></pre>
						<p>At execution time you can always load any needed application via the
							<code>$this-&gt;getClass( 'ClassName' )</code> function in any point of the code, or if it's
							going to be loaded for sure include it in a protected var:</p>

						<pre class="prettyprint"><code>// Include the Filter class before the Controller is actually executed:
protected $include_classes = array( 'Filter' );
</code></pre>
					</div>
				</div>
				<div class="row">
					<div class="span11 columns">
						<h3>Multiple databases flavour</h3>

						<p>From Key-values like Redis to Oracle, Mysql, Postgres, Firebird or even SQLite.
							You can choose to use Mysql PDO or any of the ADODB drivers. For redis, Predis
							is an excellent solution.</p>
					</div>
					<div class="span5 columns">
						<img class="nomargin" src="{$url.static}/docs/databases.png" />
					</div>
				</div>
				<div class="row">
					<div class="span11 columns">
						<h3>Command Line support</h3>

						<p>Yes, you like to code your cron jobs in PHP, so do we. Take profit of your existing
							models. Create your scripts extending from the Command Line.
							The CLI tool lets you define the supported parameters of the script and automatically
							builds the help for you. If you are interested in receiveing email reporting is also
							already done.</p>
					</div>
					<div class="span5 columns">
						<img class="nomargin" src="{$url.static}/docs/cli.png" />
					</div>
				</div>

				<div class="row">
					<div class="span11 columns">
						<h3>Dynamic/static distinction</h3>

						<p>You never know what is going to happen. Putting your static files in a different
							host is always a win-win decision. If your site grows you will be able to set
							up a CDN quickly. The <code>domains.config.php</code> file contains special entries
							to sepparate dynamic (PHP) from static files (CSS, images, media).
						</p>
					</div>
					<div class="span5 columns">
						<img class="nomargin" src="{$url.static}/docs/statics.png" />
					</div>
				</div>

				<h1>And more...</h1>

				<div class="row">
					<div class="span11 columns">
						<h3>Lots of helpful classes</h3>

						<p>Many projects share the same needs. Do you need to send nice emails? Geolocalise
							the users? Facebook/Youtube/Twitter integration? Quick searches using Sphinx? Upload
							files to Amazon S3? Do not reinvent the wheel, invest your time in something else.</p>

						<h3>Extendable</h3>

						<p>What would be the framework if you couldn't add our own classes and libraries?
							There is room for entire libraries, simple classes or <em>helpers</em>. Before coding
							something from scratch, ensure there is not something done already.</p>



						<h3>Yes, more...</h3>

						<p>It's just that I am tired of writing, it is late night. If you arrived
							here it's time to get a little bit deeper yourself guided by the documentation.</p>
					</div>
					<div class="span5 columns">
						<img src="{$url.static}/docs/libraries.png" />
					</div>
				</div>

			</div>{*eof overview*}
		</section>
	</div>
</div>
{/block}
