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

	}

	abstract public function buildChild();

}