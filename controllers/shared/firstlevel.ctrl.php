<?php
namespace Sifoweb;

abstract class SharedFirstlevelController extends \Sifo\Controller
{

	final public function build()
	{
		$this->buildChild();

		$this->addModule( 'header', 'SharedHeader' );
		$this->addModule( 'head', 'SharedHead' );
		$this->addModule( 'footer', 'SharedFooter' );

		$namespace = preg_quote( 'Sifoweb\\' );
		$this->assign( 'ctrl', preg_replace( "/$namespace(.*)Controller/i", '$1', get_class( $this ) ) );

	}

	abstract public function buildChild();

}