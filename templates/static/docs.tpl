{extends file=$_tpls['layout/basic.tpl']}

{block name='content'}
<div class="container" id="documentation">{* Use container-fluid class for non-fixed layout*}
		<section id="{$section}">
			<div class="row">
				<div class="span11 columns">
{					if isset($content)}{$content}{/if}
				</div>
				<div class="span5 columns">
					<div  id="navigation_box">
						<h2>Navigation</h2>
						<p>You are here: <em>{$path|ucfirst}</em></p>
						<nav>
						<ul>
	{					foreach from=$docs item=d}
							<li><a href="{$url.base}/{$d}">
									{if $section==$d}<strong>{$d|ucfirst}</strong>{else}{$d|ucfirst}{/if}
								</a></li>
	{					/foreach}
						</ul>
						</nav>
					</div>
				</div>
			  </div><!-- /row -->
		  </section>
</div> {* EOF .container *}
{/block}
