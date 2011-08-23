{extends file=$_tpls['layout/basic.tpl']}
<div class="container">{* Use container-fluid class for non-fixed layout*}
{block name='content'}
		<section id="{$section}">
			<div class="row"> 
				<div class="span11 columns"> 
				 
					{$content}
				</div>
				<div class="span5 columns"> 
					<h2>Documentation</h2>
					<p>Explore the documentation</p>
					<ul>
{					foreach from=$docs item=d}
						<li><a href="{$url.base}/{$d}">
								{if $section==$d}<strong>{$d|ucfirst}</strong>{else}{$d|ucfirst}{/if}
							</a></li>
{					/foreach}
					</ul>
				</div>
			  </div><!-- /row -->
		  </section>
{/block}
</div> {* EOF .container *}