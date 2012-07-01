<div id="logo" class="row">
    <div class="span2">
        <a href="{$url.base}" title="Sifo, PHP5 framework for real-world web applications"><img alt="SIFO logo" src="{$url.static}/css/images/logo_small.png" /></a>
    </div>
    <div class="span10">
        <a target="_blank" href="https://github.com/alombarte/SIFO/tags" class="btn btn-success">Download <i class="icon-circle-arrow-down icon-white"></i></a>
    </div>
</div>

<div class="navbar">
    <div class="navbar-inner">
        <div class="container">
            <div class="nav-collapse collapse">
                <ul class="nav">
                   <li{if $section==''} class="active"{/if}><a href="{$url.base}">Overview</a></li>
    {			foreach from=$menu_items item=item}
                    <li{if $section==$item} class="active"{/if}><a href="{$url.base}/{$item}">{$item|replace:'-':' '|ucwords}</a></li>
    {			/foreach}
                    <li><a href="https://github.com/alombarte/SIFO/issues">Issues</a></li>
                    <li><a href="https://groups.google.com/forum/?fromgroups#!forum/sifophp">Questions?</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>