Creating instances
==================
Creating a new instance is a straightforward process. The only thing you need to do is to create the directory tree under the `instances` folder. There is a simple script that executes all these `mkdirs` for you (Linux/Mac/*Nix).

Creating the instance tree
--------------------------
The instance tree is the directory tree that stores all the controllers, models, templates and other files for your application. You can populate this tree by using the provided script, or by hand creating the directories one by one.

### Using the script ###
Using the *automated script*, all you have to do is to **open the terminal** and go to `/path/to/your/sifo` and execute the script. This script is very simple and uses basic terminal comands such as copy or make dir. This is what you have to launch:

	cd scripts
	chmod +x create_instance.sh
	./create_instance.sh myproject myproject.local
	
In the last line, there are 2 parameters:

1. Project/instance name
2. DNS used to develop locally (usually a fake one)

The instance name is the parameter `myproject` in the example and `myproject.local` is the DNS (production could be myproject.com). Rules:

* Keep both parameters in **lowercase format**
* For the instance name use only letters, numbers (but never at the beginning) or underscore `_`. Keep it `[a-z0-9_]`
* The DNS should have a valid format, although there is nothing stopping you using a top level domain fake as `.local`, `.devel`, `.vm` or any other that you might like.

### Manually creating the dirs ###
If you are a Windows user or just love to type, create the following dirs:

	instances/myproject/
	instances/myproject/classes
	instances/myproject/config
	instances/myproject/controllers
	instances/myproject/public
	instances/myproject/public/root
	instances/myproject/public/static
	instances/myproject/locale
	instances/myproject/models
	instances/myproject/templates
	instances/myproject/templates/_smarty/
	instances/myproject/templates/_smarty/cache
	instances/myproject/templates/_smarty/compile
	instances/myproject/templates/_smarty/configs

Then copy the files in `default/config/*` to `myproject/config/`. Next make writeable the folders `cache` and `compile` contained inside `myproject/templates`.



Starting your project
---------------------
Once the script has finished creating dirs, the `_smarty` folders are writeable (script should have done so), you should add `myproject.local` or whatever name you choose to your `/etc/hosts` file (in `windows/system32/etc/drivers` for MS lovers). So when you visit the domain resolves to the proper IP.

Then, [configure apache] to point to the new created project and finally visit the URL: <http://myproject.local/rebuild> to automatically prepare all the configuration files ready with your new project.

[configure apache]: /installation/apache-virtualhosts
