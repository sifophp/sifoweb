Session
=========================

Sifo provides his own class to manage $_SESSION, this class wants to wrap the core functionalities of the session.

Method sumary:
------------------
        
Write values of a session key ( key, value)

        \Sifo\Session::getInstance()->set( 'id_user', $id_user );

Read values of a session key

        $id_vertical = \Sifo\Session::getInstance()->get( 'id_user' );

Get Id of the current session, return null if not exists

        \Sifo\Session::getInstance()->getId();

Reset the session, destroy and starts again

        \Sifo\Session::getInstance()->reset();

Ends the current session and store session data

        \Sifo\Session::getInstance()->writeClose();

Set Expiration time to the session

        \Sifo\Session::getInstance()->setExpirationTime( $time );

Delete a session key of the session

        \Sifo\Session::getInstance()->delete( 'id_user' );

Destroy the session

        \Sifo\Session::getInstance()->destroy();
