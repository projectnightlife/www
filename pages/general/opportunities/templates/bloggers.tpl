{include file='../../includes/templates/page.tpl'}
<title>Blog For Us | Project Nightlife</title>
<link rel="stylesheet" href="css/blogs.css" type="text/css" media="screen, projection">
  <style type="text/css">
input[type="text"] { float: left; width: 465px; background: #121212; border-color: #252525; padding: 7px; color: #ccc; font-size: 12px; font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; }
textarea { float: left; width: 425px; height: 125px; background: #121212; border-color: #252525; padding: 7px; color: #ccc; margin: 0; font-size: 12px; font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; }
div#reel { position: absolute; width: 4790px; height: 377px; left: 0; top: 0; }
div#reel div.slide { display: block; float: left; width: 938px; height: 357px; margin: 10px; }
select { font-size: 12px; font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; background: #121212; border-color: #252525; color: #ccc; }
.UIinputPanel { background-color:#0f0f0f; padding: 10px; overflow: auto; -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px; border: 1px solid #111; }
.UIinputPanelHeading { font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; font-size: 16px; color: #ABA0C0; line-height: 16px; }
.slideHeading { margin: 0; font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; font-size: 28px; color: #ABA0C0; line-height: 36px; }
</style>
</head>



<body id="blogs">
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="canvas">
      
      
      <form id="blogForm" name="blogForm" action="backend/ajax.php" ajaxify="1" callback="requestSent" spinner="requestSpinner:001" errorCallback="requestError" onFormSubmit="submitRequest" autocomplete="off">
      
      <div class="span960" style="position: relative;">
        <div id="genreFilter" class="dropDown" style="z-index: 10000; top: 156px; left: 538px;"></div>
        <div class="UIpanel" style="position: relative; overflow: hidden; width: 958px; height: 377px; padding: 0;">
          <div id="reel">
            <div class="slide">
              <img style="display: block; float: left; padding: 30px;" src="images/blog_for_us.png" />
              <div style="float: left; padding: 130px 40px 0; width: 360px;">
                <h1 style="margin: 0; font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; font-size: 28px; color: #ABA0C0; line-height: 36px;">Blog for Project Nightlife</h1>
                <h2 style="margin-top: 5px; font-size: 18px; line-height: 26px; font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">The wait is finally over. We're ready for you to become part of<!--join--> the web's hottest new music and fashion resource.</h2>
                {if $session['loggedIn']}
                <a class="join" href="#" onclick="return slideLeft();">Join Now</a>
                {else}
                <a class="join" href="#" onclick="location.hash = '#resume'; api.fbregister(); return false;">Join Now</a>
                {/if}
              </div>
            </div> <!-- slide -->
            {if $session['loggedIn'] && !$session['ownsBlog']}
            <div class="slide">
              <div style="height: 330px;">
                <h1 class="slideHeading">Join Us</h1>
                <div style="padding: 45px 0;">
                    <input type="hidden" name="params" value='{ "service":"blog","method":"AddOrUpdateBlog", "id":"" }' autocomplete="off" />
                    <input id="submitBlog" type="submit" style="display: none;" />
                    <div class="UIinputPanel" style="margin: 6px auto; width: 595px;">
                      <h3 class="UIinputPanelHeading" style="margin-bottom: 10px;">Start with the name of your blog</h3>
                      <input id="name" type="text" name="name" validator="validateName" maxlength="128" />
                    </div>
                    <div class="UIinputPanel" style="margin: 6px auto; width: 595px;">
                      <h3 class="UIinputPanelHeading" style="margin-bottom: 10px;">Dream up a slogan</h3>
                      <input id="slogan" type="text" name="slogan" maxlength="255" />
                      <div style="float: left; padding: 11px 20px;">Optional</div>
                    </div>
                  <!--</form>-->
                </div> <!-- padding: 50px 0; -->
              </div>
              <a class="next" href="#" onclick="return slideLeft();">Next</a>
            </div> <!-- slide -->
            <div class="slide">
              <div style="height: 330px;">
                <h1 class="slideHeading">Join Us</h1>
                <div style="padding: 30px 0;">
                  <div class="UIinputPanel" style="margin: 6px auto; width: 595px;">
                    <h3 class="UIinputPanelHeading" style="margin-bottom: 15px;">Enter a description</h3>
                    <textarea id="description" validator="validateDescription" name="description" onKeyDown="api.limitText(this,4000);" onKeyUp="api.limitText(this,4000);" onchange="api.limitText(this,4000);"></textarea>
                    <div style="float: left; padding: 0 15px;">A brief description<br /> of who you are and<br />  what you blog about.<br /><br />You can enter a short<br /> description now and<br /> update it later.</div>
                  </div>
                </div> <!-- padding: 50px 0; -->
              </div>
              <a class="previous" href="#" onclick="return slideRight();">Previous</a>
              <a class="next" href="#" onclick="return slideLeft();">Next</a>
            </div> <!-- slide -->
            <div class="slide">
              <div style="height: 330px;">
                <h1 class="slideHeading">Join Us</h1>
                <div style="padding: 30px 0; overflow: auto;">
                  <div style="margin: 0 auto; width: 654px; overflow: auto;">
                    <div class="UIinputPanel" style="float: left; width: 300px; height: 190px; -webkit-border-top-right-radius: 0; -webkit-border-bottom-right-radius: 0; -moz-border-top-right-radius: 0; -moz-border-bottom-right-radius: 0; border-top-right-radius: 0; border-bottom-right-radius: 0;">
                      <h3 class="UIinputPanelHeading">Choose a mugshot</h3>
                      
                      <div class="UIsinglePhotoUpload">
                        <div id="addedPhotos" class="addedContent" style="display: block; margin: 0.5em auto; width: 88px; height: 118px;"></div>
                        <div class="addContentContainer" style="margin: 0;">
                          <div id="photo_upload" style="display: block;">
                            <iframe style="width: 240px !important; margin: 0 auto !important; display: block; overflow: hidden;" id="upload_iframe" src="http://www.projectnightlife.co.uk/blogupload.php?type=BlogUploadProfile" frameborder="0" scrolling="no"></iframe>
                          </div>
                          <div id="uploading" style="width: 140px; margin: 0 auto;">
                            <img src="images/core/spinners/001.gif" />
                            <span style="margin-left: 10px;">Uploading Photo...</span>
                          </div>
                        </div>
                      </div>
                      <input type="hidden" name="thumbnail" serializable="serializeThumbnail" value="" autocomplete="off" />
                      
                    </div>
                    <div class="UIinputPanel" style="float: right; width: 300px; height: 190px; -webkit-border-top-left-radius: 0; -webkit-border-bottom-left-radius: 0; -moz-border-top-left-radius: 0; -moz-border-bottom-left-radius: 0; border-top-left-radius: 0; border-bottom-left-radius: 0;">
                      <h3 class="UIinputPanelHeading" style="margin-bottom: 15px;">Select some genres</h3>
                      <div style="width: 215px; margin: 0 auto;">
                        <div style="position: relative; z-index: 100;" id="genreContainer">
                          <input id="genreInput" name="helper" class="UIoptionInput" type="text" style="float: none !important; color: #999; font-style: italic;" value="type here and select results..." autocomplete="off" />
                          
                        </div>
                        <select id="genres" name="genres" class="UIoptions" serializable="serializeGenres" validator="validateGenres" size="3"></select>
                        <label class="uiButton" style="margin: 1em 0;">
                          <input type="button" onclick="removeGenreOption()" value="Remove genre" />
                        </label>
                      </div>
                    </div>
                  </div>
                </div> <!-- padding: 50px 0; -->
              </div>
              <a class="previous" href="#" onclick="return slideRight();">Previous</a>
              <a class="next" href="#" style="width: 95px;" onclick="return submitHandler();">Finish</a>
            </div> <!-- slide -->
            <div class="slide">
              <h1 class="slideHeading" id="confirmation">Contacting Server</h1>
              <div id="spinnerContainer" style="margin: 140px auto; width: 16px; text-align: center; font-size: 18px; line-height: 26px; font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;"><div id="requestSpinner" class="ajaxSpinner"></div></div>
            </div> <!-- slide -->
            {else if $session['ownsBlog']}
            <div class="slide">
              <h2 style="margin: 170px auto 150px; font-size: 18px; line-height: 26px; font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; width: 230px;">You already have a blog</h2>
            </div> <!-- slide -->
            {/if}
            
          </div>
        </div>
      </div>
      
      </form>
          
        <div class="span310 topspcr15">
          <div class="UIpanel" style="height: 170px; border-color: #111; font-family: Tahoma, Geneva, sans-serif;">
            <h3 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; font-size: 24px; color: #ABA0C0; margin-bottom: 16px; line-height: 26px;">Who Should Apply</h3>
		    <p>Project Nightlife are always on the lookout for talented new bloggers.</p><p class="last-child">Are you passionate about an area we haven't got covered? Maybe you're studying to be a journalist? Or do you simply want to share your knowledge and opinions with others?</p>
          </div>
        </div>
        <div class="span310 leftspcr15 topspcr15">
          <div class="UIpanel" style="height: 170px; border-color: #111; font-family: Tahoma, Geneva, sans-serif;">
            <h3 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; font-size: 24px; color: #ABA0C0; margin-bottom: 16px; line-height: 26px;">Rewards</h3>
            <p>To make up for the time you dedicate to us, we'll give you the chance to go backstage at your favorite gigs and events or attend the hottest nights - absolutely free!<sup class="terms">1</sup></p><p class="last-child">And... to top it all off, we'll even pay you to write for us!<sup class="terms">2</sup></p>
          </div>
        </div>
        <div class="span310 leftspcr15 topspcr15">
          <div class="UIpanel" style="height: 170px; border-color: #111; font-family: Tahoma, Geneva, sans-serif;">
            <h3 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; font-size: 24px; color: #ABA0C0; margin-bottom: 16px; line-height: 26px;">Current Openings</h3>
            <p>We're currently looking to expand the music and fashion areas of our blogs.</p><p class="last-child">To become one of our bloggers, simply click Join Now</p><!--<p>If you want to know more, simply register your interest by click 'Apply Now' and we'll be in touch shortly.</p>-->
          </div>
        </div>
        
      </div> <!-- canvas -->
    </div> <!-- container -->
    <div class="push"></div>
  </div> <!-- wrapper -->
  {include file='../../includes/templates/footer.tpl'}
  <div id="fb-root"></div>
</body>
</html>
{include file='../../includes/templates/js.tpl'}
{if $session['loggedIn']}
<script type="text/javascript">
function slideLeft()
{
	var offset = (parseInt($("#reel").css("left"), 10));
	$("#reel").animate({
        left: -958 + offset
    });
	return false;
}

function slideRight()
{
	var offset = (parseInt($("#reel").css("left"), 10));
	$("#reel").animate({
          left: 958 + offset
      }, 1000 );
	return false;
}

$(document).ready(function()
{
	if (window.location.href.lastIndexOf("#resume") != -1)
	  slideLeft();
});
</script>
{/if}

{if $session['loggedIn'] && !$session['ownsBlog']}
<script type="text/javascript">
var photos = new Array();
function submitHandler()
{
	document.getElementById('submitBlog').click();
	return false;
	
}

function submitRequest()
  {
	//document.getElementById('sendRequest').disabled = true;
	var offset = (parseInt($("#reel").css("left"), 10));
	$("#reel").animate({
        left: -958 + offset
    });
  }
  
  function requestError()
  {
      slideRight();
  }
  
  function requestSent(response)
  {
	  $("#requestSpinner").empty().remove();
	  document.getElementById('confirmation').innerHTML = "Success";
	  document.getElementById('spinnerContainer').style.width = "500px";
	  document.getElementById('spinnerContainer').style.marginTop = "90px";
	  document.getElementById('spinnerContainer').innerHTML = "<p>Great, you're all set up and ready to start blogging.</p><p>In just a moment we'll redirect you to your Blog's control panel, where you can create your first post.</p>";
	  setTimeout('window.location = "/blog/edit#welcome";', 6000);
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
	if (photos.length == 0 || photos[photos.length - 1] == null || photos.length == 1)
	{
      return "";
	}
	else
	{
	  return photos[photos.length - 1].id;
	}
}

function validateName(input)
{
	var valid = true;
	var pattern = /\s+/g; // all white space characters (selecting consecutive as one) not stopping at the first (\n \t space etc...)
	
	if(!input.replace(pattern, "").length > 0)
	{
	  valid = false;
	  api.error = "Please enter the name of your blog";
	  $("#reel").animate({
        left: -958 
      });
	}
	return valid;
}

function validateDescription(input)
{
	var valid = true;
	var pattern = /\s+/g; // all white space characters (selecting consecutive as one) not stopping at the first (\n \t space etc...)
	
	if(!input.replace(pattern, "").length > 0)
	{
	  valid = false;
	  api.error = "Please provide a brief description of your blog";
	  $("#reel").animate({
        left: -1916 
      });
	}
	return valid;
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
	}
	else
	{
		api.launchDialog("Please select a genre to remove");
	}
	if (genres.options.length == 0)
      $('#genreEmptyWarning').fadeIn('slow');
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
	  document.getElementById('upload_iframe').contentWindow.document.body.style.background = "#0f0f0f";
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
    image.src = "http://www.projectnightlife.co.uk/photo/"+newPhoto.id+"/80x80";
	image.style.height = "80px";
	image.style.width = "80px";
	var holder = document.createElement('div');
	holder.className = 'mediaPreviewControl';
	holder.style.width = "88px";
	holder.style.margin = "15px auto";
	holder.style.float = "none";
	holder.id = 'photo'+photos.length;
	holder.appendChild(image);
	  
	holder.innerHTML += '<a href="#" onclick="return removePhoto('+photos.length+')" class="remove" title="remove"><img src="/images/core/icons/remove.png" /></a>';
	
	addedPhotos.appendChild(holder);
}

function removePhoto(photoNum)
{
	if (!(photoNum == 1))
	{
	  api.sendSimpleRequest("http://www.projectnightlife.co.uk/backend/ajax.php?service=image&method=RemovePhoto&id="+photos[photoNum - 1].id, null, null, true);
      photos[photoNum - 1] = null;
	}
	$('#photo'+photoNum).empty().remove();
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
	addPhoto({ id : 1 });
	document.getElementById('upload_iframe').contentWindow.document.body.style.background = "#0f0f0f";
	
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
	  if (e.target.value == "type here and select results...")
	  {
	    e.target.value = "";
		e.target.style.color = "#ccc";
		e.target.style.fontStyle = "normal";
	  }
	  else
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

var genres = new Array(
{foreach from=$genres item=genre name=genres}
  { id:{$genre->id}, name:'{$genre->name}' }{if !$smarty.foreach.genres.last},{/if}
{/foreach}
);

genres.sort(sortGenres);

</script>
{/if}