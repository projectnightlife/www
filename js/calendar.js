function dateChange(dayElementName, monthElementName, yearElementName)
{
  var dayElement = document.getElementById(dayElementName);
  var monthElement = document.getElementById(monthElementName);
  var yearElement = document.getElementById(yearElementName);
  switch (parseInt(monthElement.value, 10))
  {
    case 1: setDays(dayElement, 31);
	        break;
	case 2: var year = parseInt(yearElement.value, 10);
	        if (isLeapYear(year) || year == -1) {
	          setDays(dayElement, 29);
	        } else {
			  setDays(dayElement, 28);
			}
	        break;
	case 3: setDays(dayElement, 31);
	        break;
	case 4: setDays(dayElement, 30);
	        break;
	case 5: setDays(dayElement, 31);
	        break;
	case 6: setDays(dayElement, 30); 
	        break;
	case 7: setDays(dayElement, 31);
	        break;
	case 8: setDays(dayElement, 31);
	        break;
	case 9: setDays(dayElement, 30);
	        break;
	case 10: setDays(dayElement, 31);
	         break;
	case 11: setDays(dayElement, 30);
	         break;
	case 12: setDays(dayElement, 31);
	         break;
	default: setDays(dayElement, 31);
	         break;
  }
}

function setDays(dayElement, numDays)
{
  var day = dayElement.selectedIndex;
  var length = dayElement.length;
  for (var i = length; i > 0; i--) {
	dayElement.remove(i);
  }
  for (var i = 1; i <= numDays; i++)
  {
	var option = document.createElement('option');
	option.value = i;
	option.text = i;
	try {
      dayElement.add(option, null); // standards compliant
    }
    catch(ex) {
      dayElement.add(option); // IE only
    }
  }
  if (day <= numDays) {
    dayElement.selectedIndex = day;
  }
  else {
    dayElement.selectedIndex = 0;
  }
}

function isLeapYear(year)
{
	return year % 400 == 0 || year % 100 != 0 && year % 4 == 0;
}

function validateDate(day, month, year)
{
  var valid = true;
  if (year < 1900) {
	valid = false;
  }
  else {
    switch (month)
    {
      case 1: if (day < 1 || day > 31) {
		        valid = false;
	          }
	          break;
	  case 2: if (isLeapYear(year)) {
	            if (day < 1 || day > 29) {
		          valid = false;
	            }
	          } else {
			    if (day < 1 || day > 28) {
		          valid = false;
	            }
			  }
	          break;
      case 3: if (day < 1 || day > 31) {
		        valid = false;
	          }
	          break;
	  case 4: if (day < 1 || day > 30) {
		        valid = false;
	          }
	          break;
	  case 5: if (day < 1 || day > 31) {
		        valid = false;
	          }
	          break;
	  case 6: if (day < 1 || day > 30) {
		        valid = false;
	          }
	          break;
	  case 7: if (day < 1 || day > 31) {
		        valid = false;
	          }
	          break;
	  case 8: if (day < 1 || day > 31) {
		        valid = false;
	          }
	          break;
	  case 9: if (day < 1 || day > 30) {
		        valid = false;
	          }
	          break;
	  case 10: if (day < 1 || day > 31) {
		         valid = false;
	           }
	           break;
	  case 11: if (day < 1 || day > 30) {
		         valid = false;
	           }
	           break;
	  case 12: if (day < 1 || day > 31) {
		         valid = false;
	           }
	           break;
	  default: valid = false;
	           break;
    }
  }
  return valid;
}