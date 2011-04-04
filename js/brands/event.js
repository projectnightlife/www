var selectedEvent = 3;

$('#eventNext').bind('click', function()
  {
	if($("#eventReel:animated").length == 0) {
		var offset = (parseInt($("#eventReel").css("left"), 10));
		$("#eventReel").animate({
        	left: -191 + offset
   		}, 300);
	}
	api.getElem("event"+selectedEvent).style.webkitTransform = 'scale(1)';
	selectedEvent--;
	api.getElem("event"+selectedEvent).style.webkitTransform = 'scale(1.175)';
	return false;
  });
  $('#eventPrev').bind('click', function()
  {
	if($("#eventReel:animated").length == 0) {
		var offset = (parseInt($("#eventReel").css("left"), 10));
		$("#eventReel").animate({
            left: 191 + offset
   	 	}, 300);
	}
	api.getElem("event"+selectedEvent).style.webkitTransform = 'scale(1)';
	selectedEvent++;
	api.getElem("event"+selectedEvent).style.webkitTransform = 'scale(1.175)';
	return false;
  });
