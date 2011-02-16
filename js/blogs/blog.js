function injectPosts(response)
{
	var posts = response.local.length;
	var more = $('#posts')[0].removeChild($('#posts li:last')[0]);
	var pageSize = parseInt($(more).children().children('a')[0].getAttribute("pagesize"), 10);
	for (var post in response.local)
	{
		var li = document.createElement('li');
		li.innerHTML = '<div class="thumb"><a class="thumb" href="/post/'+response.local[post].id+'"><img src="http://www.projectnightlife.co.uk/photo/'+response.local[post].thumbnail+'/80x80" width="80" height="80" /></a></div><div class="description"><div class="heading"><h4 class="left text-overflow"><a href="/post/'+response.local[post].id+'">'+response.local[post].title+'</a></h4><span class="datetime right">'+response.local[post].created+'</span></div><p class="word-wrap">'+response.local[post].excerpt+'</p></div>';
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
	if ($(".profileInteractions .subscription").attr("rel") == "subscribe" && api.session.data.userId != 0)
	{
		api.launchDialog("Subscription", "<p>We'll now ensure you're always right up to date with this blog.</p><p>Whenever it publishes a new piece of content, we'll send you a  notification to let you know.</p>");
		$(".profileInteractions .subscription").html("Unsubscribe from this blog");
		$(".profileInteractions .subscription").attr("rel", "unsubscribe");
		$(".profileInteractions .subscription").attr("href", $(".profileInteractions .subscription").attr("href").replace("Subscribe", "Unsubscribe"));
		if ($("#leftColumn #subscriptions").size() > 0)
		{
			$('<a id="subscription['+api.session.data.userId+']"href="http://www.facebook.com/profile.php?id='+api.session.data.userId+'" class="fbSquareProfilePic" title="'+api.session.data.firstname+' '+api.session.data.lastname+'" target="_blank" style="display: none;"><img src="https://graph.facebook.com/'+api.session.data.userId+'/picture" alt="'+api.session.data.firstname+' '+api.session.data.lastname+'"></a>').appendTo("#leftColumn #subscriptions").fadeIn('slow');
		}
		else
		{
			$('<div class="UIpanel topspcr" style="display: none;"><div class="UIheading"><h3>Subscribers</h3></div><div id="subscriptions"><a id="subscription['+api.session.data.userId+']"href="http://www.facebook.com/profile.php?id='+api.session.data.userId+'" class="fbSquareProfilePic" title="'+api.session.data.firstname+' '+api.session.data.lastname+'" target="_blank"><img src="https://graph.facebook.com/'+api.session.data.userId+'/picture" alt="'+api.session.data.firstname+' '+api.session.data.lastname+'"></a></div></div>').appendTo("#leftColumn").fadeIn('slow');
		}
	}
	else if (api.session.userId != 0)
	{
		$(".profileInteractions .subscription").html("Subscribe to this blog");
		$(".profileInteractions .subscription").attr("rel", "subscribe");
		$(".profileInteractions .subscription").attr("href", $(".profileInteractions .subscription").attr("href").replace("Unsubscribe", "Subscribe"));
		if ($('#subscriptions').children().size() > 1)
		  $('#subscriptions #subscription\\\['+api.session.data.userId+'\\\]').fadeOut('slow').delay(300, function() { $(this).empty().remove(); });
		else
		  $('#subscriptions').parent().fadeOut('slow').delay(300, function() { $(this).empty().remove(); });
	}
	return false;
}

$(document).ready(function()
{  
  $('.rnd8px').corner("8px");
});