$('#eventNext').bind('click', function()
  {
	if($("#eventReel:animated").length == 0) {
		var offset = (parseInt($("#eventReel").css("left"), 10));
		$("#eventReel").animate({
        	left: -200 + offset
   		}, 300);
	}
	return false;
  });
  $('#eventPrev').bind('click', function()
  {
	if($("#eventReel:animated").length == 0) {
		var offset = (parseInt($("#eventReel").css("left"), 10));
		$("#eventReel").animate({
            left: 200 + offset
   	 	}, 300);
	}
	return false;
  });