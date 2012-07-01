{extends file=$_tpls['layout/basic.tpl']}

{block name='content'}
{* Use container-fluid class for non-fixed layout*}
		<section id="{$section}">
			<div class="row">
{                if count( $docs ) > 0}
                <div class="span4 columns">
                    <ul class="breadcrumb">
                        <li>
                            <a href="{$url.base}">Home</a> <span class="divider">/</span>
                        </li>
                        {                           assign var=complete value=''}
                        {       					foreach $path as $p}
                        {                           assign var=complete value="$complete/$p"}
                        {                  if $p@last}
                        <li class="active">{$p|ucfirst|replace:'-':' '}</li>
                        {                  else}
                        <li><a href="{$url.base}{$complete}">{$p|ucfirst|replace:'-':' '}</a> <span class="divider">/</span></li>
                        {                  /if}



                        {       					/foreach}

                    </ul>
                    <div id="navigation_box">
                        <nav>
                            <ul>
{       					foreach from=$docs item=d}
                                <li{if implode('/',$path)==$d} class="selected"{/if}><a href="{$url.base}/{$d}">
                                    {$d|regex_replace:"@(.*)/@":''|replace:'-':' '|ucfirst}
                                    <i class="icon-chevron-right icon-white"></i>
                                </a>
                                </li>
{       					/foreach}
                            </ul>
                        </nav>
                    </div>
                </div>
{                /if}
				<div class="{if count( $docs ) > 0}span8{else}span12{/if} columns">


{					if isset($content)}{$content}{/if}
				</div>

			  </div><!-- /row -->
		  </section>
{/block}
