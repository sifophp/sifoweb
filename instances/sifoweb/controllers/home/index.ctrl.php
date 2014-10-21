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
		$this->assign( 'recent_commits', $this->getRecentCommits( 'alombarte', 'SIFO', 'master' ) );
	}

	/**
	 * Loads recent commits from Github.
	 *
	 * @param $user Github user.
	 * @param $repo Github repo.
	 * @param $branch Git branch
	 * @return bool|object
	 */
	protected function getRecentCommits( $user, $repo, $branch )
	{
		$stream_context = stream_context_create( array(
				'http' => array(
					'timeout' => 5
				)
			)
		);

		$xml = file_get_contents( "https://github.com/$user/$repo/commits/$branch.atom", 0, $stream_context );
		if ( !empty( $xml ) )
		{
			$atom = simplexml_load_string( $xml );
			if ( !count( $atom ) )
			{
				return false;
			}

			$commits = array();
			$i=0;
			foreach( $atom->entry as $entry )
			{
				$i++;
				$commits[] = array(
					'link' => (string) $entry->link['href'],
					'title' => (string) $entry->title,
					'updated' => strtotime( (string)  $entry->updated),
					'author' => (string) $entry->author->name,
					'author_url' => (string) $entry->author->uri,
				);

				if ( $i > 5 )  break ;
			}
			return $commits;
		}

		return false;
	}

	public function getCacheDefinition()
	{
		return array(

		);
	}
}