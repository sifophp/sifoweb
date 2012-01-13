Crypt
=====
The class `Crypt` is a simple way to encrypt/decrypt a string without any PHP modules installed. The process is very simple, and it's based on a base64 encoding plus a mixed seed. The class `Crypt` should be renamed, but since there are many implementations around we keep the old name. A more clarifying name could be `Obfuscator` or something similar.

**This class is not hacker proof** and you should not use it to store passwords or any other sensitive data. We usually use it to **blurs strings and keep them away from curious people**. E.g: Identifiers, action names and so on...

Usage:

    use \Sifo\Crypt as Crypt;
    // ...

	// Init encryption seed before anything else:
	Crypt::$seed = 'ThisIsMySecret';

	$email = 'email@domain.com';
	$crypted_email = Crypt::encrypt( $email );
	echo $crypted_email; // Outputs: 2cHJ0t+J17zmtM7RoMjjwQ==

	// Decrypt the email:
	$email = Crypt::decrypt( $crypted_email );
	echo $email;
	
That's it. And remember, do not store passwords with this although is very tentative to use it to cypher and decypher strings.