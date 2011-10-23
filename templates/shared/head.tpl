<head>
	<title>{$metadata.title}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Language" content="{$url.lang}" />

	<meta name="title" content="{$metadata.title}" />
	<meta name="description" content="{$metadata.description}" />
	<meta name="keywords" content="{$metadata.keywords}" />

	<link rel="shortcut icon" href="{$url.base}/favicon.ico" type="image/x-icon" />
	{literal}
	<script type="text/javascript">

	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', 'UA-25290072-1']);
	  _gaq.push(['_trackPageview']);

	  (function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();

	</script>
	{/literal}

{	$media_module}
</head>
