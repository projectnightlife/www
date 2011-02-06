function injectPosts(response)
{
	var posts = response.local.length;
	var more = $('#posts')[0].removeChild($('#posts li:last')[0]);
	var pageSize = parseInt($(more).children().children('a')[0].getAttribute("pagesize"), 10);
	for (var post in response.local)
	{
		var li = document.createElement('li');
		li.innerHTML = '<div class="thumb"><a class="thumb" href="/post/'+response.local[post].id+'"><img src="http://www.projectnightlife.co.uk/photo/'+response.local[post].thumbnail+'/80x80" width="80" height="80" /></a></div><div class="description"><div class="heading"><h4 class="left text-overflow"><a href="/post/'+response.local[post].id+'">'+response.local[post].title+'</a></h4><span class="datetime right">'+response.local[post].created+'</span></div><p class="word-wrap">'+response.local[post].excerpt+'</p><ul class="inline-links"><li><i>Live</i></li><li><a href="/blog/editv=edit&p='+response.local[post].id+'">Edit</a></li><li><a href="#" onclick="api.launchConfirmDialog(&quot;Do you wish to delete this post?&quot;, &quot;removePost&quot;, &quot;'+response.local[post].id+'&quot;); return false;">Delete</a></li><li><div class="ajaxSpinner" id="postSpinner'+response.local[post].id+'"></div></li></ul></div>';
		$('#posts')[0].appendChild(li);
	}
	if (posts == pageSize)
	{
		var offset = parseInt($(more).children().children('a')[0].getAttribute("offset"), 10) + pageSize;
		$(more).children().children('a')[0].style.display = 'inline';
		$(more).children().children('div')[0].style.display = 'none';
		$(more).children().children('a')[0].href = $(more).children().children('a')[0].href.substring(0, $(more).children().children('a')[0].href.lastIndexOf('='))+"="+offset;
		$(more).children().children('a')[0].setAttribute("offset", offset);
		$('#posts')[0].appendChild(more);
	}
	else
	{
	    $('#posts > li:last').addClass("last");
	}
}

function removePost(id)
{
	api.sendSimpleRequest("http://www.projectnightlife.co.uk/backend/ajax.php?service=blog&method=RemovePost&id="+id, "postRemoved", "postSpinner"+id);
}

function postRemoved(response)
{
	$('#post\\\['+response.id+'\\\]').fadeOut('slow').delay(300, function() { $(this).empty().remove(); $('#posts li:first').removeClass('first').addClass('first'); });
}

$(document).ready(function()
{  
  $('.rnd8px').corner("8px");
});