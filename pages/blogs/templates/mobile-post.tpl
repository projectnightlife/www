{include file='../../includes/templates/mobile-page.tpl'}
<title>{$post->title} - {$blog->name} | Project Nightlife</title>
<meta property="og:title" content="{$post->title}"/>
<meta property="og:image" content="http://www.projectnightlife.co.uk/photo/{$post->thumbnail}/80x80"/>
<meta property="og:description" content="{$post->excerpt}"/>
<meta name="medium" content="blog" />
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="">
</head>

<body id="blogs mobile">
	{include file='../../includes/templates/mobile-header.tpl'}
	<div id="content">
		<div class="masthead">
			<div class="heading">
				<h1 class="left">{$blog->name}</h1>
			</div>
			<div class="breadcrumbs"><a href="/">Home &raquo;</a><a href="pages/blogs/blogs.php">Blogs &raquo;</a><a href="pages/blogs/blog.php?id={$blog->id}">{$blog->name}</a></div>
		</div>
		
		<div class="UIpanel">
			<h1 class="postHeading left">{$post->title}</h1>
			<div class="post word-wrap">
				{$post->body}
			</div>
		</div>
		
		<div class="UIpanel topspcr" id="comments">
			<h1 class="postHeading">Comments</h1>
			{if $session['loggedIn']}
			<div class="comments">
				<form id="commentForm" action="backend/ajax.php" ajaxify="1" callback="addComment" spinner="commentBox" errorcallback="commentError" onformsubmit="commentSubmit">
					<input type="hidden" name="params" value='{ "service":"blog","method":"AddComment","postId":"{$post->id}" }' autocomplete="off" />
					<textarea id="commentBox" name="content" serializable="api.dummySerialization:api.serializeStringFormatting" validator="api.validation.nonEmpty" autocomplete="off" onKeyDown="api.limitText(this,1500);" onKeyUp="api.limitText(this,1500);" onChange="api.limitText(this,1500);"></textarea>
					<input id="submitComment" class="right" type="submit" value="Comment" />
				</form>
			</div>
			{else}
			<div class="comments">
				<div class="comment">In order to post comments, you must be logged in.</div>
			</div>
			{/if}
			<div class="comments" id="commentsContainer">
				{foreach from=$comments item=comment name=comments}
				<div class="comment" id="comment[{$comment->id}]">
					<span class="meta"><span class="user"><a href="http://www.facebook.com/profile.php?id={$comment->userId}" target="_blank">{$comment->firstname} {$comment->lastname}</a></span> says:</span>
					{if $session['userId'] == $comment->userId}
					<span class="remove"><a href="backend/ajax.php?service=blog&method=RemoveComment&id={$comment->id}" ajaxify="1" callback="removeComment" spinner="comment{$comment->id}Spinner" class="right">delete</a><div class="ajaxSpinner" id="comment{$comment->id}Spinner"></div></span>
					{/if}
					<span class="posted">{$comment->created}</span>
					<span class="body word-wrap">{$comment->body}</span>
				</div>
				{/foreach}
				{if $post->numComments > 10}
				<div class="viewAll" id="viewAllComments"><a style="float: left;" href="backend/ajax.php?service=blog&method=GetComments&id={$post->id}&num=0&start=0" callback="viewAllComments" spinner="viewAllCommentsSpinner" ajaxify="1">View all {$post->numComments} comments</a><div class="ajaxSpinner" id="viewAllCommentsSpinner"></div></div>
				{/if}
			</div>
		</div>
	</div>
	{include file='../../includes/templates/mobile-footer.tpl'}
</body>
</html>
{include file='../../includes/templates/mobile-critical_js.tpl'}
<script type="text/javascript" src="{$pageData['jsFile']}"></script>
{include file='../../includes/templates/mobile-js.tpl'}