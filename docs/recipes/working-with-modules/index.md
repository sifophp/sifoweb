Recipe: Working with Modules and Real Time Replacement
=========================

> SIFO provides the capacity to work with modules, it’s mean that you can configure your landing in different parts of code , independent of each other. Each module will have his own controller and view but all of them will be printed on the same template, with his own controller.

Making a Landing with modules
-----------------------------------------

In the container controller you need to add the modules that you will use:

        $this->addModule('head', 'HeadModule');
        $this->addModule('content', 'ContentModule');

Then in the container template, you will need to include all the module, not only the view !

        {$modules.head}
        {$modules.content}


### Oh wait! where is the problem? ###

Cache Management. If you are working with different modules, each module has his own cache then if a module is used in many ocasions he will use the last one and you can't control which is and his behavior.

If I want to keep the different modules with independent cache?

Real Time Replacement
-----------------------------------------

> Real Time replacement is a SIFO tool that allows you to use all the guarantees of working of Modules and add the benefit of that module will execute after that the container controller and template are rendered. Then execute your Module and replace it on the landing!

The only think that you need to include in this case is in the parent template:

        <!-- REPLACE:LogUserBox -->

You can comunicate the container controller with the replaced controller adding variables: 

       <!-- REPLACE:LogUserBox::$var1::$var2 -->
   
And you can receive them in the controller with:

        $this->getParam(‘params’);


Including different views
-----------------------------------------
Smarty provides the option to include a view in the container template, but this option needs that tou add all the necessary logic and assign variables in your controller. 
 
        {include file='footer.tpl'}
