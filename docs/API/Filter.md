Filter
=======


Although PHP provides the native form to receive parameters, SIFO has Filter class that filters the request array checking that the values accomplish the given filters. 


There are some class that extends Filter Class, like FilterPost, FilterGet, FilterRequest, FilterServer, FilterCookie, FilterSession, FilterFile, FilterCustom, FilterException.


It DOES NOT modify the original value. Use SANITIZE filters for that purpose.


This is an example receiving a form using POST and using FilterPost class:


    $filterPost = \Sifo\FilterPost::getInstance();

    if ( $filterPost->isSent( 'submit' ) )
    {
                $values['name']     = $filterPost->getString( 'name' );
                $values['visitors'] = $filterPost->getInteger( 'visitors' );
                $values['amount']  	= $filterPost->getFloat( 'amount' )
    }

This class allow to us receive and filter all kinds of information:

Method Sumary:
-------------------------


|| Name                |   params     |    Function    |   Return              
| ------------- |:-------------:| ---------------:|  ---------------:|
| isSent        | $var_name | Detects if the variable has been send                             | Boolean |
| countVars     | -         | Return the number of variables that has been send                 | Integer |
| getString     | $var_name, $sanitized = false | Return this id like a String                  | String |
| getArray    | $var_name, Array $list_of_elements | Return this id like an Array                | Array |
| getArrayFromSerialized |   $var_name, $filter_function = null | Return this id like a Serialized Array | Array |
| getBoolean    | $var_name | Return this id like a Email                                       | Boolean |
| getDate       | $var_name, $format = 'd-m-Y' |Return this id like a Email                     | Date |
| getEmail      | $var_name, $check_dns = false | Return this id like a Email                   | Email |
| getFloat      | $var_name, $decimal = null |  Return this id like a Boolean                   | Float |
| getInArray    | $var_name, Array $list_of_elements | Return a specific element of an Array    | element of Array |
| getInteger    | $var_name, $min_range = null, $max_range = null | Return this id like a Integer | Integer |
| getIP         | $var_name, $min_range = null, $max_range = null | Return this id like an IP   | (IP) |
| getRegexp     | $var_name, $regexp | Return this id like a Regexp                             | (Regexp) |
| getUnfiltered | $var_name |                                                                   | Elements |
| getUrl        | $var_name | Return this id like a Url                                         | URL |