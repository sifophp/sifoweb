<?php
namespace Sifoweb;

abstract class SharedFirstlevelController extends \Sifo\Controller
{

	final public function build()
	{
		// Static items shown in the top bar and in the footer:
		$params['menu_items'] = array(
			'installation',
			'quick-start',
			'API',
			'download',
			'community'
		);

		// Propagate additional parameters to children:
		$this->addParams( $params );

		$this->buildChild();

		$this->addModule( 'header', 'SharedHeaderFooter' ); // Footer and Header use the same module.
		$this->addModule( 'head', 'SharedHead' );
		$this->addModule( 'footer', 'SharedHeaderFooter' );

		$namespace = preg_quote( 'Sifoweb\\' );
		$this->assign( 'ctrl', preg_replace( "/$namespace(.*)Controller/i", '$1', get_class( $this ) ) );

	}

	abstract public function buildChild();

}