<?php
namespace Sifoweb;

include ROOT_PATH . '/instances/sifoweb/external/PHP_Markdown_Extra_1.2.4/markdown.php';

class StaticMarkdownController extends SharedFirstlevelController
{

	const DOCS_LIST_CACHE_KEY = 'list_of_markdown_docs_and_folders__';

	protected $docs_path = '/instances/sifoweb/docs/';

	public function buildChild()
	{
		$this->setLayout( 'static/docs.tpl' );
		$params = $this->getParams();
		$path = $params['path'];
		$valid_paths = $this->getPossiblePaths( $path );



		// Is a valid path
		if ( in_array( $path, $valid_paths ) )
		{
			$file = ROOT_PATH . $this->docs_path . $path;

			// Show dir contents instead of markdown:

			if ( is_dir( $file ) )
			{
				$file .= '/index';
			}

			$markdown_content = file_get_contents( $file . '.md' );
			// Substitute all <url:xxxx> entries with its corresponding URL:
			$markdown_content = preg_replace_callback( '/\<url\:([a-z0-9]+)>/', array( $this, 'getUrlByKey' ), $markdown_content );

			$content = Markdown( $markdown_content );

			$has_title = preg_match( '#<h1>(.*)</h1>#', $content, $matches );
			if ( $has_title )
			{
				$this->getClass( 'Metadata', false );
				\Sifo\Metadata::setKey( 'markdown_docs' );
				\Sifo\Metadata::setValues( 'title', $matches[1] );
			}

			$this->assign( 'content', $content );

			$dir = new \Sifo\DirectoryList();
			// Get only immediate items, not the whole tree:
			$docs = $dir->getList( dirname( $file ), array( 'md' ) );

			$path = explode( '/', $path );
			$this->assign( 'docs', $this->_formatFilesForMenu( $docs ) );
			$this->assign( 'path', $path );
			$section = array_shift( $path );
			$this->assign( 'section', $section );

		}
		else
		{
			throw new \Sifo\Exception_404( 'No markdown file is associated to this path, yet?' );
		}

	}

	/**
	 * @param $matches
	 * @return mixed
	 */
	private function getUrlByKey( $matches )
	{
		$params = $this->getParams();
		return $params['url'][$matches[1]];
	}

	protected function getPossiblePaths()
	{
		$cache = \Sifo\Cache::getInstance();
		$paths = $cache->get( self::DOCS_LIST_CACHE_KEY );


		if ( false === $paths )
		{
			$parse_folder = ROOT_PATH . '/instances/sifoweb/docs';
			$dir = new \Sifo\DirectoryList();
			$files = $dir->getRecursiveList( $parse_folder, true, array( 'md' ) );
			$paths = $this->_formatFilesForMenu( $files );

			// Store full dir scan for 1 minute.
			$cache->set( self::DOCS_LIST_CACHE_KEY, $paths, 60 );
		}

		return $paths;

	}

	private function _formatFilesForMenu( \Iterator $files )
	{
		$paths = array( );
		foreach ( $files as $path => $file )
		{
			$relative_path = str_replace( ROOT_PATH . $this->docs_path, '', $path );

			// Leave the relative path after $parse_folder and remove extension:
			if ( $file->isDir() )
			{
				$paths[] = $relative_path;
			}
			else
			{
				// Ignore index.md files, this is the content mapped with the folder:
				if ( !preg_match( '/index\.md$/', $relative_path ) )
				{
					$paths[] = substr( str_replace( ROOT_PATH . $this->docs_path, '', $path ), 0, -3 );
				}
			}
		}

		return $paths;

	}

}