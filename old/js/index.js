$(document).ready(function(){

  $('.tabs #music').mouseenter(function() {
    $('.tabs #musicDescription').animate({
      top: '0'
      }, 250, function() {
	    // callback.
    });
  });

  $('.tabs #music').mouseleave(function() {
    $('.tabs #musicDescription').animate({
      top: '55'
      }, 250, function() { 
	    // callback.
    });
  });
  
  $('.tabs #events').mouseenter(function() {
    $('.tabs #eventsDescription').animate({
      top: '0'
      }, 250, function() { 
	    // callback.
    });
  });

  $('.tabs #events').mouseleave(function() {
    $('.tabs #eventsDescription').animate({
      top: '55'
      }, 250, function() { 
	    // callback.
    });
  });
		
  $('.tabs #venues').mouseenter(function() {
    $('.tabs #venuesDescription').animate({
      top: '0'
      }, 250, function() { 
	    // callback.
    });
  });

  $('.tabs #venues').mouseleave(function() {
    $('.tabs #venuesDescription').animate({
      top: '55'
      }, 250, function() { 
	    // callback.
    });
  });
		
  $('.tabs #photos').mouseenter(function() {
    $('.tabs #photosDescription').animate({
      top: '0'
      }, 250, function() { 
	    // callback.
    });
  });

  $('.tabs #photos').mouseleave(function() {
    $('.tabs #photosDescription').animate({
      top: '55'
      }, 250, function() { 
	    // callback.
    });
  });
  
});