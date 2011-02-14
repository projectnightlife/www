{include file='../../includes/templates/mobile-page.tpl'}
<title>Blogs | Project Nightlife</title>
<link rel="alternate" type="application/rss+xml" title="Project Nightlife | Blogs (RSS 2.0)" href="blogs/rss" />
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="screen, projection">
</head>

<body id="blogs mobile">
	{include file='../../includes/templates/mobile-header.tpl'}
	<div id="content">
		<div id="tabs" class="ui-tabs">
			<ul class="tabNavigation">
				<li class="floatLeft"><a href="#tabs-1">Blog posts</a></li>
				<li class="floatRight"><a href="#tabs-2">Blogs</a></li>
			</ul>
			<div id="tabs-1">
				<ul id="posts" class="UIobjectlist">
					{foreach from=$posts item=post name=posts}
					<li {if $smarty.foreach.posts.first && $smarty.foreach.posts.last && $smarty.foreach.posts.total lt 8}class="first last"{else}{if $smarty.foreach.posts.first}class="first"{elseif $smarty.foreach.posts.last && $smarty.foreach.posts.total lt 8}class="last"{/if}{/if}>
						<div class="thumb">
							<a class="thumb" href="pages/blogs/post.php?id={$post->id}"><img src="pages/getphoto/GetPhoto.php?id={$post->thumbnail}&size=80x80" width="50" height="50" /></a>
						</div>
						<div class="description">
							<h4><a href="pages/blogs/post.php?id={$post->id}">{$post->title}</a></h4>
						</div>
						<span class="datetime" style="margin-bottom: 8px; display: block;">{$post->blogName}</span>
						<p>{$post->excerpt}</p>
					</li>
					{/foreach}
					{if $smarty.foreach.posts.total eq 8}
					<li class="last">
						<div style="width: 500px; margin: 0 auto; padding: 5px; text-align: center;">
						  <a href="backend/ajax.php?service=blog&method=GetPosts&genre={$pageData['filterOn']}&amount=8&start=8" ajaxify="1" callback="injectPosts" onClick="this.style.display = 'none'; document.getElementById('morePostsSpinner').style.display = 'inline-block';" spinner="morePostsSpinner" offset="8" pagesize="8">View more</a>
						  <div id="morePostsSpinner" class="ajaxSpinner" style="display: none; float: none; margin: 1px;"></div>
						</div> 
					</li>
					{/if}
				</ul>
			</div>
			<div id="tabs-2">
				<ul id="blogs" class="UIobjectlist">
					{foreach from=$blogs item=blog name=blogs}
					<li>
						<h4><span class="tilename">{$blog->name}</span></h4>
					</li>
					{/foreach}
				</ul>
			</div>
		</div>
	</div>
	{include file='../../includes/templates/mobile-footer.tpl'}
</body>
</html>
{include file='../../includes/templates/mobile-critical_js.tpl'}
<script type="text/javascript" src="{$pageData['jsFile']}"></script>
{include file='../../includes/templates/mobile-js.tpl'}