Benchmark
=========================

The Benchmark Class allows you to measure the time passed between checks for any given PHP code. To make it work you only need to label the measurement with a a key and put the code in those places that mark the start or end of the benchmark:

Code example
-------------

Instance the Benchmark class, you must define the key name of your Benchmark (label) to start the timer:

        // Start timer
        \Sifo\Benchmark::getInstance()->timingStart( 'name_of_benchmark' );

                // Code that you want to measure

        // Get the current time value
        $time_generated = \Sifo\Benchmark::getInstance()->timingCurrent( 'name_of_benchmark' );
        
        echo "{INFO} Your Code took {$time_generated}s.";

Store the current time to `Registry`, accumulating partials:

        $time_generated = \Sifo\Benchmark::getInstance()->timingCurrentToRegistry( 'name_of_benchmark' );

Stop the timer when it is not needed anymore:
        
        \Sifo\Benchmark::getInstance()->timingStop( 'name_of_benchmark' );
