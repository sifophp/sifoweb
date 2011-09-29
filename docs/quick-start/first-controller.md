Your first controller
=====================
When you explore the controllers for first time you should have a look at the file `instances/default/controllers/home/index.ctrl.php` or grab a copy of the instance `sifo-web` that powers this site (see the footer for source code) and then explore what is done. The minimum layout to run a controller is the following:

	class HomeIndexController extends Controller
	{
	        public function build()
	        {
	                $this->setLayout( 'home/index.tpl' );
	        }
	}
	
If you create a new controller in your instance then you need to add your instance name (upper case first) before the controller word in the declaration class. For example, if you created the instance `myinstance` and you want to create your own custom version of this same file, it would look like:

	class HomeIndexMyinstanceController extends Controller
	{
	        public function build()
	        {
	                $this->setLayout( 'home/index.tpl' );
	        }
	}

This is necessary on PHP prior to 5.3, because there are no `namespaces` available. Whenever you create a controller you have to execute the URL http://myinstance.local/rebuild to tell the application there is a new file available in the code. SIFO will never do `file_exists` because is a performance killer, that's the programmer responsability.

Finally the `setLayout()` method defines what template will be used (as starting template, many others can be contained in it). The route is relative to the `templates` folder.