Installation of SIFO
====================
To install SIFO in your webserver these are the basic steps you need to follow:

 * [Download] the code if you still haven't done it.
 * Configure Apache with the proper virtual hosts
 * To develop locally, Create a new hosts entry under `/etc/hosts` (Linux and Mac). E.g: `myproject.dev`
 * Create your own instance (Bash script under `scripts` folder)
 * Add write permissions to templates/_smarty
 * Edit your domains in the file domains.config.php with the host you added
 * Rebuild (url: `/rebuild`)