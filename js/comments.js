function addComment(response)
{
	var container = document.getElementById('commentsContainer');
	var form = document.getElementById('commentForm');
	form.elements['comment'].value = '';
	form.elements['comment'].style.height = '18px';
	$('#commentForm').children('.submit').toggle();
	document.getElementById('submitComment').disabled = false;
	var comments = new Array();
	for (var i = container.children.length - 1; i >= 1; i--)
	{
  	  comments.push(container.removeChild(container.children[i]));
	}
	var innerComment = '<a href="http://www.facebook.com/profile.php?id='+response.local.userId+'" class="fbSquareProfilePic photo" target="_blank"><img src="https://graph.facebook.com/'+response.local.userId+'/picture" width="50" height="50" /></a><div class="body"><a class="user" href="http://www.facebook.com/profile.php?id='+response.local.userId+'">'+ response.local.firstname +' '+ response.local.lastname +'</a>';
  	innerComment += '<span class="remove"><a href="/backend/ajax.php?service=blog&method=RemoveComment&id='+ response.local.id +'" ajaxify="1" callback="removeComment" spinner="comment'+response.local.id+'Spinner" class="right">delete</a><div class="ajaxSpinner" id="comment'+response.local.id+'Spinner"></div></span>';
	response.local.body = linkify(response.local.body);
	innerComment += '<span class="posted">a few seconds ago</span><span class="content word-wrap">'+ api.deserializeString(response.local.body); +'</span></div>';
	var comment = document.createElement('div');
	comment.className = 'comment';
	comment.id = 'comment['+ response.local.id +']';
	comment.style.display = 'none';
	comment.innerHTML = innerComment;
	container.appendChild(comment);
	for (var i = comments.length - 1; i >= 0; i--)
	{
  	  container.appendChild(comments[i]);
	}
	var numComments = document.getElementById('commentCount');
	var commentCount = parseInt(numComments.value, 10) + 1;
	numComments.value = commentCount;
	//document.getElementById('numComments').innerHTML = commentCount == 1 ? commentCount + ' comment' : commentCount + ' comments';
	//$('#viewAllComments > a').html('View all '+commentCount+' comments');
	$(".comment").fadeIn("normal");
}

function removeComment(response)
{
    $('#comment\\\['+response.id+'\\\]').fadeOut('slow').delay(300, function() { $(this).empty().remove(); });
    var numComments = document.getElementById('commentCount');
    var commentCount = parseInt(numComments.value, 10) - 1;
    numComments.value = commentCount;
    //document.getElementById('numComments').innerHTML = commentCount == 1 ? commentCount + " comment" : commentCount + " comments";
    //$('#viewAllComments > a').html("View all "+commentCount+" comments");
}

function viewAllComments(response)
{
  var comments = document.getElementById("commentsContainer");
  var container = comments.parentNode;
  container.removeChild(comments);
  comments = document.createElement("div");
  comments.className = "comments";
  comments.id = "commentsContainer";
  
  for (var index in response.local)
  {
	var comment = document.createElement("div");
    comment.className = "comment";
    comment.id = "comment["+response.local[index].id+"]";
	var innerComment = '<a href="http://www.facebook.com/profile.php?id='+response.local.userId+'" class="fbSquareProfilePic photo" target="_blank"><img src="https://graph.facebook.com/'+response.local.userId+'/picture" width="50" height="50" /></a><div class="body"><a class="user" href="http://www.facebook.com/profile.php?id='+response.local.userId+'">'+ response.local.firstname +' '+ response.local.lastname +'</a>';
	if (parseInt(response.local[index].userId, 10) == parseInt(response.global.userId, 10))
	{
  	  innerComment += '<span class="remove"><a href="/backend/ajax.php?service=blog&method=RemoveComment&id='+ response.local[index].id +'" ajaxify="1" callback="removeComment" spinner="comment'+response.local[index].id+'Spinner" class="right">delete</a><div class="ajaxSpinner" id="comment'+response.local[index].id+'Spinner"></div></span>';
	}
	response.local[index].body = linkify(response.local[index].body);
    innerComment += '<span class="posted">a few seconds ago</span><span class="content word-wrap">'+ api.deserializeString(response.local.body); +'</span></div>';
	comment.innerHTML = innerComment;
    comments.appendChild(comment);
  }

  container.appendChild(comments);
  $("#viewAllComments").empty().remove();
}

function commentSubmit()
{
  document.getElementById('submitComment').disabled = true;
  $('#commentForm textarea.commentInput:first').empty().remove();
}
  
function commentError()
{
  document.getElementById('submitComment').disabled = false;
}

$(document).ready(function()
{
	$('textarea.commentInput').autoResize({
    	animate: false,
		limit : 250,
		minimum : 35,
    	extraSpace : 5
	});

	$('.commentInput').bind('focus', function()
	{
		if ($(this).val() == "")
		{
			$(this).siblings('.submit').toggle();
			$(this).css("paddingTop", 5);
			$(this).css("height", 40);
		}
	});
	
	$('.commentInput').bind('blur', function()
	{
		if ($(this).val() == "")
		{
			$(this).siblings('.submit').toggle();
			$(this).css("paddingTop", 9);
			$(this).css("height", 18);
			
		}
	});
});

