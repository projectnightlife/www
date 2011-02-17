var objects = new Array();
  var photos = new Array();
  var posted = false;
  var ieRange = null;
  
  function discardPost()
  {
	  posted = true; // prevents no save dialog appearing
	  window.location = "edit?v=manage";
  }
  
  function submitPost()
  {
	cleanUpPhotos();
	document.getElementById('submitPost').disabled = true;
	document.getElementById('savingNotification').style.display = 'block';
  }
  
  function postError()
  {
	document.getElementById('submitPost').disabled = false;
	document.getElementById('savingNotification').style.display = 'none';
  }
  
  function postSubmitted(response)
  {
	  posted = true;
	  window.location = "/post/"+response.id;
  }
  
  function validateKeywords(keywords)
  {
	var valid = true;
	if (keywords.options.length < 2)
	{
	  valid = false;
	  api.error = "You must enter at least two keywords in order for Project Nightlife to relate this post to others.";
	}
	return valid;
  }
  
  function serializeExcerpt(element)
  {
	  var content = document.getElementById('postBody').value;
	  // remove any media object references
	  for (var i = 1; i <= photos.length; i++)
	  {
		  content = content.replace("<Photo "+i+">", "");
	  }
	  for (var i = 1; i <= objects.length; i++)
	  {
		  content = content.replace("<Object "+i+">", "");
	  }
      content = content.replace(/&/g, "&#38;"); // needs to be the first thing we do otherwise it will replace all & in entities
	  content = content.replace( /\u2018|\u2019|\u201A|\uFFFD|\u0027/g, "&#39;" );
   	  content = content.replace( /\u201c|\u201d|\u201e|\u0022/g, '&#34;' );
      content = content.replace( /\u02C6/g, '^' );
      content = content.replace( /\u2039/g, '<' );
      content = content.replace( /\u203A/g, '>' );
      content = content.replace( /\u2013/g, '-' );
      content = content.replace( /\u2014/g, '--' );
      content = content.replace( /\u2026/g, '...' );
      content = content.replace( /\u00A9/g, '(c)' );
      content = content.replace( /\u00AE/g, '(r)' );
      content = content.replace( /\u2122/g, 'TM' );
      content = content.replace( /\u00BC/g, '1/4' );
      content = content.replace( /\u00BD/g, '1/2' );
      content = content.replace( /\u00BE/g, '3/4' );
	  content = content.replace(/\u20AC/g, "&#8364;");
	  content = content.replace(/[\u02DC|\u00A0]/g, " ");
	  var paragraphs = content.split("\n");
      var newcontent = new Array();
	  var pattern = /\s+/g; // all white space characters (selecting consecutive as one) not stopping at the first (\n \t space etc...)
	  var pattern2 = /^\s/; // leading white space
	  var pattern3 = /\s$/; // trailing white space
	  for (var j = 0; j < paragraphs.length; j++)
	  {
		if (newcontent.length < 1) // only bother with first actual paragraph
		{
		  var cleanedText = paragraphs[j].replace(pattern, " ");
		  cleanedText = cleanedText.replace(pattern2, "");
		  cleanedText = cleanedText.replace(pattern3, "");
		  cleanedText = api.stripFormatting(cleanedText);
		  if(cleanedText.length != 0) 
		  {
		    newcontent.push(cleanedText);
		  }
		  else if (j == paragraphs.length - 1) // if we haven't had any usable paragraphs and this is the last one, just use an empty excerpt
		  {
			newcontent.push("");
		  }
		}
	  }
	  var excerpt = newcontent[0].substring(0, 250);
	  if (excerpt.length == 250)
	  {
	    var end = excerpt.lastIndexOf(' ');
	    if (end != -1)
	      excerpt = excerpt.substring(0, end)+'...';
	  }
	  return encodeURIComponent(excerpt);
  }
  
  function serializeThumbnail(element) // causing problems in ie7 if first photo was deleted
  {
	var thumbnail = null;
	for(var photo in photos)
	{
		if (photos[photo].thumbnail)
		{
			thumbnail = photos[photo].id;
			break;
		}
	}
	
	if ($('#postThumbnailId').val() == "") // no original thumbnail
	{
		if (thumbnail) // post will have a thumbnail
		{
		  api.sendSimpleRequest(api.hostname+"/backend/ajax.php?service=image&method=BlogMakeMainPhoto&id="+thumbnail, null, null, true);
		}
	}
	else // original thumbnail existed
	{
		if (!thumbnail) // post will have no thumbnail
		{
		  api.sendSimpleRequest(api.hostname+"/backend/ajax.php?service=image&method=BlogDeallocateMainPhoto&id="+$('#postThumbnailId').val(), null, null, true);
		}
		else if (parseInt($('#postThumbnailId').val(), 10) != thumbnail) // post will have new thumbnail
		{
			api.sendSimpleRequest(api.hostname+"/backend/ajax.php?service=image&method=BlogDeallocateMainPhoto&id="+$('#postThumbnailId').val(), null, null, true);
			api.sendSimpleRequest(api.hostname+"/backend/ajax.php?service=image&method=BlogMakeMainPhoto&id="+thumbnail, null, null, true);
		}
	}
				
	return thumbnail ? thumbnail : ""; // ensures an empty string is returned in case older browsers don't convert null to empty string during xml creation
  }
  
  function serializeBody(body)
  {
	  body = body.value;
	  body = pnLinkify(body);
	  // replace photos
	  for (var photo = 0; photo < photos.length; photo++)
	  {
		if (photos[photo] != null)
		{
			body = body.replace("<Photo "+(photo + 1)+">", '[pnobject type="image" id="'+photos[photo].id+'"]');
		}
	  }
	  // replace objects
	  for (var object = 0; object < objects.length; object++)
	  {
		if (objects[object] != null)
		{
			body = body.replace("<Object "+(object + 1)+">", '[pnobject type="flash" url="'+objects[object].url+'" width="'+objects[object].width+'" height="'+objects[object].height+'"]');
		}
	  }
	  // keeps backward <> compatability with objects - converts to bbcode
	  body = body.replace(/<u>/g, "[u]");
	  body = body.replace(/<\/u>/g, "[/u]");
	  body = body.replace(/<i>/g, "[i]");
	  body = body.replace(/<\/i>/g, "[/i]");
	  body = body.replace(/<b>/g, "[b]");
	  body = body.replace(/<\/b>/g, "[/b]");
	  
	  return body;
  }
  
  function serializeKeywords(element)
  {
	  var tags = "";
	  for(var i = 0; i < element.options.length; i++)
	  {
		  if (i < element.options.length - 1)
		    tags += element.options[i].value+",";
		  else
		    tags += element.options[i].value;
	  }
	  // ensure tags isn't too long for database max set length
	  // if needs cropping, removes entire tags not cutting last early
	  tags = tags.substring(0, 1024);
	  if (tags.length == 1024)
	  {
	    var end = tags.lastIndexOf(',');
	    if (end != -1)
	      tags = tags.substring(0, end);
	  }
	  return tags;
  }
  
  function uploadStarted()
  {
	  document.getElementById('upload_iframe').style.display = "none";
	  document.getElementById('uploading').style.display = "block";
  }
  function uploadComplete(photo)
  {
	  photo = JSON.parse(photo);
	  addPhoto(photo, false);
	  document.getElementById('upload_iframe').style.display = "block";
	  document.getElementById('uploading').style.display = "none";
	  document.getElementById('upload_iframe').contentWindow.document.body.style.background = "#0a0a0a";
  }
  function uploadError()
  {
	  document.getElementById('upload_iframe').style.display = "block";
	  document.getElementById('uploading').style.display = "none";
	  document.getElementById('upload_iframe').contentWindow.document.body.style.background = "#0a0a0a";
	  api.launchDialog("Invalid photo type", "Please upload a valid photo.");
  }
  
function insertKeywordOption(element)
{
	var value = element.value;
	var key = element.value;
	element.value = "";
	var keywords = document.getElementById('keywords');
	var expr = new RegExp("^[ ]*$", "g");
	if (!expr.test(value)) 
	{
		var exists = false;
		for (var i = 0; i < keywords.options.length; i++)
		  if (keywords.options[i].value == key)
		    exists = true;
		if (!exists)
		{
		  var options = $(keywords).attr('options');
          options[options.length] = new Option(value, key, true, false);
		  if (keywords.length > 3)
		    keywords.size++;
		}
	}
	if (keywords.options.length > 1)
      $('#keywordWarning').fadeOut('slow');
}

function removeKeywordOption()
{
	var keywords = document.getElementById('keywords');
	if(keywords.selectedIndex >= 0)
	{
      keywords.remove(keywords.selectedIndex);
	  if (keywords.options.length < 3)
		keywords.size = 3;
	  else
		keywords.size--;
	}
	else
	{
		api.launchDialog("Notification", "Please select a keyword to remove");
	}
	if (keywords.options.length == 1)
      $('#keywordWarning').fadeIn('slow');
}

function initAddPhotos()
{
	$('#addPhotoText').empty().remove();
	document.getElementById('addedPhotos').style.display = "block";
	document.getElementById('photo_upload').style.display = "block";
	return false;
}

function initAddObjects()
{
	$('#addObjectText').empty().remove();
	document.getElementById('addedObjects').style.display = "block";
	document.getElementById('object').style.display = "block";
	document.getElementById('objectButton').style.display = "inline-block";
	return false;
}

function setPostThumbnail(photoNum)
{
	for (var photo in photos)
	{
		photos[photo].thumbnail = false;
	}
	photos[photoNum - 1].thumbnail = true;
}

function addPhoto(photo, loadingPage)
{
	var newPhoto = {
		id : photo.id,
		thumbnail : false,
		removed : false
      };
	photos.push(newPhoto);
	  
	var addedPhotos = document.getElementById('addedPhotos');
	var image = document.createElement('img');
    image.src = api.hostname+"/photo/"+newPhoto.id+"/160x120";
	image.style.width = "160px";
	image.style.height = "120px";
	var holder = document.createElement('div');
	holder.className = 'mediaPreviewControl';
	holder.id = 'photo'+photos.length;
	holder.appendChild(image);
	  
	holder.innerHTML += '<a href="#" onclick="return removePhoto('+photos.length+')" class="remove" title="remove"><img src="/images/core/icons/remove.png" /></a>';
	  
	var description = document.createElement('div');
	description.innerHTML = '<span class="left">Photo '+photos.length+'</span><span class="right"><label>Main Photo<input type="radio" onclick="setPostThumbnail('+photos.length+')" name="radioThumb" id="Thumb'+photos.length+'" /></label></span>';
	  
	holder.appendChild(description);
	addedPhotos.appendChild(holder);

	if (!loadingPage)
	{
	  if (document.getElementById('postBody').value == "")
	    document.getElementById('postBody').value += "<Photo "+photos.length+">";
	  else
	    document.getElementById('postBody').value += "\n\n<Photo "+photos.length+">";
	}
	
	$('#postBody').TextAreaExpander(260, 1000);
	  
	var numPhotos = 0;
	
	for (var i = 0; i < photos.length; i++)
	  if (!photos[i].removed)
	    numPhotos++;
	
	if (numPhotos == 1)
	{
	  document.getElementById('Thumb'+photos.length).checked = true;
	  photos[photos.length - 1].thumbnail = true; 
	}
}

function addObject(object)
{
  if (!object)  // no supplied object, so parse object input text area
  {
    var objectTextArea = document.getElementById('object');
	var re = new RegExp('src="http:\/\/[^"]*"|width="[^"]*"|height="[^"]*"', "g");
	var res, src, width, height, foundSrc = false, foundWidth = false, foundHeight = false;
	while ((res = re.exec(objectTextArea.value)) != null)
	{
	  if (!foundSrc && res[0].substr(0,3) == "src")
	  {
	    src = res[0].substring(5, res[0].length-1);
		foundSrc = true;
	  }
	  else if (!foundWidth && res[0].substr(0,5) == "width")
	  {
	    width = res[0].substring(7, res[0].length-1);
		foundWidth = true;
	  }
	  else if (!foundHeight && res[0].substr(0,6) == "height")
	  {
	    height = res[0].substring(8, res[0].length-1);
		foundHeight = true;
	  }
	}
	
	if (objectTextArea.value.lastIndexOf("iframe") != -1 && objectTextArea.value.lastIndexOf("youtube") != -1)
	{
		src = "http://www.youtube.com/v/"+src.substr(src.lastIndexOf("/") + 1);
	}
	
	re = new RegExp('^.*?(?=(<object))', "g");
	res = re.exec(objectTextArea.value);
	var supportingText = "";
	if (res != null)
	  supportingText = res[0];
	
	re = new RegExp('</object>.*', "g");
	res = re.exec(objectTextArea.value);
	if (res != null)
	  supportingText += res[0].substring(9, res[0].length);
	  
	if (!foundSrc || !foundWidth || !foundHeight)
	{
		if (objectTextArea.value.lastIndexOf("youtube.com/watch?v=") != -1)
		{
			var q = objectTextArea.value.substr(objectTextArea.value.lastIndexOf('?'));
			var end = q.indexOf('&');
			if (end == -1)
			  end = q.length;
			var v = q.substring(q.indexOf("v=")+2, end);
			src = "http://www.youtube.com/v/"+v;
			width = 606;
			height = 365;
			if (v != "")
			{
			  foundSrc = true;
			  foundWidth = true;
			  foundHeight = true;
			}
		}
	}
	if (foundSrc && foundWidth && foundHeight)
	{
	  // ensure flash isn't wider than post can display
	  if (width > 606)
	  {
	    height = Math.floor(height / (width / 606));
		width = Math.floor(width / (width / 606));
	  }
	  
	  object = {
	    url : src,
	    width : width,
	    height : height,
	    text : supportingText,
		tag : objectTextArea.value
      };
	  
	  objects.push(object);
      renderObject();
      objectTextArea.value = "";
	  
	  if (document.getElementById('postBody').value == "")
	    document.getElementById('postBody').value += "<Object "+objects.length+">";
	  else
	    document.getElementById('postBody').value += "\n\n<Object "+objects.length+">";
	  
	  $('#postBody').TextAreaExpander(260, 1000);
	}
	else
	{
		api.launchDialog("Notification", "The embed code you entered doesn't contain everything we need");
	}
  } // if (!object)
  else {
    objects.push(object);
    renderObject();
	$('#originalPostBody').val($('#originalPostBody').val().replace(object.tag, "<Object "+objects.length+">"));
  }
}

function renderObject()
{
	var addedObjects = document.getElementById('addedObjects');
	  var holder = document.createElement('div');
	  holder.className = 'mediaPreviewControl';
	  holder.id = 'object'+objects.length;
	  holder.innerHTML = '<object width="160" height="115"><param name="movie" value="'+objects[objects.length - 1].url+'"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><param name="wmode" value="transparent" /><embed src="'+objects[objects.length - 1].url+'" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="160" height="110" wmode="transparent"></embed></object>';
	  var description = document.createElement('div');
	  description.innerHTML += '<span class="left">Object '+objects.length+'</span><a href="#" onclick="return removeObject('+objects.length+');" class="right">remove</a>';
	  holder.appendChild(description);
	  addedObjects.appendChild(holder);
}

function removeObject(objectNum)
{
	$('#object'+objectNum).empty().remove();
	$('#postBody').val($('#postBody').val().replace("<Object "+objectNum+">", ""));
	$('#postBody').val($('#postBody').val().replace(/\n\n\n\n/g, "\n\n"));
	objects[objectNum - 1] = null;
	return false;
}

function removePhoto(photoNum)
{
	var numPhotos = 0;
	var photoWasChecked = false;
	var lastPhotoIndex = -1;
	
	photos[photoNum - 1].thumbnail = false;
	photoWasChecked = document.getElementById('Thumb'+photoNum).checked;
	$('#photo'+photoNum).empty().remove();
	$('#postBody').val($('#postBody').val().replace("<Photo "+photoNum+">", ""));
	$('#postBody').val($('#postBody').val().replace(/\n\n\n\n/g, "\n\n"));
	photos[photoNum - 1].removed = true;
		
	for (var photo = 0; photo < photos.length; photo++)
	{
	  if (!photos[photo].removed)
	  {
	    numPhotos++;
		lastPhotoIndex = photo;
	  }
	}
	if (photoWasChecked && numPhotos >= 1 && lastPhotoIndex != -1)
	{
	  document.getElementById('Thumb'+(lastPhotoIndex+1)).checked = true;
	  photos[lastPhotoIndex].thumbnail = true;
	}
	if (window.location.href.lastIndexOf("new") == -1)
	  $('#photoUploadWarning').fadeIn('slow');
	return false;
}

function addLink(link)
{
	$('#originalPostBody').val($('#originalPostBody').val().replace(link.tag, link.text));
}

function unpackPost(response)
{
	api.data = response;
	$('#originalPostBody').val($('#originalPostBody').val().replace(/\\n\\n/g, "\n\n"));
	try { 
	  if (typeof(response.photos.photo[0]) == "undefined")
	    throw new Error();
	  for (var photo in response.photos.photo) {
	    var newPhoto = {
		  id : response.photos.photo[photo].id,
		  tag : response.photos.photo[photo].tag
        };
	    addPhoto(newPhoto, true);
	    document.getElementById('addedPhotos').style.display = "block";
	    $('#originalPostBody').val($('#originalPostBody').val().replace(newPhoto.tag, "<Photo "+photos.length+">"));
	  }
	}
	catch (e) {
	  for (var photo in response.photos) {
	    var newPhoto = {
		  id : response.photos[photo].id,
		  tag : response.photos[photo].tag
        };
	    addPhoto(newPhoto, true);
	    document.getElementById('addedPhotos').style.display = "block";
	    $('#originalPostBody').val($('#originalPostBody').val().replace(newPhoto.tag, "<Photo "+photos.length+">"));
	  }
	}
	try {
	  if (typeof(response.objects.object[0]) == "undefined")
	    throw new Error();
	  for (var object in response.objects.object) {
		var newObject = {
	      url : response.objects.object[object].url,
	      width : response.objects.object[object].width,
	      height : response.objects.object[object].height,
		  tag : response.objects.object[object].tag
        };
	    document.getElementById('addedObjects').style.display = "block";
	    addObject(newObject);
	  }
	}
	catch (e) {
	  for (var object in response.objects) {
		var newObject = {
	      url : response.objects[object].url,
	      width : response.objects[object].width,
	      height : response.objects[object].height,
		  tag : response.objects[object].tag
        };
	    document.getElementById('addedObjects').style.display = "block";
	    addObject(newObject);
	  }
	}
	try {
	  if (typeof(response.links.link[0]) == "undefined")
	    throw new Error();
	  for (var link in response.links.link) {
	    var newLink = {
	      url : response.links.link[link].url,
	      text : response.links.link[link].text,
		  tag : response.links.link[link].tag
        };
	    addLink(newLink);
	  }
	}
	catch (e) {
	  for (var link in response.links) {
	    var newLink = {
	      url : response.links[link].url,
	      text : response.links[link].text,
		  tag : response.links[link].tag
        };
	    addLink(newLink);
	  }
	}
	// keeps backward <> compatability with objects - converts to bbcode
	$('#originalPostBody').val($('#originalPostBody').val().replace(/<u>/g, "[u]"));
	$('#originalPostBody').val($('#originalPostBody').val().replace(/<\/u>/g, "[/u]"));
	$('#originalPostBody').val($('#originalPostBody').val().replace(/<i>/g, "[i]"));
	$('#originalPostBody').val($('#originalPostBody').val().replace(/<\/i>/g, "[/i]"));
	$('#originalPostBody').val($('#originalPostBody').val().replace(/<b>/g, "[b]"));
	$('#originalPostBody').val($('#originalPostBody').val().replace(/<\/b>/g, "[/b]"));
	$('#postBody').val($('#originalPostBody').val());
	$('#originalPostBody').empty().remove();
	$('#postBody').TextAreaExpander(260, 1000);
	if ($('#postThumbnailId').val() != '')
    {
	  for (var photo = 0; photo < photos.length; photo++)
	  {
	    if (photos[photo].id == parseInt($('#postThumbnailId').val(), 10))
	    {
		  document.getElementById('Thumb'+(photo+1)).checked = true;
		  photos[photo].thumbnail = true;
		  break;
		}
	  }
    }
}

function removePost(id)
{
  api.sendSimpleRequest(api.hostname+"/backend/ajax.php?service=blog&method=RemovePost&id="+id, "postRemoved", "postSpinner:002");
  document.getElementById('submitPost').disabled = true;
  document.getElementById('savingNotification').style.display = 'block';
}

function postRemoved(response)
{
  window.location = "edit";
}

// Asks the server to remove any photos which are no longer linked to the blog post
function cleanUpPhotos()
{
	for (var photo = 0; photo < photos.length; photo++)
	{
	  if (document.getElementById('postBody').value.search("<Photo "+(photo + 1)+">") == -1)
	  {
		  // no callback, no spinner and suppress all warnings
		  api.sendSimpleRequest(api.hostname+"/backend/ajax.php?service=image&method=RemovePhoto&id="+photos[photo].id, "photoRemoved", null, true);
	  }
	}
}

// Asks the server to remove all photos in this blog post
function cleanAllPhotos()
{
	for (var photo = 0; photo < photos.length; photo++)
	{
	  // no callback, no spinner and suppress all warnings
	  api.sendSimpleRequest(api.hostname+"/backend/ajax.php?service=image&method=RemovePhoto&id="+photos[photo].id, null, null, true);
	}
}

function postEmpty()
{
	var numPhotos = 0, numObjects = 0;
	
	for (var i = 0; i < photos.length; i++)
	  if (photos[i] != null)
	    numPhotos++;
		
	for (var i = 0; i < objects.length; i++)
	  if (objects[i] != null)
	    numObjects++;
		
	var pattern = /\s+/g; // all white space characters (selecting consecutive as one) not stopping at the first (\n \t space etc...)
	
	var cleanedTitle = document.getElementById('postTitle').value.replace(pattern, "");
	var cleanedBody = document.getElementById('postBody').value.replace(pattern, "");
	
	return cleanedTitle.length == 0 && cleanedBody.length == 0 && numPhotos == 0 && numObjects == 0;
}

function postDispose()
{
	
	if (window.location.href.indexOf("v=new") != -1 && !posted && !postEmpty()) // if new unsubmitted post !posted allows us to set posted = true and prevent popup when user presses discard
	{
	  cleanUpPhotos();
	  return "You're about to navigate away from this page but our systems haven't yet received your post. Doing so will result in the loss of this post. Do you wish to proceed?";
	}
	
}

function postDisposed()
{
	if (window.location.href.indexOf("v=new") != -1 && !posted) // if new unsubmitted post
	{
	  cleanAllPhotos();
	}
}

$(document).ready(function()
{
  if (window.location.href.indexOf("v=edit") != -1) // if in edit mode, load the post initialisation routine
  {
	api.sendXmlRequest(api.hostname+"/get_objects.php", encodeURIComponent(document.getElementById('originalPostBody').value), "unpackPost", null, false);
  }
  else
  {
    $('#keywordWarning').fadeIn('slow');
  }
  
  document.getElementById('upload_iframe').contentWindow.document.body.style.background = "#0a0a0a";
  
  $('#postBody').bind('keydown click', function(e) // e is a jquery event object - NOT native js event object
  { 
    if (document.selection)
      ieRange = document.selection.createRange();
  });
  
  if (document.selection)
  {
	document.getElementById('postBody').click();
	document.getElementById('postBody').blur();
  }
	
  $('#keywordInput').bind('keypress', function(e) // e is a jquery event object - NOT native js event object
  { 
    var code = e.keyCode | e.which;
	if (code == 188 || code == 44) // comma
	{
	  e.preventDefault();
	}
    else if(code == 13) { //Enter keycode
      var target = e.target;
      insertKeywordOption(target);
    }
  });
  
  $('#postForm').bind('keypress', function(e) // e is a jquery event object - NOT native js event object
  { 
    var code = e.keyCode | e.which;
    if(e.target.type != "textarea" && code == 13) { //Enter keycode
      e.preventDefault();
    }
  });
});

window.onbeforeunload = postDispose;
window.onunload = postDisposed;