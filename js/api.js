function API()
{
  this.appId = "1"; // Website application id for platform communication
  this.hostname = "http://"+window.location.hostname;
  this.dialog = "dialogPositioner"; // enables us to change the name of the dialog id
  this.msgDialog = "msgDialogPositioner"; // enables us to change the name of the dialog id
  this.dialogErrorTitle = "Oops, something went wrong";
  this.dialogErrorMessage = '<p style="margin-bottom: 1em;">Please try again in a moment.</p><p><a href="#" onclick="return api.NotifyOfError();" style="background: url('+this.hostname+'/images/core/icons/single_pink_chevron.png) no-repeat 0 2px; padding-left: 12px;">If this problem persists, please let us know</a>.</p>';
  this.ajaxNotSupportedMsg = "Your browser is too old to interact properly with this page, please update it to the latest version.";
  this.upgradeBrowser = "Your browser is too old to view this webpage, please upgrade to Internet Explorer 9";
  this.debug = false;
  this.error = "";
  this.data = null;
  this.keycode = 0;
  this.mousePageCoords = { x : null, y : null };
  this.contactus = function() {
	  if (api.session.data.userId == 0)
	    return '<input type="hidden" name="userId" value="0" autocomplete="off" /><div class="fieldSet"><div class="label">Name</div><input type="text" name="name" validator="api.validation.name" autocomplete="off" /></div><div class="fieldSet"><div class="label">Email</div><input type="text" name="email" validator="api.validation.email" autocomplete="off" /></div><div class="fieldSet"><div class="label">Subject</div><input type="text" name="subject" validator="api.validation.nonEmpty" autocomplete="off" /></div><div class="fieldSet last"><div class="label">Body</div><textarea id="messageBody" name="body" validator="api.validation.nonEmpty"></textarea></div>';
	  else if (api.session.data.email == "")
	    return '<input type="hidden" name="userId" value="'+api.session.data.userId+'" autocomplete="off" /><input type="hidden" name="name" value="'+api.session.data.firstname+' '+api.session.data.lastname+'" autocomplete="off" /><div class="fieldSet"><div class="label">Email</div><input type="text" name="email" validator="api.validation.email" autocomplete="off" /></div><div class="fieldSet"><div class="label">Subject</div><input type="text" name="subject" validator="api.validation.nonEmpty" autocomplete="off" /></div><div class="fieldSet last"><div class="label">Body</div><textarea id="messageBody" name="body" validator="api.validation.nonEmpty"></textarea></div>';
	  else
	    return '<input type="hidden" name="userId" value="'+api.session.data.userId+'" autocomplete="off" /><input type="hidden" name="name" value="'+api.session.data.firstname+' '+api.session.data.lastname+'" autocomplete="off" /><input type="hidden" name="email" value="'+api.session.data.email+'" autocomplete="off" /><div class="fieldSet"><div class="label">Subject</div><input type="text" name="subject" validator="api.validation.nonEmpty" autocomplete="off" /></div><div class="fieldSet last"><div class="label">Body</div><textarea id="messageBody" name="body" validator="api.validation.nonEmpty"></textarea></div>';
  };
  this.getElem = function(id)
  {
	  return document.getElementById(id);
  };
  
  // Javascript bootstraper //
  
  this.bootstrap = {
  	  loadjs:function(url, callback)
	  {
		var script = document.createElement('script');
		script.type = "text/javascript";
		script.onload = function() { callback(); };
		script.src = url;
		document.getElementsByTagName('head')[0].appendChild(script);
	  }
  };
  
  if (window.location.href.lastIndexOf("debug") != -1)
  {
	  this.debug = true;
	  $('a[ajaxify!="1"]').attr('href', function () 
	  {
		  if ($(this).attr('href').lastIndexOf('?') != -1)
		    return $(this).attr('href') + '&debug';
		  else
		    return $(this).attr('href') + '?debug';
	  }); 
  }
  
  // add forEach functionality to old browsers, although ie adds it as an elemen to the array so wen calling for on array, foreach is an element! doh!
  /*if (!Array.prototype.forEach)
  {
    Array.prototype.forEach = function(fun /*, thisp *///)
    /*{
      "use strict";

      if (this === void 0 || this === null)
        throw new TypeError();

      var t = Object(this);
      var len = t.length >>> 0;
      if (typeof fun !== "function")
        throw new TypeError();

      var thisp = arguments[1];
      for (var i = 0; i < len; i++)
      {
        if (i in t)
          fun.call(thisp, t[i], i, t);
      }
    };
  }*/
  
  // call function name if held as string - this implementation doesn't work in ie
  //this.executeFunctionByName = function(functionName, context /*, args */) {
  	/*var args = Array.prototype.slice.call(arguments).splice(2);
  	var namespaces = functionName.split(".");
  	var func = namespaces.pop();
  	for(var i = 0; i < namespaces.length; i++) {
    	context = context[namespaces[i]];
  	}
  	return context[func].apply(this, args);
  }*/
  
  
  // call function name if held as string
  this.executeFunctionByName = function(functionName, context, args) {
  	//var args = Array.prototype.slice.call(arguments).splice(2);
  	var namespaces = functionName.split(".");
  	var func = namespaces.pop();
  	for(var i = 0; i < namespaces.length; i++) {
    	context = context[namespaces[i]];
  	}
  	return context[func](args);
  };
  
  /* facebook js api methods */
  
  this.fbrequest = function(request) {
	  if (request == 'fblogin')
	    this.fbconnect();
	  else if (request == 'fblogout')
	    this.fbdisconnect();
	  else if (request == 'fbregister')
	    this.fbregister();
  };
  
  this.fbconnect = function() {
	  FB.login(function(response) {
        if (response.session) { // ok, we've logged them in, now reload the current page
          window.location.reload();
        }
	  }, {perms:'user_birthday,email,publish_stream'});
  };
  
  this.fbdisconnect = function() {
	  FB.logout(function(response) {
        // user is now logged out
		window.location.reload();
      });
  };
  
  this.fbregister = function() {
	  api.launchRegisterDialog('<div id="registerDialog"><div id="registerSpinner" class="ajaxSpinner" style="display: block; float: none; margin: 10px auto 0;"></div></div>', 700);
	  api.sendSimpleRequest(this.hostname+"/backend/ajax/register.php", "api.registerPopup", "registerSpinner", false);
  };
  
  this.registerPopup = function(response) {
	  try{ // user may have closed register dialog if request takes too long
	    $('#registerSpinner').empty().remove();
		$('#registerDialog').html(response);
	  }
  	  catch(e) {}
  };
  
  this.updateRegisterDialog = function()
  {
	  this.fbconnect();
	  $('#registerDialog').empty().remove();
	  $("<div style=\"margin: 120px auto 81px;\"><div style=\"font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; text-align: center; font-size: 18px; line-height: 26px;\">Just one moment</div><div id=\"requestSpinner\" class=\"ajaxSpinner\" style=\"display: block; background: url("+this.hostname+"/images/core/spinners/001.gif); float: none; margin: 15px auto 7px;\"></div></div>").appendTo(".dialog .content");
	  $('#'+this.dialog+' .buttonSet input').val('Close');
	  return false;
  };
  
  /* dom manipulation methods */
  
  this.getSpinner = function(target) {
	  if (target.getAttribute('spinner'))
        return target.getAttribute('spinner');
      else
        return null;
  };
  
  this.getCallback = function(target) {
	  if (target.getAttribute('callback'))
        return target.getAttribute('callback');
      else
        return null;
  };
  
  this.getErrorCallback = function(target) {
	  if (target.getAttribute('errorcallback'))
        return target.getAttribute('errorcallback');
      else
        return null;
  };
  
  this.getErrorSuppression = function(target) {
	  if (target.getAttribute('suppress'))
        return true;
      else
        return null;
  };
  
  this.insertSpinner = function(id) {
	  if (id)
	  {
		try {
			var spinner = id.split(':');
			if (spinner.length == 1)
			  spinner.push("001");
			var element = api.getElem(spinner[0]);
			element.style.backgroundImage = "url("+this.hostname+"/images/core/spinners/"+spinner[1]+".gif)";
			element.style.backgroundRepeat = "no-repeat";
			element.style.backgroundPosition = "center";
			try {
				element.disabled = true;
			}
			catch (e) {}
		}
		catch (e) {}
	  }
  };
  
  this.removeSpinner = function(id) {
	  if (id)
	  {
		try {
			var spinner = id.split(':')
			var element = api.getElem(spinner[0]);
			element.style.backgroundImage = "none";
			try {
				element.disabled = false;
			}
			catch (e) {}
		}
		catch (e) {}
	  }
  };
  
  // validation //
  
  this.validation = {
	  nonEmpty : function(string)
	  {
		  var valid = true;
		  var pattern = /\s+/g; // all white space characters (selecting consecutive as one) not stopping at the first (\n \t space etc...)
	      if (string.replace(pattern, "").length == 0)
		  {
		    api.error = "Please ensure you've completed all the required fields";
		    valid = false;
	      }
	      return valid;
	  },
	  name : function(string)
	  {
		  var valid = true;
		  var expr = new RegExp("^[A-Za-z -]*[a-z]$", "g"); //crude, needs work ; new RegExp("^([A-Z][a-z]+)([ -](?=[A-Z][a-z]+))*$", "g");
	 	  if (!expr.test(string)) {
	  	    api.error = "Please provide your full name";
	  	    valid = false;
		  }
		  return valid;
	  },
	  email : function(string)
	  {
		  var valid = true;
		  var expr = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
		  if (!expr.test(string)) {
	  	    api.error = "Please provide a valid email address";
	 		return false;
		  }
		  return valid;
	  }
  };
  
  /* sessions */
  this.session = {
	  data : null,
	  populate : function(userId, firstname, lastname, email)
  	  {
	      this.data = 
		  {
			  'userId':userId,
			  'firstname':firstname,
			  'lastname':lastname,
			  'email':email
		  }
		  if (userId != 0) // check to see if their session has expired
		    setTimeout("api.sendSimpleRequest('/backend/ajax.php?service=authentication&method=IsGuestUser', 'api.session.monitor', null, true);", 60000);
	  },
	  monitor : function(response)
	  {
		  if (response[0] == 'true')
		  {
			 FB.logout(function(response) {});
		     api.launchLoggedOutDialog();
		  }
		  else // recursively monitor session every 30 seconds
		    setTimeout("api.sendSimpleRequest('/backend/ajax.php?service=authentication&method=IsGuestUser', 'api.session.monitor', null, true);", 30000);
	  }
  };
  
  /* Notifications */
  
  this.notifications = {
	  data : new Array(),
	  populate : function(thumbnail, title, url, excerpt, time)
	  {
		  this.data.push(
		  {
			  'thumbnail':thumbnail,
			  'title':title,
			  'url':url,
			  'excerpt':excerpt,
			  'time':time
		  });
	  },
	  get : function()
	  {
		  if (this.data.length == 0)
		    return '<div style="text-align: center; font-family: \'Lucida Sans Unicode\', \'Lucida Grande\', sans-serif; font-size: 18px; padding: 15px 0 5px;">No notifications</div>';
		  else
		  {
		    var response = '<div class="notifications">';
			for (var notification in this.data)
			{
			  var position = ""; // the position within the list of notifications
			  if (notification == 0)
			    position = " first";
			  response += '<div class="notification'+position+'"><a href="'+this.data[notification].url+'"><img src="'+this.hostname+'/photo/'+this.data[notification].thumbnail+'/50x50" /></a><div class="details"><h3 class="text-overflow"><a href="'+this.data[notification].url+'">'+this.data[notification].title+'</a></h3><p class="text-overflow">'+this.data[notification].excerpt+'</p><div class="datetime">'+this.data[notification].time+'</div></div></div>';
			}
			response += '<div class="notification last" style="text-align: center;"><a href="'+this.hostname+'/notifications">View all</a></div>';
			response += '</div>';
			return response;
		  }
	  }
  };
  
  /* document info methods */
  
  this.getPageScrollOffsets = function() {
	  // cross browser compliant method for getting page scroll height offset
	  var width = 0, height = 0;
	  if( typeof( window.pageYOffset ) == 'number' ) {
        //Netscape compliant
        width = window.pageXOffset;
		height = window.pageYOffset;
      } else if( document.body && ( document.body.scrollLeft || document.body.scrollTop ) ) {
        //DOM compliant
		width = document.body.scrollLeft;
        height = document.body.scrollTop;
      } else if( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) ) {
        //IE6 standards compliant mode
		width = document.documentElement.scrollLeft;
        height = document.documentElement.scrollTop;
      }
	  return [width, height];
  };
  
  this.getDocumentDimensions = function() {
	  // cross browser compliant method for getting browser's document's dimensions
	  var width = 0, height = 0;
      if( typeof( window.innerWidth ) == 'number' ) {
        //Non-IE
        width = window.innerWidth;
        height = window.innerHeight;
      } else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
        //IE 6+ in 'standards compliant mode'
        width = document.documentElement.clientWidth;
        height = document.documentElement.clientHeight;
      } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
        //IE 4 compatible
        width = document.body.clientWidth;
        height = document.body.clientHeight;
      }
	  return [width, height];
  };
  
  // assumes margin is outside element - a mouse hovering over the element's margin is not over the element
  this.mouseOverElement = function (element) {
	  try{
	  	var marginTop = 0, marginLeft = 0, width = 0, height = 0, top = 0, bottom = 0, left = 0, right = 0;
	  	element = api.getElem(element);
	  
	  	element.style.marginLeft == "" ? null : marginLeft += parseInt(element.style.marginLeft, 10);
	  	element.style.marginTop == "" ? null : marginTop += parseInt(element.style.marginTop, 10);
	  
	  	width = $(element).outerWidth();
	  	height = $(element).outerHeight();
	  
	  	top = $(element).offset().top + marginTop;
	  	bottom = $(element).offset().top + marginTop + height;
	  	left = $(element).offset().left + marginLeft;
	  	right = $(element).offset().left + marginLeft + width;
	  
	  	if (this.mousePageCoords.y > top && this.mousePageCoords.y < bottom && this.mousePageCoords.x > left && this.mousePageCoords.x < right)
	    	return true;
	  	else
	    	return false;
	  }
	  catch(e)
	  {
		  // element name may not exist
		  return false;
	  }
  };
		  
  
  /* Dialog windows */
  
  this.launchDialog = function(title, message, width) {
	  this.forceCloseDialog();
	  var positioner = document.createElement("div");
	  var dialog = document.createElement("div");
	  var dialogBody = document.createElement("div");
	  var heading = document.createElement("div");
	  var content = document.createElement("div");
	  var buttonSet = document.createElement("div");
	  
	  positioner.className = this.dialog;
	  positioner.id = this.dialog;
	  dialog.className = "dialog";
	  if (width != null)
	  {
	    dialog.style.width = width+"px";
		dialogBody.style.width = (width - 4)+"px";
	  }
	  dialog.style.top = ((this.getDocumentDimensions()[1] * 0.2) + this.getPageScrollOffsets()[1]) + "px";
	  dialogBody.className = "body";
	  heading.className = "heading";
	  heading.innerHTML = '<h3>'+title+'</h3>';
	  content.className = "content";
	  content.innerHTML = message;
	  buttonSet.className = 'buttonSet';
	  buttonSet.innerHTML = '<label class="uiButton uiButtonConfirm"><input type="button" value="Close" onclick="return api.closeDialog();" /></label>';
	  dialogBody.appendChild(heading);
	  dialogBody.appendChild(content);
	  dialogBody.appendChild(buttonSet);
	  dialog.appendChild(dialogBody);
	  positioner.appendChild(dialog);
	  document.body.appendChild(positioner);
  };
  
  this.launchConfirmDialog = function(message, callback, arg) {
	  this.forceCloseDialog();
	  var positioner = document.createElement("div");
	  var dialog = document.createElement("div");
	  var dialogBody = document.createElement("div");
	  var heading = document.createElement("div");
	  var content = document.createElement("div");
	  var buttonSet = document.createElement("div");
	  
	  positioner.className = this.dialog;
	  positioner.id = this.dialog;
	  dialog.className = "dialog";
	  dialog.style.width = "475px";
	  dialogBody.style.width = "471px";
	  dialog.style.top = ((this.getDocumentDimensions()[1] * 0.2) + this.getPageScrollOffsets()[1]) + "px";
	  dialogBody.className = "body";
	  heading.className = "heading";
	  heading.innerHTML = '<h3>Confirm</h3>';
	  content.className = "content";
	  content.innerHTML = message;
	  buttonSet.className = 'buttonSet';
	  buttonSet.innerHTML = '<label class="uiButton"><input type="button" value="Cancel" onclick="return api.closeDialog();" /></label><label class="uiButton uiButtonConfirm"><input type="button" onclick="api.closeDialog(); '+callback+'(&quot;'+arg+'&quot;);" value="Confirm" /></label>';
	  dialogBody.appendChild(heading);
	  dialogBody.appendChild(content);
	  dialogBody.appendChild(buttonSet);
	  dialog.appendChild(dialogBody);
	  positioner.appendChild(dialog);
	  document.body.appendChild(positioner);
  };
  
  this.launchRegisterDialog = function(message, width) {
	  this.forceCloseDialog();
	  var positioner = document.createElement("div");
	  var dialog = document.createElement("div");
	  var dialogBody = document.createElement("div");
	  var content = document.createElement("div");
	  var buttonSet = document.createElement("div");
	  
	  positioner.className = this.dialog;
	  positioner.id = this.dialog;
	  dialog.className = "dialog";
	  if (width != null)
	  {
	    dialog.style.width = width+"px";
		dialogBody.style.width = (width - 4)+"px";
	  }
	  dialog.style.top = ((this.getDocumentDimensions()[1] * 0.2) + this.getPageScrollOffsets()[1]) + "px";
	  dialogBody.className = "body";
	  content.className = "content";
	  content.innerHTML = message;
	  buttonSet.className = 'buttonSet';
	  buttonSet.innerHTML = '<label class="uiButton uiButtonConfirm" style="width: inherit !important;"><input type="button" value="No thanks!" onclick="return api.closeDialog();" /></label>';
	  dialogBody.appendChild(content);
	  dialogBody.appendChild(buttonSet);
	  dialog.appendChild(dialogBody);
	  positioner.appendChild(dialog);
	  document.body.appendChild(positioner);
  };
  
  this.launchLoggedOutDialog = function() {
	  this.forceCloseDialog();
	  var positioner = document.createElement("div");
	  var dialog = document.createElement("div");
	  var dialogBody = document.createElement("div");
	  var heading = document.createElement("div");
	  var content = document.createElement("div");
	  var buttonSet = document.createElement("div");
	  
	  positioner.className = this.dialog;
	  positioner.id = this.dialog;
	  dialog.className = "dialog";
	  dialog.style.width = "475px";
	  dialogBody.style.width = "471px";
	  dialog.style.top = ((this.getDocumentDimensions()[1] * 0.2) + this.getPageScrollOffsets()[1]) + "px";
	  dialogBody.className = "body";
	  heading.className = "heading";
	  heading.innerHTML = '<h3>Please log in to continue</h3>';
	  content.className = "content";
	  content.innerHTML = 'You\'ve either become inactive or you\'ve logged out of Facebook. To continue using Project Nightlife, please login. Otherwise continue as a guest.';
	  buttonSet.className = 'buttonSet';
	  buttonSet.innerHTML = '<label class="uiButton"><input type="button" value="Cancel" onclick="return api.closeDialog();" /></label><label class="uiButton uiButtonConfirm"><input type="button" onclick="api.fbconnect();" value="Login" /></label>';
	  dialogBody.appendChild(heading);
	  dialogBody.appendChild(content);
	  dialogBody.appendChild(buttonSet);
	  dialog.appendChild(dialogBody);
	  positioner.appendChild(dialog);
	  document.body.appendChild(positioner);
  };
  
  this.existsDialog = function() {
	return (api.getElem(this.dialog) != null);
  };
  
  this.closeDialog = function() {
	  if (this.existsDialog()) {
	    $('#'+this.dialog).fadeOut('normal');
        setTimeout("api.forceCloseDialog()", 300);
        return false;
	  }
  };
  
  // should really only ever be called internally within the api
  this.forceCloseDialog = function() {
	  if (this.existsDialog()) {
	    document.body.removeChild(api.getElem(this.dialog));
	  }
  };
  
  // Message dialogs //
  
  this.composeMessage = function(title, windowContent, action, userId) {
	  try {
	  this.forceCloseMsgDialog();
	  var positioner = document.createElement("div");
	  var dialog = document.createElement("div");
	  var dialogBody = document.createElement("div");
	  var messageForm = document.createElement("form");
	  var heading = document.createElement("div");
	  var content = document.createElement("div");
	  var buttonSet = document.createElement("div");
	  
	  positioner.className = this.dialog;
	  positioner.id = this.msgDialog;
	  dialog.className = "dialog";
	  dialog.style.top = ((this.getDocumentDimensions()[1] * 0.2) + this.getPageScrollOffsets()[1]) + "px";
	  dialogBody.className = "body";
	  messageForm.id = "message";
	  messageForm.className = "message";
	  messageForm.action = action;
	  messageForm.setAttribute("ajaxify", "1");
	  messageForm.setAttribute("callback", "api.messageSent");
	  messageForm.setAttribute("errorcallback", "api.messageError");
	  messageForm.setAttribute("onformsubmit", "api.sendMessage");
	  messageForm.setAttribute("spinner", "messageBody");
	  messageForm.setAttribute("suppress", "1");
	  heading.className = "heading";
	  heading.innerHTML = '<h3>'+title+'</h3>';
	  content.className = "content";
	  content.innerHTML = windowContent;
	  buttonSet.className = 'buttonSet';
	  buttonSet.innerHTML = '<label class="uiButton"><input type="button" id="cancelMsg" value="Cancel" onclick="api.closeMsgDialog();" /></label><label class="uiButton uiButtonConfirm"><input type="submit" id="sendMsg" value="Send" /></label>';
	  messageForm.appendChild(heading);
	  messageForm.appendChild(content);
	  messageForm.appendChild(buttonSet);
	  dialogBody.appendChild(messageForm);
	  dialog.appendChild(dialogBody);
	  positioner.appendChild(dialog);
	  document.body.appendChild(positioner);
	  this.bootstrap.loadjs(this.hostname+"/js/jquery.textarea-expander.js", function ()
	  {
	  	$('#messageBody').TextAreaExpander(100, 300);
	  });
	  }
	  catch(e){}
	  return false;
  };
  
  this.sendMessage = function() {
	  api.getElem('sendMsg').disabled = true;
	  api.getElem('messageBody').disabled = true;
	  $('#msgErrorNotification').fadeOut('normal').delay(300, function() { $('#'+api.msgDialog+' form > .content > .last').empty().remove(); $('#'+api.msgDialog+' form > .content > div:last').addClass('last'); });
  };
  
  this.messageSent = function() {
	  $('#'+this.msgDialog+' .content').children().empty().remove();
	  $('#'+this.msgDialog+' .buttonSet').empty().remove();
	  $('<div style="text-align: center; font-family: \'Lucida Sans Unicode\', \'Lucida Grande\', sans-serif; font-size: 18px; padding: 15px 0;">Message sent</div>').appendTo('#'+this.msgDialog+' form > .content');
	  setTimeout('api.closeMsgDialog();', 1500);
  };
  
  this.messageError = function() {
	  api.getElem('sendMsg').disabled = false;
	  api.getElem('messageBody').disabled = false;
	  $('#'+this.msgDialog+' form > .content .last').removeClass('last');
	  $('<div class="fieldSet last" style="padding-top: 0;"><div id="msgErrorNotification" style="margin: 0px 11px;" class="UIembeddedMsg">We were unable to send your message, please retry in a moment</div></div>').appendTo('#'+this.msgDialog+' form > .content');
	  $('#msgErrorNotification').fadeIn('normal');
  };
  
  this.existsMsgDialog = function() {
	return (api.getElem(this.msgDialog) != null);
  };
  
  this.closeMsgDialog = function() {
	  if (this.existsMsgDialog()) {
	    $('#'+this.msgDialog).fadeOut('normal');
        setTimeout("api.forceCloseMsgDialog()", 300);
        return false;
	  }
  };
  
  // should really only ever be called internally within the api
  this.forceCloseMsgDialog = function() {
	  if (this.existsMsgDialog()) {
	    document.body.removeChild(api.getElem(this.msgDialog));
	  }
  };
  
  // XML //
  
  this.getXmlNodeValue = function(xmlElement) {
	  return xmlElement.childNodes[0].nodeValue;
  };
  
  //prevent input from being styled by the user
  this.stripFormatting = function (content) {
	  content = content.replace("[u]", "");
	  content = content.replace("[/u]", "");
	  content = content.replace("[i]", "");
	  content = content.replace("[/i]", "");
	  content = content.replace("[b]", "");
	  content = content.replace("[/b]", "");
	  return content;
  };
  
  this.limitText = function (field, limit) {
    if (field.value.length > limit) {
      field.value = field.value.substring(0, limit);
    } 
  };
  
  this.dummySerialization = function (element) {
	  return element.value;
  };
  
  this.serializeStringFormatting = function (content) {
	  return this.internalSerializeString(content, true);
  };
  
  this.serializeString = function (content) {
	  return this.internalSerializeString(content, false);
  };
  
  // serializes string to be utf-8 compliant. Internal line breaks (\n character) converted into \ and n characters
  this.internalSerializeString = function (content, formatting) {
	  content = content.replace(/&/g, "&#38;"); // needs to be the first thing we do otherwise it will replace all & in entities
	  content = content.replace( /\u2018|\u2019|\u201A|\uFFFD/g, "&#39;" );
   	  content = content.replace( /\u201c|\u201d|\u201e/g, '&#34;' );
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
		var cleanedText = paragraphs[j].replace(pattern, " ");
		cleanedText = cleanedText.replace(pattern2, "");
		cleanedText = cleanedText.replace(pattern3, "");
		if (formatting == null || !formatting)
		  cleanedText = this.stripFormatting(cleanedText);
		if(cleanedText.length != 0) 
		{
		  newcontent.push(cleanedText);
		}
	  }
	  var serialized = "";
	  for (var j = 0; j < newcontent.length; j++)
	  {
	    if (j != newcontent.length - 1)
		{
		  //serialized += escape(newcontent[j])+"\\n\\n";
		  serialized += encodeURIComponent(newcontent[j])+"\\n\\n";
		}
		else
		{
		  //serialized += escape(newcontent[j]);
		  serialized += encodeURIComponent(newcontent[j]);
		}
	  }
	  return serialized;
  };
  
  this.deserializeString = function (content) {
	  var contentArray = content.split("\\n\\n");
	  var newContent = "";
	  for (var i = 0; i < contentArray.length; i++)
	  {
		if (i != contentArray.length - 1)
		{
          newContent += "<p>"+contentArray[i]+"</p>";
		}
		else
		{
		  newContent += "<p class=\"last-child\">"+contentArray[i]+"</p>";
		}
	  }
	  newContent = newContent.replace(/\\"/g, '"'); // json_encode escapes double quote
	  return newContent;
  };
  
  /* inform us of a persistant error */
  
  this.NotifyOfError = function()
  {
	var pattern = /\s+/g; // all white space characters (selecting consecutive as one) not stopping at the first (\n \t space etc...)
	var error = prompt("Please tell us a bit the error and the steps you took to make it occur.", "");
	if (error == null)
	  return false; // cancel was pressed which for some reason seems to throw return null or something... strange! So we better deal with it nicely!
	error = error.replace(pattern, " "); // replace all multiple white space chars with one space
	if (error.replace(pattern, "").length != 0) // remove all spaces and see if input box is empty
	{
	  api.sendSimpleRequest(this.hostname+'/backend/ajax.php?service=log&method=NotifyError&appId='+this.appId+'&error='+api.serializeString(error), null, null, true);
	  api.launchDialog("Thanks", "<p>We'll have one of our engineers look into this straight away.</p><p>We appreciate your help in making Project Nightlife a better experience.</p>");
	}
	return false;
  };
  
  /* ajax requests */
  
  this.sendError = function(type, details) {
	  var xmlHttp = this.getXmlHttpObject();
      if(xmlHttp == null)
        return false;
	  var address = this.hostname+"/backend/ajax.php?service=log&method=LogAppError&appId="+api.appId+"&type="+type+"&userAgent="+navigator.userAgent+"&details="+details;
      xmlHttp.open("GET", address, true);
      xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  xmlHttp.onreadystatechange = function() { };
      xmlHttp.send();
  };
  
  this.sendSimpleRequest = function(address, callback, spinner, suppress) {
	  this.insertSpinner(spinner);
	  var xmlHttp = this.getXmlHttpObject();
      if(xmlHttp == null)
      {
        this.launchDialog("Error", this.ajaxNotSupportedMsg);
        return false;
      }
      xmlHttp.open("GET", address, true);
      xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xmlHttp.onreadystatechange = function() {
	      if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			api.removeSpinner(spinner);
			try {
			  var response = api.buildResponse(xmlHttp.responseText);
			}
			catch (e) {
			  api.sendError(10, "Ajax request received unexpected result");
			  if (api.debug)
			    api.launchDialog("Error", "<p>"+e.message+"</p><p>Server responded with:</p><p>"+xmlHttp.responseText+"</p>");
			  else if (!suppress)
			    api.launchDialog(api.dialogErrorTitle, api.dialogErrorMessage);
			  return false;
			}
		    if (callback)
			  api.executeFunctionByName(callback, window, response);
	      } 
		  else if (xmlHttp.readyState == 4 && xmlHttp.status != 200) {
			api.sendError(9, "Ajax request unable to reach desired web service");
			api.removeSpinner(spinner);
			if (api.debug)
			  api.launchDialog("Error", "Ajax request failed, returned status of "+xmlHttp.status);
			else if (!suppress)
			  api.launchDialog(api.dialogErrorTitle, api.dialogErrorMessage);
			return false;
		  }
      };
      xmlHttp.send();
  };
  
  this.sendXmlRequest = function(address, xml, callback, errorCallback, spinner, suppress) {
	  this.insertSpinner(spinner);
	  var xmlHttp = this.getXmlHttpObject();
      if(xmlHttp == null)
      {
        this.launchDialog("Error", this.ajaxNotSupportedMsg);
        return false;
      }
      xmlHttp.open("POST", address, true);
      var params = "xmlData=" + xml;
      xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xmlHttp.onreadystatechange = function() {
	      if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			api.removeSpinner(spinner);
			try {
			  var response = api.buildResponse(xmlHttp.responseText);
			}
			catch (e) {
			  api.sendError(10, "Ajax request received unexpected result");
			  if (api.debug)
			    api.launchDialog("Error", "<p>"+e.message+"</p><p>Server responded with:</p><p>"+xmlHttp.responseText+"</p>");
			  else if (!suppress)
			    api.launchDialog(api.dialogErrorTitle, api.dialogErrorMessage);
			  if (errorCallback)
			    api.executeFunctionByName(errorCallback, window, null);
			  return false;
			}
		    if (callback)
			  api.executeFunctionByName(callback, window, response);
	      } 
		  else if (xmlHttp.readyState == 4 && xmlHttp.status != 200) {
			api.sendError(9, "Ajax request unable to reach desired web service");
			api.removeSpinner(spinner);
			if (api.debug)
			  api.launchDialog("Error", "Ajax request failed, returned status of "+xmlHttp.status);
			else if (!suppress)
			  api.launchDialog(api.dialogErrorTitle, api.dialogErrorMessage);
			if (errorCallback)
			    api.executeFunctionByName(errorCallback, window, null);
			return false;
		  }
      };
      xmlHttp.send(params);
  };
  
  this.sendForm = function(form) {
	  var xml = '<form xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
	  //try {
	  for (var i = 0; i < form.elements.length; i++)
	  {
		if (form.elements[i].type != 'submit' && form.elements[i].type != 'button' && form.elements[i].name != 'helper' && form.elements[i].name.substring(0, 5) != "radio" && form.elements[i].nodeName.toLowerCase() != 'embed') // ie7 inserts embed objects as form elements!
		{
		  var value = "";
		  if (form.elements[i].name == 'params')
		  {
			var params = JSON.parse(form.elements[i].value);
			for (var param in params)
			{
			  xml += "<"+param+"><![CDATA["+params[param]+"]]></"+param+">";
			}
		  }
		  else
		  {
			value = form.elements[i].value;
			var serializeRoutine;
		    if (form.elements[i].getAttribute('serializable'))
		    {
			  serializeRoutine = form.elements[i].getAttribute('serializable');
			}
			else // default serialization if none specified
			{
			  serializeRoutine = "api.dummySerialization:api.serializeString";
			}
		    // supports chaining of multiple serialization methods - 1st is given input element, subsequent are given chained value
			var serializors = serializeRoutine.split(":");
			value = this.executeFunctionByName(serializors[0], window, form.elements[i]);
			for (var serializor = 1; serializor < serializors.length; serializor++)
			  value = this.executeFunctionByName(serializors[serializor], window, value);
		    if (form.elements[i].getAttribute('validator'))
		    {
		      if (form.elements[i].type == "text" || form.elements[i].type == "password" || form.elements[i].type == "textarea")
			    var input = form.elements[i].value;
			  else
			    var input = form.elements[i];
			  var valid = this.executeFunctionByName(form.elements[i].getAttribute('validator'), window, input);
		      if (!valid)
			  { 
			    this.launchDialog("Notification", this.error, 475);
			    return false;
			  }
		    }
		    xml += "<"+form.elements[i].name+"><![CDATA["+value+"]]></"+form.elements[i].name+">";
		  } // else
		} // if (!submit)
	  } // for
	  xml += "</form>";
	  var callback = this.getCallback(form);
	  var errorCallback = this.getErrorCallback(form);
	  var spinner = this.getSpinner(form);
	  var suppress = this.getErrorSuppression(form);
	  if (form.getAttribute('onformsubmit'))
	    this.executeFunctionByName(form.getAttribute('onformsubmit'), window, null);
	  //alert(xml);
	  this.sendXmlRequest(form.action, xml, callback, errorCallback, spinner, suppress);
	  //}
	  //catch (e) { alert("send form error"); }
  };
  
  this.getXmlHttpObject = function() {
      var xmlHttp = null;
      try
      {
        // Firefox, Opera 8.0+, Safari, Chrome
        xmlHttp = new XMLHttpRequest();
      }
      catch(e)
      {
        // Internet Explorer
        try
        {
          xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch(e)
        {
          xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
      }
      return xmlHttp;
  };
  
  this.buildResponse = function(response) {
	  try {
	    var json = JSON.parse(response);
	  }
      catch (exception) {
		throw new Error("unable to parse json response");
	  }
	  try
	  {
	    if (json.data) {
		  api.data = json.data;
		  return json.data;
		}
		else {
		  throw new Error("Server returned expected result");
		}
	  }
	  catch (e)
	  {
	    // json.error was returned by the server
		throw e;
	  }
  };
  
  this.upgradeBrowser = function() {
	alert(this.upgradeBrowser); // use alert not launchDialog because the old browser may not be able to render a dialog
  };
  
}

var api = new API();

document.documentElement.onmousemove = function(event)
{
	event = event || window.event;
	if (event.pageX)
	{
	  api.mousePageCoords.x = event.pageX;
	  api.mousePageCoords.y = event.pageY;
	}
    else if (event.clientX)
	{
      api.mousePageCoords.x = event.clientX + (document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft);
	  api.mousePageCoords.y = event.clientY + (document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop);
	}
}

document.documentElement.onkeyup = function(event)
{
	event = event || window.event;
	if (event.keyCode)
	  api.keycode = event.keyCode;
	else if (event.which)
	  api.keycode = event.which;
	if (api.keycode == 27 && api.existsDialog())
	  api.closeDialog();
}

document.documentElement.onclick = function(event)
{
  event = event || window.event;
  var target = event.target || event.srcElement;
  if (target.href && target.getAttribute('ajaxify'))
  {
	if (target.id.substr(0, 2) == 'fb')
	  api.fbrequest(target.id);
	else if (target.id == "notifications")
	{
	  api.launchDialog("Notifications", api.notifications.get(), 350);
	  target.innerHTML = "Notifications";
	  api.sendSimpleRequest(this.hostname+'/backend/ajax.php?service=notification&method=ClearUserHasPending', null, null, true);
	}
	else
	{
	  var callback = api.getCallback(target);
	  var spinner = api.getSpinner(target);
      api.sendSimpleRequest(target.href, callback, spinner);
	}
	return false;
  }
  // use onclick and search for submit instead of onsubmit because IE doesn't fire document.documentElement.onsubmit!
  // submit button fired the event, not the form (because we're using onclick not onsubmit) - so get form object via target.parentNode
  else if (target.type == 'submit' && $(target).parents('form')[0].getAttribute('ajaxify'))
  {
	api.sendForm($('#'+target.id).parents('form')[0])//target.parentNode);
	return false;
  }
};

function transition()
  {
	  $('#posts').fadeOut("normal");
	  $('#posts').fadeIn("normal");
	  return false;
  }

$(document).ready(function()
{
  $('.profileButton').bind('mouseenter mouseleave', function() {
    $(this).toggleClass('hover');
  });
});