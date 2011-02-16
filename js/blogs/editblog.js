var photos = new Array();
var existedBlogPhoto = false;
var saved = false;

function blogSaved(response)
{
	// delete old blog photo if there was one
	if (existedBlogPhoto && (photos.length > 1 || $('#photo1').size() == 0))
	{
	  api.sendSimpleRequest(api.hostname+"/backend/ajax.php?service=image&method=RemovePhoto&id="+photos[0].id, null, null, true);
	}
	
	saved = true;
	document.getElementById('savingNotification').style.display = 'none';
    window.location = "/blog/"+response.id;
}

function saveError()
{
	document.getElementById('saveBlog').disabled = false;
	document.getElementById('savingNotification').style.display = 'none';
}

function saveBlog()
 {
	document.getElementById('saveBlog').disabled = true;
	document.getElementById('savingNotification').style.display = 'block';
 }

function validateGenres(genres)
{
	var valid = true;
	if (!genres.options.length > 0)
	{
	  valid = false;
	  api.error = "You must enter at least one genre in order for Project Nightlife to index your blog and any posts you make";
	}
	return valid;
}

function serializeGenres(element)
{
	  var genres = "";
	  for (var i = 0; i < element.options.length; i++)
	  {
	      if (i < element.options.length - 1)
		    genres += element.options[i].value+",";
		  else
		    genres += element.options[i].value;
	  }
	  return genres;
}

function serializeThumbnail(element)
{
	if (photos.length == 0 || photos[photos.length - 1] == null || (existedBlogPhoto && $('#photo1').size() == 0 && photos.length == 1))
	{
      return "";
	}
	else
	{
	  return photos[photos.length - 1].id;
	}
}

function insertGenreOption(value, key)
{
	var genres = document.getElementById('genres');
		var expr = new RegExp("^[ ]*$", "g");
	if (!expr.test(value)) 
	{
		var exists = false;
		for (var i = 0; i < genres.options.length; i++)
		  if (genres.options[i].value == key)
		    exists = true;
		if (!exists)
		{
		  //genres.add(new Option(value, key), null);
		  var options = $(genres).attr('options');
          options[options.length] = new Option(value, key, true, true);
		  //if (genres.size < genres.length)
		    //genres.size = genres.length;
		  //else
		  if (genres.length > 3)
		    genres.size++;
		}
		else
		{
		  for (var i = 0; i < genres.options.length; i++)
		    if (genres.options[i].value == key)
		      genres.options[i].selected = true;
		}
	}
	if (genres.options.length > 0)
      $('#genreEmptyWarning').fadeOut('slow');
}

function removeGenreOption()
{
	var genres = document.getElementById('genres');
	if(genres.selectedIndex >= 0)
	{
      genres.remove(genres.selectedIndex);
	  if (genres.options.length < 3)
		genres.size = 3;
	  else
		genres.size--;
	}
	else
	{
		api.launchDialog("Notification", "Please select a genre to remove");
	}
	if (genres.options.length == 0)
      $('#genreEmptyWarning').fadeIn('slow');
}

function requestGenre()
{
	var pattern = /\s+/g; // all white space characters (selecting consecutive as one) not stopping at the first (\n \t space etc...)
	var genre = prompt("Please enter the genre or style you want to request and we'll add for you.", "");
	if (genre == null)
	  return false; // cancel was pressed which for some reason seems to throw return null or something... strange! So we better deal with it nicely!
	genre = genre.replace(pattern, " "); // replace all multiple white space chars with one space
	if (genre.replace(pattern, "").length != 0) // remove all spaces and see if input box is empty
	  api.sendSimpleRequest(api.hostname+'/backend/ajax.php?service=genre&method=RequestGenre&genre='+genre, "genreRequested", null, false);
	return false;
}

function genreRequested(response)
{
	api.launchDialog("Thanks for the request", "we'll look into adding "+response.genre+" as soon as we can. Don't forget to update your blog once we've added it.");
}

function initAddPhotos()
{
	$('#addPhotoText').empty().remove();
	document.getElementById('addedPhotos').style.display = "block";
	document.getElementById('photo_upload').style.display = "block";
	return false;
}

function uploadStarted()
  {
	  document.getElementById('upload_iframe').style.display = "none";
	  document.getElementById('uploading').style.display = "block";
  }
  function uploadComplete(photo)
  {
	  photo = JSON.parse(photo);
	  addPhoto(photo);
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

function addPhoto(photo)
{
	var newPhoto = {
		id : photo.id
      };

	if (photos.length != 0 && photos[photos.length - 1] != null) // may have already been deleted
	  removePhoto(photos.length);
	photos.push(newPhoto);
	  
	var addedPhotos = document.getElementById('addedPhotos');
	var image = document.createElement('img');
    image.src = api.hostname+"/photo/"+newPhoto.id+"/80x80";
	image.style.height = "80px";
	image.style.width = "80px";
	var holder = document.createElement('div');
	holder.className = 'mediaPreviewControl';
	holder.style.width = "88px";
	holder.id = 'photo'+photos.length;
	holder.appendChild(image);
	  
	holder.innerHTML += '<a href="#" onclick="return removePhoto('+photos.length+')" class="remove" title="remove"><img src="/images/core/icons/remove.png" /></a>';
	  
	var description = document.createElement('div');
	description.innerHTML = '<span class="left">Blog Photo</span>';
	  
	holder.appendChild(description);
	addedPhotos.appendChild(holder);
	if (photos.length > 1)
	  $('#photoUploadWarning').fadeIn('slow');
}

function removePhoto(photoNum)
{
	if (!(photoNum == 1 && existedBlogPhoto))
	{
	  api.sendSimpleRequest(api.hostname+"/backend/ajax.php?service=image&method=RemovePhoto&id="+photos[photoNum - 1].id, null, null, true);
      photos[photoNum - 1] = null;
	}
	$('#photo'+photoNum).empty().remove();
	$('#photoUploadWarning').fadeIn('slow');
	return false;
}

function sortGenres(a, b)
{
	var temp = [a.name, b.name];
	temp.sort();
	if (temp[0] == a.name)
	  return -1;
	else
	  return 1;
	// no need to return 0 (equal) as in theory all genres will be unique thanks to table pk
}

function addBlogGenre(value, key)
{
	clearGenreDropDown();
	document.getElementById('genreInput').value = "";
	insertGenreOption(value, key);
}

function filterGenres(word)
{
	document.getElementById('genreFilter').innerHTML = "";
	if (word.length != 0)
	{
	  $active = null;
	  var foundMatch = false;
	  word = word.toLowerCase();
	  for (var genre in genres)
	  {
	    if (genres[genre].name.toLowerCase().substr(0, word.length) == word)
		{
		  foundMatch = true;
		  var searchResult = document.createElement('div');
		  searchResult.innerHTML = genres[genre].name;
		  searchResult.className = "dropDownOption";
		  searchResult.setAttribute("genreId", genres[genre].id);
		  $(searchResult).bind({
            mouseover: function(e) {
			  $('#genreFilter div').removeClass("selected");
			  e.target.className += " selected";
            },
			mouseout: function(e) {
			  e.target.className = e.target.className.replace(/ selected/g, '');
            },
			click: function(e) {
              addBlogGenre(e.target.innerHTML, e.target.getAttribute("genreId"));
            }
		  });
	      document.getElementById('genreFilter').appendChild(searchResult);
		}
	  }
	  if (foundMatch)
	    document.getElementById('genreFilter').style.display = "block";
	  else
	    document.getElementById('genreFilter').style.display = "none";
	}
	else
	  document.getElementById('genreFilter').style.display = "none";
}

function clearGenreDropDown()
{
	document.getElementById('genreFilter').innerHTML = "";
	document.getElementById('genreFilter').style.display = "none";
	$active = null;
}

function toggleGenreOption(code)
{
	if (code == 40)
	{
		if ($active == null)
		  $active = $('#genreFilter div:first');
		else
		{
		  $active = $('#genreFilter div.selected').next(); //Move to the next paging
          if ( $active.length === 0) { //If paging reaches the end...
              $active = $('#genreFilter div:first'); //go back to first
		  }
		}
		$('#genreFilter div').removeClass("selected");
		$active.addClass("selected");
	}
	else
	{
		if ($active == null)
		  $active = $('#genreFilter div:last');
		else
		{
		  $active = $('#genreFilter div.selected').prev(); //Move to the next paging
          if ( $active.length === 0) { //If paging reaches the end...
              $active = $('#genreFilter div:last'); //go back to last
		  }
		}
		$('#genreFilter div').removeClass("selected");
		$active.addClass("selected");
	}
}

$(document).ready(function()
{
  $('#originalBlogDescription').val($('#originalBlogDescription').val().replace(/\\n\\n/g, "\n\n"));
  $('#blogDescription').val($('#originalBlogDescription').val());
  $('#originalBlogDescription').empty().remove();
  $('#blogDescription').TextAreaExpander(260, 1000);
  
  document.getElementById('upload_iframe').contentWindow.document.body.style.background = "#0a0a0a";
  
  var genres = document.getElementById('genres');
  if (genres.options.length == 0)
    $('#genreEmptyWarning').fadeIn('slow');
	
  if ($('#blogPhotoId').val() != '')
  {
	  existedBlogPhoto = true;
	  var photo = {
		id : $('#blogPhotoId').val()
      };
	  document.getElementById('addedPhotos').style.display = "block";
	  addPhoto(photo);
	  $('#blogPhotoId').empty().remove();
  }
  
  $('#genreInput').bind('keyup', function(e) // e is a jquery event object - NOT native js event object
  { 
      var code = e.keyCode | e.which;
	  if (code != 40 && code != 38 && code != 13 && code != 27)
	  {
        filterGenres(e.target.value);
	  }
  });
  
  $('#genreInput').bind('keydown', function(e) // e is a jquery event object - NOT native js event object
  { 
      var code = e.keyCode | e.which;
	  if (code == 13 || code == 9)
	  {
		if ($('#genreFilter div.selected').size() != 0)
	      $('#genreFilter div.selected').trigger('click');
	    e.preventDefault();
	  }
	  else if (code == 40 || code == 38)
	  {
	    toggleGenreOption(code);
	    e.preventDefault();
	  }
	  else if (code == 27)
	  {
		clearGenreDropDown();
	  }
  });
  
  $('#genreInput').bind('focus', function(e) // e is a jquery event object - NOT native js event object
  {
      filterGenres(e.target.value);
  });
  
  $('#genreInput').bind('blur', function(e) // e is a jquery event object - NOT native js event object
  { 
      if ($('#genreFilter div.selected').size() != 0 && api.mouseOverElement('genreFilter'))
	    $('#genreFilter div.selected').trigger('click');
	  else
	  {
		clearGenreDropDown();
	  }
  });
  
  $('#blogForm').bind('keypress', function(e) // e is a jquery event object - NOT native js event object
  { 
    var code = e.keyCode | e.which;
    if(e.target.type != "textarea" && code == 13) { //Enter keycode
      e.preventDefault();
    }
  });
});

function blogDispose() // remove unused photo if there is one
{
	if ($('#photo'+photos.length).size() > 0 && (photos.length > 1 || !existedBlogPhoto))
	{
	  api.sendSimpleRequest(api.hostname+"/backend/ajax.php?service=image&method=RemovePhoto&id="+photos[photos.length - 1].id, null, null, true);
	}
}

window.onbeforeunload = blogDispose;