<?php

include ROOT_PATH . '/instances/sifoweb/external/PHP_Markdown_Extra_1.2.4/markdown.php';

class StaticMarkdownSifowebController extends SharedFirstlevelSifowebController
{

	const DOCS_LIST_CACHE_KEY = 'list_of_markdown_docs_and_folders__';
	
	protected $docs_path = '/instances/sifoweb/docs/';

	public function buildChild()
	{
		$this->setLayout( 'static/docs.tpl' );
		$params = $this->getParams();
		$path =  $params['path'];
		$docs_list = $this->getDocsList( $path );
		

		// Is a valid path
		if ( in_array( $path, $docs_list ) )
		{
			$file = ROOT_PATH . $this->docs_path . $path;
			
			// Show dir contents instead of markdown:
			if ( !is_dir( $file ) )
			{
				$file .= '.md';
				$markdown_content = file_get_contents( $file );
				$content = Markdown( $markdown_content );
				$this->assign( 'content', $content );
			}
			else
			{
				$this->assign( 'is_dir', true );
			}
				
			$this->assign( 'section', $path );
			$this->assign( 'docs', $docs_list );
			$this->assign( 'path', $path );
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
			$parse_folder = ROOT_PATH . '/instances/sifoweb/docs';
			$dir = $this->getClass( 'DirectoryList' );
			$files = $dir->getRecursiveList( $parse_folder, true, array( 'md' ) );
			
			$paths = array( );
			foreach ( $files as $path => $file )
			{
				// Leave the relative path after $parse_folder and remove extension:
				if ( $file->isDir() )
				{
					$paths[] = str_replace( ROOT_PATH . $this->docs_path, '', $path );
				}
				else
				{
					$paths[] = substr( str_replace( ROOT_PATH . $this->docs_path, '', $path ), 0, -3 );
				}
			}
			// Store full dir scan for 5 minutes.
			$cache->set( self::DOCS_LIST_CACHE_KEY, $paths, 300 );
		}

		return $paths;

	}

}