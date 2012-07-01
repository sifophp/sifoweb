<?php
namespace Sifoweb;

class SharedHeaderController extends \Sifo\Controller
{

	final public function build()
	{
		// Static items shown in the top bar:
		$menu_items = array(
			'quick-start',
			'API',
			'download',
		);

		$this->setLayout( 'shared/header.tpl' );
		$params = $this->getParams();
		$path = explode( '/', $params['path'] );
		$section = array_shift( $path );
		$this->assign( 'section', $section );
		$this->assign( 'menu_items', $menu_items );

	}

}