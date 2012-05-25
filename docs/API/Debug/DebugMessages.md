Adding custom content to Debug
===============================================
`DebugMessages` is a class that allows you to **store messages, variables or objects in the debug** for later inspection (after the page has been loaded).

In this first version all the messages are shown in the browser console (Chrome inspector, Firebug, etc.).

Since the messages are loaded in the debug, they won't be displayed on production. So freely, use this class instead of **var_dump** ;)

Usage
-----
Anywhere in your PHP code use this feature as follows:

    \Sifo\DebugMessages::log( 'This message will be shown in browser console.' );

__Output:__

![Simple example](<url:static>/docs/API/debugmessages_simple_example.png)

    $variable = 'Variable content';
    \Sifo\DebugMessages::log( $variable );

__Output:__

![Variable example](<url:static>/docs/API/debugmessages_variable_example.png)

    $variable_array = array(
        'first' => 'orange',
        'second' => 'pear',
        'totals' => array( 33, 22 )
    );
    \Sifo\DebugMessages::log( $variable_array );

__Output:__

![Array example](<url:static>/docs/API/debugmessages_array_example.png)
