<?php
namespace Sifoweb;

/**
 * Simple controller for the homepage.
 */
class HomeIndexController extends SharedFirstlevelController
{
	public function buildChild()
	{
		$this->setLayout( 'home/index.tpl' );
	}
}