function addComment(response)
{
	var container = document.getElementById('commentsContainer');
	var form = document.getElementById('commentForm');
	form.elements['content'].value = '';
	form.elements['content'].style.height = '25px';
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
	var innerComment = '<a href="http://www.facebook.com/profile.php?id='+response.local.userId+'" class="fbSquareProfilePic photo" target="_blank"><img src="https://graph.facebook.com/'+response.local.userId+'/picture" width="50" height="50" /></a><div class="body"><a class="user" href="http://www.facebook.com/profile.php?id='+response.local.userId+'">'+ response.local.firstname +' '+ response.local.lastname +'</a>';
  	innerComment += '<span class="remove"><a href="/backend/ajax.php?service=blog&method=RemoveComment&id='+ response.local.id +'" ajaxify="1" callback="removeComment" spinner="comment'+response.local.id+'Spinner" class="right">delete</a><div class="ajaxSpinner" id="comment'+response.local.id+'Spinner"></div></span>';
	response.local.body = linkify(response.local.body);
	innerComment += '<span class="posted">a few seconds ago</span><span class="content word-wrap">'+ api.deserializeString(response.local.body); +'</span></div>';
	comment.innerHTML = innerComment;
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
}
  
function commentError()
{
  document.getElementById('submitComment').disabled = false;
}

$(document).ready(function()
{
	//Prototype
	$('.commentInput').each(function(textarea){ //The 100 textareas

  var interval,
      oldValue = textarea.value,

      //The observer function is the same, only we're assigning
      //it to a variable to be re-used
      observer = function(){
        var newValue = textarea.value;
        if (newValue != oldValue) {//Value has changed
          //Set the "rows" attribute to the number of lines + 2
          textarea.writeAttribute('rows', newValue.split("\n").length+2);
          oldValue = newValue;
        }
      };

  //When the user focuses the textarea, create the observer interval
  textarea.observe('focus', function(){
    //Assign the interval to a variable so it can be removed later
    interval = setInterval(observer, 500);//Check every 0.5s
  });

  //When the user is finished editing, remove the interval
  textarea.observe('blur', function(){
    clearInterval(interval);
  });

});
	$('.commentInput').bind('focus', function()
	{
		if (!api.validation.nonEmpty(this.val()))
		{
			//this.TextAreaExpander(70, 250);
		}
	});
	
	$('.commentInput').bind('blur', function()
	{
		if (!api.validation.nonEmpty(this.val()))
		{
			
		}
	});
});

