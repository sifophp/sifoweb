{extends file=$_tpls['layout/basic.tpl']}

{block name='content'}
<div class="container">{* Use container-fluid class for non-fixed layout*}
		<section id="{$section}">
			<div class="row"> 
				<div class="span11 columns"> 
{					if isset($content)}{$content}{/if}
{					if isset($is_dir)}
					<h1>{$path}</h1>
{					/if}
				</div>
				<div class="span5 columns"> 
					<h2>Documentation</h2>
					<p>Explore the documentation</p>
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
			  </div><!-- /row -->
		  </section>
</div> {* EOF .container *}
{/block}
