<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//{$url.lang|upper}"
				"http://www.w3.org/TR/html4/strict.dtd">
<html lang="{$url.lang}">
<head>
	{$modules.head}
</head>
<body>
<div id="wrap">
	<div id="header">
{	block name='header'}
{		$modules.header}
{	/block}
	</div>
	<div id="nav">
		<ul>
			<li><a href="./">Home</a></li>
			<li><a href="./">Docs</a></li>
		</ul>

	</div>
	<div id="main">
		{block name='body'}
		{$content}
		{/block}
	</div>
	<div id="sidebar">
		<h2>Documentation</h2>
		<p>Explore the documentation</p>
		<ul>
{			foreach from=$docs item=d}
			<li><a href="{$url.base}/{$d}">{$d}</a></li>
{			/foreach}
		</ul>
	</div>
	<div id="footer">
		{$modules.footer}
	</div>
</div>
</body>
</html>