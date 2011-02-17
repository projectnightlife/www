function injectPosts(response)
{
	var posts = response.local.length;
	var more = $('#posts')[0].removeChild($('#posts li:last')[0]);
	var pageSize = parseInt($(more).children().children('a')[0].getAttribute("pagesize"), 10);
	for (var post in response.local)
	{
		var li = document.createElement('li');
		li.innerHTML = '<div class="thumb"><a class="thumb" href="/post/'+response.local[post].id+'"><img src="'+api.hostname+'/photo/'+response.local[post].thumbnail+'/80x80" width="80" height="80" /></a></div><div class="description"><div class="heading"><h4 class="left text-overflow" style="margin-bottom: 0;"><a href="/post/'+response.local[post].id+'">'+response.local[post].title+'</a></h4><span class="datetime right">'+response.local[post].created+'</span></div><span class="datetime" style="margin-bottom: 8px; display: block;">'+response.local[post].blogName+'</span><p class="word-wrap">'+response.local[post].excerpt+'</p></div>';
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

var togglePosts = true; // default state representing recent posts
var existsTrending = false;

function unpackTrendingPosts(response)
{
	api.data = response;
	existsTrending = true;
	
	var trendingPosts = document.createElement('ul');
	trendingPosts.id = "trendingPosts";
	trendingPosts.style.display = "none";
	$(trendingPosts).addClass("UIobjectlist listw630");
	for (var post in response.local)
	{
		var li = document.createElement('li');
		li.innerHTML = '<div class="thumb"><a class="thumb" href="/post/'+response.local[post].id+'"><img src="'+api.hostname+'/photo/'+response.local[post].thumbnail+'/80x80" width="80" height="80" /></a></div><div class="description"><div class="heading"><h4 class="left text-overflow" style="margin-bottom: 0;"><a href="/post/'+response.local[post].id+'">'+response.local[post].title+'</a></h4><span class="datetime right">'+response.local[post].created+'</span></div><span class="datetime" style="margin-bottom: 8px; display: block;">'+response.local[post].blogName+'</span><p class="word-wrap">'+response.local[post].excerpt+'</p></div>';
		trendingPosts.appendChild(li);
	}
	$('#posts').parent()[0].appendChild(trendingPosts);
	$('#trendingPosts > li:last').addClass("last");
	
	animateSwitch();
	
	$('#trendingPosts').fadeIn("slow");
}

function animateSwitch()
{
	$('#postFilter .selected').animate({ 
 		backgroundColor: '#0a0a0a'
	}, 400);
	$('#postFilter .selected a').animate({ 
		color: '#bbb'
	}, 200);
	$('#postFilter .selected').addClass("transitioning").removeClass("selected");
	$('#postFilter .notSelected').corner("8px");
	$('#postFilter .notSelected').addClass("selected");
	$('#postFilter .notSelected').css("backgroundColor", "#0a0a0a");
	$('#postFilter .notSelected').animate({ 
		backgroundColor: '#969696'
	}, 700);
	$('#postFilter .notSelected a').animate({ 
		color: '#111'
	}, 250);
	$('#postFilter .notSelected').addClass("selected").removeClass("notSelected");
	$('#postFilter .transitioning').addClass("notSelected").removeClass("transitioning");
}

function togglePostsSwitch(toggle)
{
  if (togglePosts != toggle) // ensure only toggles when clicking on the unselected switch
  {
	if (togglePosts && !existsTrending)
	  api.sendSimpleRequest(api.hostname+"/backend/ajax.php?service=blog&method=GetTrendingPosts&&amount=8", "unpackTrendingPosts", "togglePostsSpinner", false);
	
	if (togglePosts)
	  $('#posts').fadeOut("slow");
	else
	  $('#trendingPosts').fadeOut("slow");
	  
	if (existsTrending)
	{
	  animateSwitch();
	}
	
	if (togglePosts && existsTrending)
	  $('#trendingPosts').fadeIn("slow");
	else if (!togglePosts)
	  $('#posts').fadeIn("slow");
	
	togglePosts = !togglePosts;
  }
  return false;
}

$(document).ready(function()
{  
  $('.rnd8px').corner("8px");
  $("#mainFeaturedApp #pagingWindow a:first").addClass("active");
  var imageWidth = $("#mainFeaturedApp #imageWindow").width();
  var imageSum = $("#mainFeaturedApp #imageWindow #imageReel img").size();
  var imageReelWidth = imageWidth * imageSum;

  //Adjust the image reel to its new size
  $("#imageReel").css("width", imageReelWidth);  
  
  rotate = function() {
      var triggerID = $active.attr("rel") - 1; //Get number of times to slide
      var image_reelPosition = triggerID * $("#mainFeaturedApp #imageWindow").width(); //Determines the distance the image reel needs to slide

      $("#mainFeaturedApp #pagingWindow a").removeClass('active'); //Remove all active class
      $active.addClass('active'); //Add active class (the $active is declared in the rotateSwitch function)

      //Slider Animation
      $("#mainFeaturedApp #imageWindow #imageReel").animate({
          left: -image_reelPosition
      }, 1500 );
	  $('#mainFeaturedApp #descriptionWindow #descriptionReel').animate({
	      top: '-'+(triggerID * 312)
	  }, 1500);
  };
  
  rotateSwitch = function(){
      play = setInterval(function(){ //Set timer - this will repeat itself every 7 seconds
          $active = $('#mainFeaturedApp #pagingWindow a.active').next(); //Move to the next paging
          if ( $active.length === 0) { //If paging reaches the end...
              $active = $('#mainFeaturedApp #pagingWindow a:first'); //go back to first
          }
          rotate();
      }, 10000); //Timer speed in milliseconds (7 seconds)
  };
  
  rotateSwitch()

  //On Hover
  $("#mainFeaturedApp #descriptionWindow, #mainFeaturedApp #imageWindow").hover(function() {
        clearInterval(play); //Stop the rotation
      }, function() {
        rotateSwitch(); //Resume rotation timer
  });	

  //On Click
  $("#mainFeaturedApp #pagingWindow a").click(function() {
      $active = $(this); //Activate the clicked paging
      //Reset Timer
      clearInterval(play); //Stop the rotation
      rotate(); //Trigger rotation immediately
      rotateSwitch();
      return false; //Prevent browser jump to link anchor
  }); 
}); // document ready