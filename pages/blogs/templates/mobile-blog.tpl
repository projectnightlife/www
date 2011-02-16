{include file='../../includes/templates/page.tpl'}
<meta property="og:title" content="{$blog->name}"/>
<meta property="og:type" content="blog"/>
<meta property="og:url" content="http://www.projectnightlife.co.uk/blog/{$blog->id}"/>
<meta property="og:image" content="http://www.projectnightlife.co.uk/photo/{$blog->thumbnail}/80x80"/>
<meta property="og:site_name" content="Project Nightlife"/>
<meta property="fb:app_id" content="131359770249054"/>
<meta property="og:description" content="{$blog->slogan}"/>
<title>{$blog->name} | Project Nightlife</title>
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="">
</head>

<body id="blogs mobile">
	{include file='../../includes/templates/header.tpl'}
	<div class="content">
		<div class="masthead">
			<div class="heading">
				<h1 class="left">{$blog->name}</h1><h1 class="right">Blog</h1>
			</div>
			<div class="breadcrumbs"><a href="/">Home &raquo;</a><a href="pages/blogs/blogs.php">Blogs &raquo;</a><a href="pages/blogs/blog.php?id={$blog->id}">{$blog->name}</a></div>
		</div>
		
		<div class="UIpanel" style="border-bottom: 1px solid #333;">
			<div class="UIheading">
				<h3>{$blog->name}</h3>
			</div>
			{if isset($blog->slogan)}
			<span>{$blog->slogan}</span>
			{/if}
			<p>By 
			{foreach from=$blogContributors item=contributor name=contributors}{if $smarty.foreach.contributors.first}<a href="http://www.facebook.com/profile.php?id={$contributor->userId}" target="_blank">{$contributor->firstname} {$contributor->lastname}</a>{elseif $smarty.foreach.contributors.last} and <a href="http://www.facebook.com/profile.php?id={$contributor->userId}" target="_blank">{$contributor->firstname} {$contributor->lastname}</a>{else}, <a href="http://www.facebook.com/profile.php?id={$contributor->userId}" target="_blank">{$contributor->firstname} {$contributor->lastname}</a>{/if}{/foreach}
			</p>
			{foreach from=$genres item=genre name=genres}
			<a href="pages/blogs/blogs.php?filter={$genre->name}" title="{$genre->name} homepage"><img src="images/genres/{$genre->id}.png" alt="{$genre->name}" style="margin-right: 3px;" height="19" /></a>
			{/foreach}
		</div>
		
		<ul id="posts" class="UIobjectlist">
			{foreach from=$posts item=post name=posts}
			<li {if $smarty.foreach.posts.first && $smarty.foreach.posts.last && $smarty.foreach.posts.total lt 8}class="first"{else}{if $smarty.foreach.posts.first}class="first"{elseif $smarty.foreach.posts.last && $smarty.foreach.posts.total lt 8}class=""{/if}{/if}>
				<div class="thumb"><a class="thumb" href="pages/blogs/post.php?id={$post->id}"><img src="pages/getphoto/GetPhoto.php?id={$post->thumbnail}&size=80x80" width="50" height="50" /></a></div>
				<div class="description">
					 <h4><a href="pages/blogs/post.php?id={$post->id}">{$post->title}</a></h4>
					 <p>{$post->excerpt}</p>
				</div>
			</li>
			{/foreach}
			{if $smarty.foreach.posts.total eq 8}
			<li class="last">
				<div>
					<a class="viewmorelink" href="backend/ajax.php?service=blog&method=GetPostsByBlog&id={$blog->id}&amount=8&start=8" ajaxify="1" callback="injectPosts" onClick="this.style.display = 'none'; document.getElementById('morePostsSpinner').style.display = 'inline-block';" spinner="morePostsSpinner" offset="8" pagesize="8">View more</a>
					<div id="morePostsSpinner" class="ajaxSpinner" style="display: none; float: none; margin: 1px;"></div>
				</div> 
			</li>
			{/if}
		</ul>
	</div>
	{include file='../../includes/templates/footer.tpl'}
</body>
</html>
{include file='../../includes/templates/critical_js.tpl'}
<script type="text/javascript" src="{$pageData['jsFile']}"></script>
{include file='../../includes/templates/js.tpl'}