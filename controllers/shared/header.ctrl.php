<?php

class SharedHeaderSifowebController extends Controller
{

	final public function build()
	{
		// Static items shown in the top bar:
		$menu_items = array(
			'download',
			'API'
		);
		
		$this->setLayout( 'shared/header.tpl' );
		$params = $this->getParams();
		$this->assign( 'path', $params['path'] );
		$this->assign( 'menu_items', $menu_items );

	}

}