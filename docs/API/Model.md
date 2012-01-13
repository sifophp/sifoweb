Model class. Multiple database library
======================================
The Model is intended mainly (but not only) for database operations. Depending on how you'd like to work you can use one type of Model or another. Basically these are the options you have when working with models:

* Extending from the `Model` class means you want to use the **multi-driver** database **library [ADODB]** (postgres, mysql, oracle...).
* Extending from the `MysqlModel` means you want to use **Mysql only** via the native Mysql PDO (you don't need additional RDBMS)
* Extending or using `RedisModel` means that you want to connect to the Key-value Redis system via **Predis**.

Of course your application can have models extending from different classes and use all the power together.

**If you are a Mysql-only guy you'll probably want to use `MysqlModel` instead of `Model`. This page talks only about the `Model` class (multidriver)**

If, on the contrary, your application is using a distinct RDBM than Mysql (see supported databases) this is the class you have to extend from.

How it works (`Model` only)
---------------------------
**Requisites:** To extend directly from the `Model` class you will need to have the class included first. To do so you only need to include the Model in your `config/libraries.config.php` file. Then you will be able to extend from Model without including by hand the model.

When you extend your model from this class you are using internally the **ADODB library** and all the DB-related functions that you call are passed directly to the [ADODB] library.

The SQLs are prepared automatically so you don't need to worry on escaping.

These are some examples on how to perform queries:

	// Return ONE row (limit 1) from the query:
	$this->GetRow( 'SELECT * FROM users where email=? and paswrd=?', array( $email, $pass ) );

	// Return all the rows of a query:
	$this->getAll( 'SELECT * FROM...' );
	$this->getArray( 'SELECT * FROM...' ); // Same flavour function

	// Return one column and recordset from the query:
	$this->getOne( 'SELECT status FROM users where email=?', array( 'sample@domain.com' ) );
	

All this queries will be shown in the Debug, with a generic title so you can easily identify where the query comes from. But if you want to set a **custom title for the debug** just add the *tag* element in the parameters array. For instance:

	$query ='SELECT api_key FROM users where email=? and token=?';
	
	$this->GetRow( $query, array( $email, $token, 'tag' => 'Retrieve API key for user ' . $email ) );

In the example above you would see in the debug the text "Retrieve API key for user john@doe.com"


Avoiding duplicate queries
--------------------------
To prevent **duplicated queries** to the database in the same thread we have linked the `Registry` class to Model, so you can store in memory the recordsets and re-use them later in another class in the same execution thread. If you need long term caching then use the `Cache`class. These methods are for interaction with the registry:

* inRegistry( $key )
* storeInRegistry( $key, $value )

###inRegistry( $key )###
Returns an element in the registry if present with the given `$key`. Otherwise returns false. Obviously you shouldn't use the registry for storing just the boolean value "false" :)

###storeInRegistry( $key, $value )###
Stores in the registry (memory) a value with the given `$key`.

**When SHOULD I use the inRegistry and storeInRegistry methods?** If you think a query can be executed twice or more in the same page load than you should keep it in memory (registry) instead of connecting to the database again. Through the use of the registry you can call the same model in different controllers but the query will be only executed once.

#### Example scenario for registry usage####
Imagine your application interacts a lot with the logged user and you have several other files that require this user data several times to complete their operations. Let's say your user's data is stored in some Model's function called getData().

Now, you have 5 additional files that need access to the userData and hammer the database constantly. Why would you query again the database if 2 miliseconds ago you already had that information?

This is an approximation of what you could do to avoid this:

	public function getData( $user_id, $token )
	{
		// You need a unique KEY to keep this data in memory.
		$registry_key = self::REGISTRY_USER_GET_DATA . $user_id . $token;
	
		// Is the query already in memory?
		if ( $user_data = $this->inRegistry( $registry_key ) )
		{
			// Yes, no need to relaunch the query. Return the data.
			return $user_data;
		}
		
		// No, first time asked. Fetch from database:
		$query = 'SELECT fields FROM user_accounts WHERE userid=? and token=? and ...'
		
		if ( $user_data = $this->GetRow( $query, array( $user_data, $token ) ) )
		{
			// Now save the information in the Registry so is not taken again from DB
			$this->storeInRegistry( $registry_key, $user_data );
			return $user_data;
		}

		return false;
	}

Supported databases
-------------------
The aim of the class `Model` is to support **multiple database drivers**. It has been very common for us in the past to connect to several *unknown* databases and ADODB gave us a common interface to connect them all. A **non-complete** full list of supported databases is here:

* MySQL
* Oracle
* SAP
* Postgres
* SQLite
* Microsoft SQL Server
* Microsoft Access/Jet
* LDAP
* Generic ADO
* Generic PDO
* Generic ODBC
* DB2
* Microsoft Visual FoxPro
* FrontBase
* Interbase 6 or earlier
* Firebird version of interbase.
* Borland version of Interbase 6.5 or later
* Informix
* Sybase
* Netezza
* Sybase SQL Anywhere

See the [ADODBdriver] [list of drivers] for further detail.

[ADODB]: http://phplens.com/lens/adodb/docs-adodb.htm
[ADODBdriver]: http://phplens.com/lens/adodb/docs-adodb.htm#drivers "List of supported ADODB drivers"