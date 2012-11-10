Storing passwords
=================
> The `Password` class helps you hash the passwords in a very secure way.

The most common technique to store passwords I've seen around is to store passwords using a MD5 or a SHA-1 hash with
a site-wide salt. If you are using this technique and someone ever sees your code, be prepared for an attack using rainbow tables.
If somone has your SALT, then it might have all the passwords.

    // Very bad idea!
    $hash = sha1( $salt . $password );
    $hash = md5( $salt . $password );

There is people who encrypts passwords instead of hashing them. This is also a bad idea, because the process is reversible.

The `Password` class is based on the fantastic [Openwall]'s "Portable PHP password hashing framework" and uses the
OpenBSD-style **Blowfish**-based bcrypt as preferred hashing algorithm. Every hash has not relation with any other hash, there is no
common salt, and generates a different Hash every time, even if you want to hash the same string over and over.

 [Openwall]: http://openwall.com/phpass/

### Example of hash generation and validation
Your database should have a field to store the password's hash (and nothing else). When the user tells you what is the password
do this:

    $password = 'Aw€s0m€';
	$pass = new \Sifo\Password;

    $hash = $pass->getHash( $password );
    // Store this:
    echo $hash;

Then, when a user POSTs the form to log in:

        // Get the hash from the database:
        $model = new \Sifo\Model();
		$hash = $model->GetOne( 'SELECT hash from registered_users where email=?', array( $email ) );

        $post = \Sifo\FilterPost::getInstance();
		$pass = new \Sifo\Password;
		if ( $hash && $pass->isValid( $post->getString( 'pass' ), $hash ) )
		{
			echo 'Good password';

		}
		else
		{
			echo 'Bad password';
		}

Now it would be a very good idea to generate the hash again, and store it back in the database, so it changes in every login.