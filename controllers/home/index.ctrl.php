<?php

/**
 * Simple controller for the homepage.
 */
class HomeIndexSifowebController extends SharedFirstlevelSifowebController
{
	public function buildChild()
	{
		$this->setLayout( 'home/index.tpl' );
	}
}