{extends file=$_tpls['layout/basic.tpl']}
{block name='content'}
<div id="masthead">
	<div class="inner">
        <div class="container">
			<h1>Framework for PHP</h1>
			<p class="lead">
				SIFO is a flexible PHP5 framework for real-world web applications.<br />
				Daily use classes, Memcached, Redis, Sphinx, Mysql and other RDBMS inside a Model-View-Controller context.
			</p>
        </div> <!-- /container -->
	</div>
</div>

<div id="quickstart">
	<div class="container">
		<section id="introduction">
			<div class="row">
				<div class="span4 columns">
					<img alt="SIFO logo" src="{$url.static}/css/images/logo.jpg" /><br/>
				</div>
				<div class="span8 columns">

					<div class="teaser well">
						<p><a href="http://sifo.me">SIFO</a> is a well-proben open source PHP5 framework currently running on several
							sites, from small installations to large websites with multiple servers.</p>

						<p>SIFO is free and very easy to use. Contains a lot of <strong>libraries and classes</strong> that resolve your
							<strong>basic problems</strong> and allow you to focus in your business logic, at a very low learning curve. If there is a curve :)</p>
					</div>
					<p>You can download, clone or fork the project from Github.</p>
					<p><a target="_blank" href="https://github.com/alombarte/SIFO/tags" class="btn btn-primary">Download package »</a>
                        or <a target="_blank" href="https://github.com/alombarte/SIFO" class="btn btn-primary">Git Clone»</a>
                        or read the <a target="_blank" href="{$url.base}/API" class="btn btn-success">Documentation »</a></p>
				</div>
			</div> <!-- /row -->

			<div id="overview">
				<div class="row">
					<div class="span12 columns"><h1>SIFO features</h1></div>
				</div>

				<div class="row">
					<div class="span6 columns">
						<h3>MVC pattern</h3>

						<p>SIFO uses the MVC pattern to sepparate your project in 3 different areas:</p>

						<ul>
							<li>Models: Contain the business logic. Where all the data is taken from (e.g: Queries to database)</li>
							<li>Views: HTML templates with a little bit of logic such as iterations. It's just the presentation of your web. <a href="http://www.smarty.net">Smarty</a> by default.</li>
							<li>Controllers: The ones that put it all together with any necessary logic.</li>
						</ul>

						<p>If you never used this pattern before, you should start now if you don't want to
							become insane once your applications start to grow. Don't feel overwhelmed, it's easy.</p>
					</div>
					<div class="span6 columns">
						<img src="{$url.static}/docs/mvc.png" />
					</div>
				</div>
				<div class="row">
					<div class="span6 columns">
						<h3>Scalable</h3>

						<p>SIFO has been developed thinking in scalability and performance. You can configure
							right from the beginning features like load balancing, separate your static and
							dynamic content or add advanced caching to your pages.</p>
					</div>
					<div class="span6 columns">
						<h3>Proved</h3>
						<p>Well proved, running since year 2008 and used in a large base of heterogeneous web projects with very different needs and technologies.</p>
						<p>Powers big sites, some of them with up to 16M page views/month (and raising!)</p>
					</div>
				</div>

				<div class="row">
					<div class="span8 columns">
						<h3>Inheritance across different projects</h3>

						<p>Let's say you have several sites running. Doesn't make sense to you that a project
						inherits the functionality from another one, or even configurations? Wouldn't be good to reuse the code from
						a "parent" project?</p>
						<p>Project inheritance allows you to create several projects (we call it <em>instances</em>) based on a
						previous one. Be configuration, templates, controllers, models or other libraries. Create an instance
						that inherits from another one and just overwrite/extend/limit the desired functionality</p>
						<p>Have you developed a tracking system? A module for advertisement? A fancy WYSIWYG implementation?
							Why coding it again or even pasting it for yet another project? Reuse!</p>
						<p>You can run unrelated projects that share common base code.</p>
					</div>
					<div class="span4 columns">
						<img class="nomargin" src="{$url.static}/docs/tree.png" />
					</div>
				</div>
				<div class="row">
					<div class="span8 columns">
						<h3>Environment aware</h3>

						<p>Via a single file, the mighty <code>config/domains.config.php</code>, you define the behaviour
							of your application depending on the URL you are requesting. For instance, if you want to code the webpage
							<strong>http://sifo.me</strong> you might want to set at least 2 domains, one for production usage under
							<strong>http://sifo.me</strong> and a fake one for local development like <strong>http://sifo-web.local</strong></p>

						<p>In the <code>config/domains.config.php</code> you can set up things <strong>per domain</strong> like:</p>

						<ul>
							<li>Show/hide the debug (<code>devel</code> flag)</li>
							<li>Languages accepted by your application</li>
							<li>Credentials to several services, init commands, master/slave configurations, database passwords or libraries used (e.g: mysql)</li>
							<li>Related hostnames, error reporting and other specific PHP.ini settings.</li>
						</ul>

					</div>
					<div class="span4 columns">
						<img src="{$url.static}/docs/servers.png" />
					</div>
					<div class="row">
						<div class="span12 columns">
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
					<div class="span6 columns">
						<img src="{$url.static}/docs/router.jpg" />
					</div>
					<div class="span6 columns">
						<h3>Nice URLs and Routing</h3>

						<p>When you type an URL there is a mapping between what you are typing in the address bar
							and the controller that should reply to that request. Is what we call the <em>router</em> and
							is located under <code>config/router.config.php</code>. If your application has urls translated
							you can also use the <code>router_xx_XX.config.php</code> files, where the xx_XX is the language
							and country code of your app. SIFO supports as much languages as you need.</p>
						<p>The router is flexible to do all you like, even set controllers to subdomains.</p>
					</div>

				</div>
				<div class="row">
					<div class="span4 columns">
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
					<div class="span8 columns">
						<img src="{$url.static}/docs/debug.jpg" />
					</div>
				</div>
				<div class="row">
					<div class="span12 columns">
						<h3>Multilanguage</h3>

						<p>Almost every SIFO programmer has multi-lingual projects, because it is very easy.
							We even have translation tools based on config files or in database, so you can
							pass the URLs to your non-programmers colleagues the URLs for proper translation.</p>

						<p>All the templates come with the i18n plugins that allow you to write your
							files in a single language. Example: If we had an application with 6 possible
							languages, we could have in the template something like:</p>

						{literal}
						<pre class="prettyprint">
<code>&lt;h1&gt;{t 1=$place}Welcome to %1!{/t}&lt;/h1&gt;

This code would produce a different outputs depending on the current active language:

English: &lt;h1&gt;Welcome to Sifo!&lt;/h1&gt;
Spanish: &lt;h1&gt;Bienvenido a Sifo!&lt;/h1&gt;
Catalan: &lt;h1&gt;Benvingut al Sifo!&lt;/h1&gt;
Arabic: &lt;h1&gt;<span dir="rtl">أهلاً بك إلى Sifo!</span>&lt;/h1&gt;
German: &lt;h1&gt;Willkommen bei Sifo&lt;/h1&gt;
Russian: &lt;h1&gt;Добро пожаловать на Sifo!&lt;/h1&gt;
</code></pre>
						{/literal}

						<p>Of course you can translate strings in controller, models or your own custom classes (see I18N Class). There is support for non-latin alphabets. We do
							have several installations in Russian, Arabic, Japanese, Chinese, Hebrew... so yes,
							and also design with RTL text.</p>
					</div>
				</div>

				<div class="row">
					<div class="span4 columns">
						<h3>Lazy Loading</h3>

						<p><strong>The less classes are in-memory, the better</strong>. We stick to the principle of loading
							the classes only if they are going to be used. The autoloader will do the job for you.</p>
						<p>There are a lot of classes available and interesting libraries ready to use. Just to solve
						common problems.</p>
						<p>You can even create several profiles of libraries: maybe you want to
							play with the latest unstable library in local, while keeping the stable one in production.
							That's defined in <code>libraries.config.php</code></p>
					</div>
					<div class="span8 columns">
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
					<div class="span8 columns">
						<h3>Multiple databases flavour</h3>

						<p>From <strong>Key-values</strong> like Redis to common RDBMS like Mysql, Postgres, Oracle, Firebird or even SQLite.
							You can choose to use Mysql PDO or any of the ADODB drivers. For redis, Predis
							is an excellent solution we use a lot.</p>
					</div>
					<div class="span4 columns">
						<img class="nomargin" src="{$url.static}/docs/databases.png" />
					</div>
				</div>
				<div class="row">
					<div class="span8 columns">
						<h3>Command Line support</h3>

						<p>Yes, you like to code your cron jobs in PHP, so do we. Take profit of your existing
							models. Create your scripts extending from the Command Line.
							The CLI tool lets you define the supported parameters of the script and automatically
							builds the help for you. If you are interested in receiving email reporting is also
							already done.</p>
					</div>
					<div class="span4 columns">
						<img class="nomargin" src="{$url.static}/docs/cli.png" />
					</div>
				</div>

				<div class="row">
					<div class="span8 columns">
						<h3>Dynamic/static distinction</h3>

						<p>You never know what is going to happen. Putting your static files in a different
							host is always a win-win decision. If your site grows you will be able to set
							up a CDN quickly. The <code>domains.config.php</code> file contains special entries
							to separate dynamic (PHP) from static files (CSS, images, media).
						</p>
					</div>
					<div class="span4 columns">
						<img class="nomargin" src="{$url.static}/docs/statics.png" />
					</div>
				</div>

				<h1>And more...</h1>

				<div class="row">
					<div class="span8 columns">
						<h3>Lots of helpful classes</h3>

						<p>Many projects share the same needs. Do you need to send nice emails? Geo-localise
							the users? Facebook/Youtube/Twitter integration? Quick searches using Sphinx? Upload
							files to Amazon S3? Do not reinvent the wheel, invest your time in something else.</p>

						<h3>Extendable</h3>

						<p>What would be the framework if you couldn't add our own classes and libraries?
							There is room for entire libraries, simple classes or <em>helpers</em>. Before coding
							something from scratch, ensure there is not something done already.</p>

						<h3>Tools, tools, tools</h3>

						<p>We do lot of tools and share it with others. From whole instances to deploy your sites in
						production, to simple scripts to ease administration or develop faster.</p>

						<h3>Yes, more...</h3>

						<p>It's just that I am tired of writing, it is late night. If you arrived
							here it's time to get a little bit deeper yourself guided by the documentation. It might
							be a little poor, if you'd like anything to be added or have suggestions, please <a href="https://github.com/inbox/new/alombarte">contact me</a> via GitHub.</p>
					</div>
					<div class="span4 columns">
						<img src="{$url.static}/docs/libraries.png" />
					</div>
				</div>

			</div>{*eof overview*}
		</section>
	</div>
</div>
{/block}
