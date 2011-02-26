/* blogs.js */
function addComment(response)
{
	var container = document.getElementById('commentsContainer');
	var form = document.getElementById('commentForm');
	form.elements['content'].value = '';
	form.elements['content'].style.height = '18px';
	form.elements['content'].onfocus = function(e) {
  	  e = e || window.event;
      e.srcElement.style.height = '80px';
	};
	document.getElementById('submitComment').disabled = false;
	var comments = new Array();
	for (var i = container.children.length - 1; i >= 0; i--)
	{
  	  comments.push(container.removeChild(container.children[i]));
	}
	var comment = document.createElement('div');
	comment.className = 'comment';
	comment.id = 'comment['+ response.local.id +']';
	comment.style.display = 'none';
	comment.innerHTML = '<a href="http://www.facebook.com/profile.php?id='+response.local.userId+'" class="fbSquareProfilePic photo" target="_blank"><img src="https://graph.facebook.com/'+response.local.userId+'/picture" width="50" height="50" /></a><div class="body"><a class="user" href="http://www.facebook.com/profile.php?id='+response.local.userId+'">'+ response.local.firstname +' '+ response.local.lastname +'</a>';
  	comment.innerHTML += '<span class="remove"><a href="/backend/ajax.php?service=blog&method=RemoveComment&id='+ response.local.id +'" ajaxify="1" callback="removeComment" spinner="comment'+response.local.id+'Spinner" class="right">delete</a><div class="ajaxSpinner" id="comment'+response.local.id+'Spinner"></div></span>';
	response.local.body = linkify(response.local.body);
	comment.innerHTML += '<span class="posted">a few seconds ago</span><span class="content word-wrap">'+ api.deserializeString(response.local.body); +'</span></div>';
	container.appendChild(comment);
	for (var i = comments.length - 1; i >= 0; i--)
	{
  	  container.appendChild(comments[i]);
	}
	var numComments = document.getElementById('commentCount');
	var commentCount = parseInt(numComments.value, 10) + 1;
	numComments.value = commentCount;
	document.getElementById('numComments').innerHTML = commentCount == 1 ? commentCount + ' comment' : commentCount + ' comments';
	$('#viewAllComments > a').html('View all '+commentCount+' comments');
	$(".comment").fadeIn("normal");
}

function removeComment(response)
{
    $('#comment\\\['+response.id+'\\\]').fadeOut('slow').delay(300, function() { $(this).empty().remove(); });
    var numComments = document.getElementById('commentCount');
    var commentCount = parseInt(numComments.value, 10) - 1;
    numComments.value = commentCount;
    document.getElementById('numComments').innerHTML = commentCount == 1 ? commentCount + " comment" : commentCount + " comments";
    $('#viewAllComments > a').html("View all "+commentCount+" comments");
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
	comment.innerHTML = '<a href="http://www.facebook.com/profile.php?id='+response.local.userId+'" class="fbSquareProfilePic photo" target="_blank"><img src="https://graph.facebook.com/'+response.local.userId+'/picture" width="50" height="50" /></a><div class="body"><a class="user" href="http://www.facebook.com/profile.php?id='+response.local.userId+'">'+ response.local.firstname +' '+ response.local.lastname +'</a>';
	if (parseInt(response.local[index].userId, 10) == parseInt(response.global.userId, 10))
	{
  	  comment.innerHTML += '<span class="remove"><a href="/backend/ajax.php?service=blog&method=RemoveComment&id='+ response.local[index].id +'" ajaxify="1" callback="removeComment" spinner="comment'+response.local[index].id+'Spinner" class="right">delete</a><div class="ajaxSpinner" id="comment'+response.local[index].id+'Spinner"></div></span>';
	}
	response.local[index].body = linkify(response.local[index].body);
    comment.innerHTML += '<span class="posted">a few seconds ago</span><span class="content word-wrap">'+ api.deserializeString(response.local.body); +'</span></div>';
    comments.appendChild(comment);
  }

  container.appendChild(comments);
  $("#viewAllComments").empty().remove();
}

function commentSubmit()
{
  document.getElementById('submitComment').disabled = true;
}
  
function commentError()
{
  document.getElementById('submitComment').disabled = false;
}