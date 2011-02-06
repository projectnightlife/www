function API()
{
  this.dialogId = "dialogPositioner";
  this.ajaxNotSupportedMsg = "Your browser does not support AJAX, Please update to the latest version.";
  this.upgradeBrowser = "Your browser is too old to view this webpage, please upgrade to Internet Explorer 9";
  this.errString = "";
  this.ResponseCodes = new function() {
	  this.SUCCESS = 200;
  };
  
  this.fbconnect = function() {
	  FB.login(function(response) {
        if (response.session) { // ok, we've logged them in, now reload the current page
		  //this.launchDialog("logging user in");
          window.location.reload();
        }
	  });
  }
  
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
  
  // Dialogs //
  
  this.launchDialog = function(string) {
	  this.forceCloseDialog();
	  var positioner = document.createElement("div");
	  var dialog = document.createElement("div");
	  var content = document.createElement("div");
	  positioner.className = this.dialogId;
	  positioner.id = this.dialogId;
	  dialog.className = "dialog";
	  dialog.style.top = ((this.getDocumentDimensions()[1] * 0.2) + this.getPageScrollOffsets()[1]) + "px";
	  content.className = "content";
	  content.innerHTML = "<p style=\"margin-bottom: 3px;\">" + string + "</p><div style=\"float: right;\"><input type=\"button\" onclick=\"return api.closeDialog()\" style=\"width: 70px;\" value=\"Ok\" /></div>";
	  dialog.appendChild(content);
	  positioner.appendChild(dialog);
	  document.body.appendChild(positioner);
  };
  
  this.existsDialog = function() {
	return (document.getElementById(this.dialogId) != null);
  };
  
  this.closeDialog = function() {
	  if (this.existsDialog()) {
	    $('#'+this.dialogId).fadeOut('normal');
        setTimeout("api.forceCloseDialog()", 300);
        return false;
	  }
  };
  
  // should really only ever be called internally within the api
  this.forceCloseDialog = function() {
	  if (this.existsDialog()) {
	    document.body.removeChild(document.getElementById(this.dialogId));
	  }
  };
  
  // XML //
  
  this.getXmlNodeValue = function(xmlElement) {
	  return xmlElement.childNodes[0].nodeValue;
  };
  
  this.serializeString = function (content) {
	  var paragraphs = content.split("\n");
      var newcontent = [];
	  var pattern = /\s+/g; // all white space characters (selecting consecutive as one) not stopping at the first (\n \t space etc...)
	  var pattern2 = /^\s/; // leading white space
	  var pattern3 = /\s$/; // trailing white space
	  for (var j = 0; j < paragraphs.length; j++)
	  {
		var cleanedText = paragraphs[j].replace(pattern, " ");
		cleanedText = cleanedText.replace(pattern2, "");
		cleanedText = cleanedText.replace(pattern3, "");
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
		  serialized += escape(newcontent[j])+"\\n\\n";
		}
		else
		{
		  serialized += escape(newcontent[j]);
		}
	  }
	  return serialized;
  };
  
  this.deserializeString = function (content) {
	  var contentArray = content.split("\n\n");
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
	  return newContent;
  };
  
  // Ajax //
  
  this.insertSpinner = function(element) {
	  try {
	    if(element.elements['content']) {
	      element.elements['content'].disabled = true;
		  element.elements['content'].style.background = "url(http://"+window.location.hostname+"/images/core/icons/loading_030303.gif) no-repeat center";
	    }
	  }
	  catch(e) {
	    var spinner = document.createElement('img');
	    spinner.src = "http://"+window.location.hostname+"/images/core/icons/loading_111.gif";
	    spinner.className = "ajaxSpinner";
	    element.appendChild(spinner);
	  }
  }
  
  this.removeSpinner = function(element) {
	  try {
	    if(element.elements['content']) {
	      element.elements['content'].disabled = false;
		  element.elements['content'].style.background = "";
		}
	  }
	  catch(e) {}
  }
  
  this.sendSimpleRequest = function(address, ajaxElement) {
	  this.insertSpinner(ajaxElement);
	  var xmlHttp = this.getXmlHttpObject();
      if(xmlHttp == null)
      {
        this.launchDialog(this.ajaxNotSupportedMsg);
        return false;
      }
      xmlHttp.open("GET", address, true);
      xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xmlHttp.onreadystatechange = function() {
	      if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			//alert(xmlHttp.responseText);
			try {
			  var response = api.buildResponse(xmlHttp.responseText);
			}
			catch (e) {
			  api.launchDialog("Oops, something went wrong");
			  return false;
			}
			api.removeSpinner(ajaxElement);
			if (response.statusCode == api.ResponseCodes.SUCCESS) {
		      api.closeDialog();
              eval(api.getXmlNodeValue(response.result));
			}
			else 
			{
			  api.launchDialog(response.error);
			  return false;
			}
	      } 
		  else if (xmlHttp.readyState == 4 && xmlHttp.status != 200) {
			api.launchDialog("Oops, something went wrong");
			return false;
		  }
      };
      xmlHttp.send();
  };
  
  this.sendSimpleCallbackRequest = function(address, ajaxElement, callback) {
	  this.insertSpinner(ajaxElement);
	  var xmlHttp = this.getXmlHttpObject();
      if(xmlHttp == null)
      {
        this.launchDialog(this.ajaxNotSupportedMsg);
        return false;
      }
	  address += "&nojs=1";
      xmlHttp.open("GET", address, true);
      xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xmlHttp.onreadystatechange = function() {
	      if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			//alert(xmlHttp.responseText);
			try {
			  var response = api.buildResponse(xmlHttp.responseText);
			}
			catch (e) {
			  api.launchDialog("Oops, something went wrong");
			  return false;
			}
			api.removeSpinner(ajaxElement);
			if (response.statusCode == api.ResponseCodes.SUCCESS) {
		      api.closeDialog();
              callback(response.result);
			}
			else 
			{
			  api.launchDialog(response.error);
			  return false;
			}
	      } 
		  else if (xmlHttp.readyState == 4 && xmlHttp.status != 200) {
			api.launchDialog("Oops, something went wrong");
			return false;
		  }
      };
      xmlHttp.send();
  };
  
  this.sendXmlRequest = function(address, xml, ajaxElement) {
	  this.insertSpinner(ajaxElement);
	  var xmlHttp = this.getXmlHttpObject();
      if(xmlHttp == null)
      {
        this.launchDialog(this.ajaxNotSupportedMsg);
        return false;
      }
      xmlHttp.open("POST", address, true);
      var params = "xmlData=" + xml;
      xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

      xmlHttp.onreadystatechange = function() {
	      if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			//alert(xmlHttp.responseText);
			try {
			  var response = api.buildResponse(xmlHttp.responseText);
			}
			catch (e) {
			  api.launchDialog(xmlHttp.responseText);
			  return false;
			}
			api.removeSpinner(ajaxElement);
			if (response.statusCode == api.ResponseCodes.SUCCESS) {
		      api.closeDialog();
              eval(api.getXmlNodeValue(response.result));
			}
			else 
			{
			  api.launchDialog(response.error);
			  return false;
			}
	      }
		  else if (xmlHttp.readyState == 4 && xmlHttp.status != 200) {
			api.launchDialog("Oops, something went wrong!");
			return false;
		  }
      };
      xmlHttp.send(params);
  };
  
  this.sendXmlCallbackRequest = function(address, xml, ajaxElement, callback) {
	  this.insertSpinner(ajaxElement);
	  var xmlHttp = this.getXmlHttpObject();
      if(xmlHttp == null)
      {
        this.launchDialog(this.ajaxNotSupportedMsg);
        return false;
      }
      xmlHttp.open("POST", address, true);
      var params = "xmlData=" + xml + "&nojs=1";
      xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

      xmlHttp.onreadystatechange = function() {
	      if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
			//alert(xmlHttp.responseText);
			try {
			  var response = api.buildResponse(xmlHttp.responseText);
			}
			catch (e) {
			  api.launchDialog("Oops, something went wrong");
			  return false;
			}
			api.removeSpinner(ajaxElement);
			if (response.statusCode == api.ResponseCodes.SUCCESS) {
		      api.closeDialog();
		      callback(response.result);
			}
			else 
			{
			  api.launchDialog(response.error);
			  return false;
			}
	      }
		  else if (xmlHttp.readyState == 4 && xmlHttp.status != 200) {
			api.launchDialog("Oops, something went wrong!");
			return false;
		  }
      };
      xmlHttp.send(params);
  };
  
  this.sendForm = function(form) {
	  var xml = '<form xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
	  for (var i = 0; i < form.elements.length; i++)
	  {
		if (form.elements[i].type != 'submit')
		{
		  var value = "";
		  if (form.elements[i].getAttribute('serializable'))
		  {
			value = this.serializeString(form.elements[i].value);
		  }
		  else
		  {
			value = form.elements[i].value;
		  }
		  if (form.elements[i].getAttribute('validator'))
		  {
		    var valid = eval(form.elements[i].getAttribute('validator')+"('"+value+"')");
		    if (!valid)
			{ 
			  this.launchDialog(this.errString);
			  return false;
			}
		  }
		  xml += "<"+form.elements[i].name+"><![CDATA["+value+"]]></"+form.elements[i].name+">";
		}
	  }
	  xml += "</form>";
	  this.sendXmlRequest(form.action, xml, form);
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
  
  this.buildResponse = function(xml) {
	  if (window.DOMParser)
      {
        parser = new DOMParser();
        XmlDoc = parser.parseFromString(xml,"text/xml");
      }
      else // Internet Explorer
      {
        XmlDoc = new ActiveXObject("Microsoft.XMLDOM");
        XmlDoc.async = "false";
        XmlDoc.loadXML(xml);
      }
	  try {
	    var statusCode = parseInt(XmlDoc.getElementsByTagName("code")[0].childNodes[0].nodeValue, 10);
	    var statusMessage = XmlDoc.getElementsByTagName("message")[0].childNodes[0].nodeValue;
	    var error = "";
	    var result = "";
	    try { // will throw an exception if was no error message set
		  error = XmlDoc.getElementsByTagName("error")[0].childNodes[0].nodeValue;
	    }
	    catch (e) {
		  // read result xml as no error message was set so 
		  try {
		    result = XmlDoc.getElementsByTagName("result")[0];
		  }
		  catch (e) { 
		    throw new exception;
		  }
		}
	    return new function() {
		  this.statusCode = statusCode;
		  this.statusMessage = statusMessage;
		  this.error = error;
		  this.result = result;
	    };
	  }
      catch (e) {
		throw new exception;
	  }
  };
  
  this.upgradeBrowser = function() {
	alert(this.upgradeBrowser); // use alert not launchDialog because the old browser may not be able to render a dialog
  };
  
  // validation
  
  this.validateComment = function(text)
  {
	var valid = true;
	if (text.length < 10) {
	  this.errString = "Your comment is too short, only post comments that other users will want to read!";
	  valid = false;
	}
	return valid;
  }	;
  
}

var api = new API();

document.documentElement.onclick = function(event)
{
  event = event || window.event;
  var target = event.target || event.srcElement;
  if (target.tagName.toLowerCase() == "a" || target.tagName.toLowerCase() == "img")
  {
	  if (FB.getSession() == null)
	  {
	  FB.login(function(response) {
        if (response.session) { // ok, we've logged them in, now reload the current page
          window.location.reload();
        }
	  });
	  return false;
	  }
  }
  if (target.getAttribute('ajaxify'))
    return false;
  // use onclick and search for submit instead of onsubmit because IE doesn't fire document.documentElement.onsubmit!
  // submit button fired the event, not the form (because we're using onclick not onsubmit) - so get form object via target.parentNode
};

$(document).ready(function(){
		
  $('.rnd10px').corner("10px");
  $('.rnd8px').corner("8px");
  $('.rnd6px').corner("6px");
  $('.rndbtm6px').corner("6px bottom");
  $('.rndtop6px').corner("6px top");
  $('.rndbtmlft6px').corner("6px bl");	
  $('.rndrgt8px').corner("8px tr br");
  
  FB.init({appId: '131359770249054', status: true, cookie: true, xfbml: true});

});