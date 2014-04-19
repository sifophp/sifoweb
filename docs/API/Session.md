Session
=========================

Sifo provides its own class to manage `$_SESSION` and wraps the core functionalities of the session and is a replacement of the direct access to the variable `$_SESSION`. This class does not take into account the kind of storage you are using, it relies on the internal session handler configured in the php.ini.

Method sumary:
--------------
        
Write values of a session key ( key, value)

        \Sifo\Session::getInstance()->set( 'id_user', $id_user );

Read values of a session key

        $id_vertical = \Sifo\Session::getInstance()->get( 'id_user' );

Get Id of the current session, return null if doesn't exist

        \Sifo\Session::getInstance()->getId();

Resets the session, destroy it and starts it again

        \Sifo\Session::getInstance()->reset();

Ends the current session and store session data

        \Sifo\Session::getInstance()->writeClose();

Sets expiration time to the session

        \Sifo\Session::getInstance()->setExpirationTime( $time );

Deletes a session key of the session

        \Sifo\Session::getInstance()->delete( 'id_user' );

Destroy the session

        \Sifo\Session::getInstance()->destroy();
