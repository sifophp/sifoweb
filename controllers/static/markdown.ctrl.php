<?php

include ROOT_PATH . '/instances/sifoweb/external/PHP_Markdown_Extra_1.2.4/markdown.php';

class StaticMarkdownSifowebController extends SharedFirstlevelSifowebController
{

	const DOCS_LIST_CACHE_KEY = 'list_of_Markdown_Docs';

	public function buildChild()
	{
		$this->setLayout( 'static/docs.tpl' );
		$params = $this->getParams();
		$path =  $params['path'];

		$docs_list = $this->getDocsList();
		$this->assign( 'docs', $docs_list );

		if ( in_array( $path, $docs_list ) )
		{
			$markdown_content = file_get_contents( ROOT_PATH . '/instances/sifoweb/docs/' . $path . '.md' );

			$this->assign( 'section', $path );
			$this->assign( 'content', Markdown( $markdown_content ) );
		}
		else
		{
			throw new Exception_404( 'No markdown file is associated to this path, yet?' );
		}

	}

	protected function getDocsList()
	{
		$cache = Cache::getInstance();
		$paths = $cache->get( self::DOCS_LIST_CACHE_KEY );

		if ( false === $paths || $this->hasDebug() )
		{
			$dir = $this->getClass( 'Dir' );
			$files = $dir->getFileListRecursive( ROOT_PATH . '/instances/sifoweb/docs' );

			$paths = array( );
			foreach ( $files as $key => $file )
			{
				$paths[] = substr( $file['filename'], 0, -3 );
			}
			// Store file scan 5 minutes.
			$cache->set( self::DOCS_LIST_CACHE_KEY, $paths, 300 );
		}

		return $paths;

	}

}