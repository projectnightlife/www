function upgradeBrowser() {
	alert("Your browser is too old to view this webpage, please upgrade to Internet Explorer 9");
}

$(document).ready(function(){
		
  $('.rnd10px').corner("10px");
  $('.rnd6px').corner("6px");
  $('.rndbtm6px').corner("6px bottom");
  $('.rndtop6px').corner("6px top");
  $('.rndbtmlft6px').corner("6px bl");	
  $('.rndrgt8px').corner("8px tr br");
  
  //$("a[rel^='prettyPhoto']").prettyPhoto({theme:'facebook', opacity: 0.20});
  
  //$.prettyPhoto.open('#xml','','');
  
  displayDialogue();
		
  $('.heros').cycle({ 
    fx:    'fade', 
    speed:  1100,
    timeout:  10000
  });

});

function displayDialogue()
{
	var width = 600;
	var height = 250;
	
	var dialogue = document.createElement('div');
	dialogue.style.position = 'absolute';
	dialogue.style.left = '20px';
	dialogue.style.top = '50px';
	dialogue.style.width = width;
	dialogue.style.height = height;
	dialogue.style.background = '#fff';
	dialogue.style.zIndex = '10000';
	document.body.appendChild(dialogue);
}