<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//{$url.lang|upper}"
				"http://www.w3.org/TR/html4/strict.dtd">
<html lang="{$url.lang}">
<head>
{	$modules.head}
</head>
<body onload="prettyPrint()">
	<div id="header">
	{	block name='header'}
	{		$modules.header}
	{	/block}
	</div>

	{block name='content'}
	{/block}
	
	<div id="footer">
		{$modules.footer}
	</div>
</body>
</html>