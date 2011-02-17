function injectPosts(response)
{
	var posts = response.local.length;
	var more = $('#posts')[0].removeChild($('#posts li:last')[0]);
	var pageSize = parseInt($(more).children().children('a')[0].getAttribute("pagesize"), 10);
	for (var post in response.local)
	{
		var li = document.createElement('li');
		li.innerHTML = '<div class="thumb"><a class="thumb" href="/post/'+response.local[post].id+'"><img src="'+api.hostname+'/photo/'+response.local[post].thumbnail+'/80x80" width="80" height="80" /></a></div><div class="description"><div class="heading"><h4 class="left text-overflow"><a href="/post/'+response.local[post].id+'">'+response.local[post].title+'</a></h4><span class="datetime right">'+response.local[post].created+'</span></div><p class="word-wrap">'+response.local[post].excerpt+'</p></div>';
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

function subscription()
{
	if ($(".subscription").attr("rel") == "subscribe" && api.session.data.userId != 0)
	{
		api.launchDialog("Subscription", "<p>We'll now ensure you're always right up to date with this blog.</p><p>Whenever they publish a new piece of content, we'll send you a  notification to let you know.</p>");
		$(".subscription").html("Unsubscribe");
		$(".subscription").removeClass("plus");
		$(".subscription").addClass("minus");
		$(".subscription").attr("rel", "unsubscribe");
		$(".subscription").attr("href", $(".subscription").attr("href").replace("Subscribe", "Unsubscribe"));
	    $('<a id="subscription['+api.session.data.userId+']"href="http://www.facebook.com/profile.php?id='+api.session.data.userId+'" class="fbSquareProfilePic" title="'+api.session.data.firstname+' '+api.session.data.lastname+'" target="_blank" style="display: none;"><img src="https://graph.facebook.com/'+api.session.data.userId+'/picture" alt="'+api.session.data.firstname+' '+api.session.data.lastname+'"></a>').appendTo("#subscriptions").fadeIn('slow');
	}
	else if (api.session.userId != 0)
	{
		$(".subscription").html("Subscribe");
		$(".subscription").removeClass("minus");
		$(".subscription").addClass("plus");
		$(".subscription").attr("rel", "subscribe");
		$(".subscription").attr("href", $(".subscription").attr("href").replace("Unsubscribe", "Subscribe"));
		$('#subscriptions #subscription\\\['+api.session.data.userId+'\\\]').fadeOut('slow').delay(300, function() { $(this).empty().remove(); });
	}
	return false;
}

$(document).ready(function()
{  
  $('.rnd8px').corner("8px");
});