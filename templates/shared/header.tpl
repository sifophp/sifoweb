
  <div class="topbar">
      <div class="container">
        <h3><a href="/">SIFO</a></h3>
        <ul>
{			foreach from=$menu_items item=item}
          <li{if $path==$item} class="active"{/if}><a href="{$url.base}/{$item}">{$item|replace:'-':' '|ucwords}</a></li>
{			/foreach}
        </ul>
      </div>
    </div>

