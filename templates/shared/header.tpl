<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="brand" href="{$url.base}">SIFO</a>
            <div class="nav-collapse collapse">
                <ul class="nav">
    {			foreach from=$menu_items item=item}
                    <li{if $path==$item} class="active"{/if}><a href="{$url.base}/{$item}">{$item|replace:'-':' '|ucwords}</a></li>
    {			/foreach}
                    <li><a href="https://github.com/alombarte/SIFO/issues">Issues</a></li>
                    <li><a href="https://groups.google.com/forum/?fromgroups#!forum/sifophp">Questions?</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>