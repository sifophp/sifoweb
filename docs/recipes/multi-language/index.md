Translating Websites With SIFO
===============================================
> SIFO provides a solution to translate website to different languages really easy way.

 **SIFO doesn't translate any text for you, You need to define a "key", that it will be the same text with the default language of your website. Then you must assign the correct translation for each language in the SIFO web Interface. It's looks complicated but with an example it will be more simple.** 
 
We are supposing that you know how to use multilanguage in SIFO, but you need to know how works:

Each website loaded consults to `domains.config` which is his language defined, then it looks for to the folder `./locale` the differents messages files that exists to load tha language, if the language not exists it leaves the default language. One example of the messages file will be: `messages_es_ES.php`, but don't worry about his file, SIFO creates it for you! 

In the example we could see that with SIFO Web Interface you will generate this files `messages`.

Let's see by parts the example:


View
------------------------------

We need to define to the template which keys we want to translate, for this reason we will use the tag {t}:     			

    {t}Other reviews for this article{/t}

Beware HTML tags, which also are the definition of the key! You must also define scape option to off.

	{t scape=off}Other reviews for this <strong>article</strong>{/t}

But in some times we will need to replace a word for a some variable, it works different that the common smarty:

	{t 1=$category}You can enter to: %1{/t}

If SIFO doesn't locate the translation of your language web (or doesn't find the key), it will not replace the key, and the website will show the default language of your project, the key message.


SIFO Web Translate Interface
------------------------------

First you need to enter to the interface, it will be in: `http://your.domain/translate`.
You could see something like the next image. We have some different information, the current status of your app: how many languages you have, and the percentage of complete translation.

![Simple example](<url:static>/docs/translate.png)

Basically we only have three actions:

1. Rebuild Translations: Generate all the necessary files to apply the translation.

2. Add Message: Add the message key in every language.

3. Select a language: Will show all the messages, the translations for this language. At the top it will show the messages that haven't the translation yet.

![Simple example](<url:static>/docs/language.png)

3.1. Save: Saves the corresponding message to each the key for this language.

*We always add messages first and rebuild translations next, in the opposite case SIFO can't detects the change! But we don't need to rebuild translations for every message that we introduce, you just need to rebuild in the last one.*
	
