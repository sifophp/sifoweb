Headers
=======
> The `Headers` class manages headers sent to the browser

There are 2 different methods to set headers:

 * The status headers are sent via `setResponseStatus()`
 * Rest of headers are sent via `set()` method

The headers are stacked and are not sent to the browser until the controller has finished the execution and right before the
`echo` of the content. If you need to write the headers right away you can force the `\Sifo\Headers::send()` anytime.

Example of usage:

    \Sifo\Headers::set( 'Content-Type', 'application/json' );
	\Sifo\Headers::set( 'Cache-Control', 'public, must-revalidate, max-age=0, s-maxage=30' );

All the activity with headers is logged and shown in the Debug:

![Simple example](<url:static>/docs/API/debugheaders.png)