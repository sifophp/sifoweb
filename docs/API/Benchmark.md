Benchmark
=========================

The Benchmark Class allows you to make an internal checks to get benchmark time for a given PHP code, how it works is really easy. Basically you need the key name of your benchmark that you decided:

Code example
---------------

Instantiating the Benchmark class, you must define the key name of your Benchmark to start the timer:

        // Start timer
        \Sifo\Benchmark::getInstance()->timingStart( 'name_of_benchmark' );

                // Code that you want to measure

        // Get the current time value
        $time_generated = \Sifo\Benchmark::getInstance()->timingCurrent( 'name_of_benchmark' );
        
        echo "{INFO} Your Code took {$time_generated}s.";

Stores the current time to registry to accumulate partials:

        $time_generated = \Sifo\Benchmark::getInstance()->timingCurrentToRegistry( 'name_of_benchmark' );

Stopping timer when we doesn't need any more
        
        \Sifo\Benchmark::getInstance()->timingStop( 'name_of_benchmark' );
