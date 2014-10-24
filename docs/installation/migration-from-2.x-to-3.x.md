Migration from version 2.x to 3.x
=================================
With Sifo 3 there is a move to Composer usage. This requires a few adjustments to be done in your instance as well as some changes in the way of working.

### Pre-requisites
The first thing you need to do is clone the sifo-app [https://github.com/sifophp/sifo-app] so you can see how Sifo works now.
Once is cloned do a `composer install` 

### Changes in your instance
- Replace all the code that references to the path `libs/` to `vendor/sifophp/sifo/src/`
- In your dispatcher (`public/root/index.php`) change the path of Bootstrap class to: `require ROOT_PATH . '/vendor/sifophp/sifo/src/sifo/Bootstrap.php';`
- Same thing if you have command line scripts with `CLBootstrap`
- Replace all calls to `instances/common`with `vendor/sifophp/sifo-common-instance`
- Delete Smarty compiles before going live.

### Putting all together

At this point you can put your instances folder inside the directory structure as usual or you can add it as another composer dependency.
If you want your instance to be just another dependency you only need to write inside your instance `composer.json` the following content:

    {
        "name": "yourcompany/yourinstance",
        "description": "What is your instance",
        "keywords": [],
        "homepage": "https://github.com/yourcompany/yourinstance",
        "type": "sifo-instance"
    }

The important part is that there is a new `type: sifo-instance` that will install your code in the instances folder.

**Important**: The name of the repo will match the name of the instance.


