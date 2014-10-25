Crypt
=====
> Simple 2-way string obfuscator. This class allows you to transform a string like `abcd` into something like `0t+J17zmtM7RoM` and then revert it back to `abcd`. Use it wisely, never for sensitive data.

The class `Crypt` is two way encrypt/decrypt class. It does not require any additional PHP modules installed.

The way it works is very simple: It is based on a base64 encoding plus a mixed seed. Meaning that this class **SHOULD NOT** be used to store passwords or any other sensitive data whatsoever!. If you want to save passwords, use **hashing instead**, because a hash cannot be reversed back.

### Purpose

The name `Crypt` might lead you to confusion and it should be renamed by us, but since there are many implementations around we have kept the old name (not an excuse, we know. Maybe too lazy?). A more clarifying name could be `Obfuscator` or something similar.

So, the purpose is to obfuscate strings and present the things in a less obvious way. The most common usage is to **blur strings and keep them away from curious people**. E.g: Database identifiers, URL strings.

There are 2 different usages:

* The string will be used in a URL
* The string will NOT be used in a URL

If you have to place the crypted string in an URL, use the `encryptForUrl`, while if you don't need it, use just `encrypt`. The difference between the two is that the first removes special characters like `/` or `+` that might lead to wrong decrypt.

### Example
Copy and paste this to test how it works.

	// Init encryption seed before anything else:
	\Sifo\Crypt::$seed = 'ThisIsMyBlurSeed';
	
	$email = 'email@domain.com';
	
	// When the string won't be used in a URL:
	$crypted_email = \Sifo\Crypt::encrypt( $email );
	
	// Outputs: ycHJ0t+J17zmo9XjoLbU0g==
	echo $crypted_email; 

	// Now, decrypt the email:
	$email = \Sifo\Crypt::decrypt( $crypted_email );
	echo $email;

	// If you need to send the string over URL then use this instead:
	$crypted_email = \Sifo\Crypt::encryptForUrl( $email );
	
	// Outputs: ycHJ0t-J17zmo9XjoLbU0g==
	echo $crypted_email;
	
	$email = \Sifo\Crypt::decryptFromUrl( $crypted_email );
	echo $email;
	
That's it. And remember, do not store passwords with this although is very tentative to be able to revert them ;)
