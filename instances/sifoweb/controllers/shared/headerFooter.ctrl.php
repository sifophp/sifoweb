<?php
namespace Sifoweb;

class SharedHeaderFooterController extends \Sifo\Controller
{

	final public function build()
	{
		$params = $this->getParams();

		$this->setLayout( "shared/{$params['module_name']}.tpl" );
		$path = explode( '/', $params['path'] );
		$section = array_shift( $path );
		$this->assign( 'section', $section );
		$this->assign( 'menu_items', $params['menu_items'] );

	}

}