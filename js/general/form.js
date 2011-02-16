function validateName(name)
{
	var valid = true;
	var expr = new RegExp("^[A-Za-z -]*[a-z]$", "g"); //crude, needs work ; new RegExp("^([A-Z][a-z]+)([ -](?=[A-Z][a-z]+))*$", "g");
	if (!expr.test(name.value)) {
	  api.error = "Please provide your full name";
	  valid = false;
	}
	return valid;
}
function validateEmail(email)
{
	var valid = true;
	var expr = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
	if (!expr.test(email.value)) {
	  api.error = "Please provide a valid email address";
	  return false;
	}
	return valid;
}
function validateText(text)
{
	var valid = true;
	var pattern = /\s+/g; // all white space characters (selecting consecutive as one) not stopping at the first (\n \t space etc...)
	
	if (text.value.replace(pattern, "").length == 0)
	{
		api.error = "Please ensure you've completed all the required fields";
		valid = false;
	}
	return valid;
}
function submitRequest()
  {
	document.getElementById('sendRequest').disabled = true;
	document.getElementById('requestNotification').style.display = 'block';
  }
  
  function requestError()
  {
	document.getElementById('sendRequest').disabled = false;
	document.getElementById('requestNotification').style.display = 'none';
  }
  
  function requestSent(response)
  {
	  document.getElementById('requestNotification').style.display = 'none';
	  api.launchDialog("Thanks for your enquiry", "We'll be in touch within the next few hours");
	  setTimeout("api.closeDialog();window.location = '/';", 4000);
  }
  $(document).ready(function()
  {
	initForms();
  });