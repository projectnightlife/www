<?php


/* This is the default API which should be included in each page yadda, yadda yadaa */

class API
{

	public static $SUCCESS = 200;
	public static $SplitOn = '\n\n';
	
	private static $credentials;

	public static function Authenticate()
	{
		self::$credentials = FacebookAuth::Authenticate();
	}
	
	public static function GetUserCredentials()
	{
		return self::$credentials;
	}
	
	public static function ClearCredentials()
	{
		self::$credentials = Credentials::$GuestUser;
		
		//TODO: This should probably call the appropriate FB logout stuff
	}
	
	public static function IsUserLoggedIn()
	{
		return !(self::$credentials == Credentials::$GuestUser);
	}
	
	public static function Fail($vardump, $message, $file, $line)
	{
		print("<h3>Fail!: ".$message."</h3><h4>Line ".$line." of  '".$file."'</h4>");
		var_dump($vardump);
		die();
	}
	
	public static function Error($vardump, $message, $file, $line)
	{
		print("<h3>Error!: ".$message."</h3><h4>Line ".$line." of  '".$file."'</h4>");
	}
	
	public static function CreateWS($url)
	{
		return new WebService($url);
	}
	
	public static function GetService($serviceName)
	{
		//should use a lookup array (faster, easier to maintain)
		if ($serviceName == "log")
		{
			return self::CreateWS("http://www.projectnightlife.co.uk/api/LogService.asmx?WSDL");
		}
		else if ($serviceName == "notification")
		{
			return self::CreateWS("http://www.projectnightlife.co.uk/api/NotificationService.asmx?WSDL");
		}
		else if ($serviceName == "blog")
		{
			return self::CreateWS("http://www.projectnightlife.co.uk/api/BlogService.asmx?WSDL");
		}
		else if ($serviceName == "image")
		{
			return self::CreateWS("http://www.projectnightlife.co.uk/api/ImageService.asmx?WSDL");
		}
		else if ($serviceName == "genre")
		{
			return self::CreateWS("http://www.projectnightlife.co.uk/api/GenreService.asmx?WSDL");
		}
		else if ($serviceName == "insight")
		{
			return self::CreateWS("http://www.projectnightlife.co.uk/api/InsightService.asmx?WSDL");
		}
		else if ($serviceName == "authentication")
		{
			return self::CreateWS("http://www.projectnightlife.co.uk/api/AuthenticationService.asmx?WSDL");
		}
	}
	
	public static function GetDateString($timestamp)
	{
		return gmdate("j M \a\\t H:i", $timestamp);
	}
		
	
	public static function GetDynamicDateString($timestamp)
	{
		$dateString;
		$now = new DateTime();
		// convert timestamp to GMT
		$GMTStamp = mktime(gmdate("G", $timestamp), gmdate("i", $timestamp), gmdate("s", $timestamp), gmdate("n", $timestamp), gmdate("j", $timestamp), gmdate("Y", $timestamp));
		$date = new DateTime();
		$date->setTimestamp($GMTStamp);
		$interval = $now->diff($date);
		if ($interval->format("%y") < 1) // less than a year ago
		{
		  if (($interval->format("%m") == 0) && ($interval->format("%d") == 0)) // less than a month ago and less than a day ago
		  {
			if ($interval->format("%h") == 0) // less than an hour ago
			{
			  if ($interval->format("%i") == 0) // less than a minute ago
			  {
				$dateString = "a few seconds ago";
			  }
			  else // less than 60 mins ago
			  {
			    $minutes = $interval->format("%i");
			    $dateString = "about ".($minutes == 1 ? "a minute" : $minutes." minutes")." ago";
			  }
			}
			else // less than 24 hours ago
			{
			  $hours = $interval->format("%h");
			  $dateString = "about ".($hours == 1 ? "an hour" : $hours." hours")." ago";
			}
		  }
		  else if (($interval->format("%m") == 0) && ($interval->format("%d") < 4)) // less than a month and less than 4 days ago
		  {
			$dateString = gmdate("\o\\n l \a\\t H:i", $timestamp);
		  }
		  else if ($interval->format("%a") <= date("z", $now->getTimestamp())) // less than a year ago but within this calendar year
		  {
		    $dateString = gmdate("\o\\n jS F \a\\t H:i", $timestamp);
		  }
		  else // less than a year ago but last calendar year
		  {
		    $dateString = gmdate("\o\\n jS F, Y \a\\t H:i", $timestamp);
		  }
		}
		else // any time greater than a year ago
		{
		  $dateString = gmdate("\o\\n jS F, Y \a\\t H:i", $timestamp);
		}
		return $dateString;
	}
	
	function time_since($older_date, $newer_date = false) 
	{
	
    $chunks = array(
                  array(60 * 60 * 24 * 365 , 'year'),
                  array(60 * 60 * 24 * 30 , 'month'),
                  array(60 * 60 * 24 * 7, 'week'),
                  array(60 * 60 * 24 , 'day'),
                  array(60 * 60 , 'hour'),
                  array(60 , 'minute'),
              );

    $newer_date = ($newer_date == false) ? (time()) : $newer_date;

    // difference in seconds
    $since = $newer_date - $older_date;

    // we only want to output two chunks of time here, eg:
    // x years, xx months
    // x days, xx hours
    // so there are only two bits of calculation below:

    // step one: the first chunk
    for ($i = 0, $j = count($chunks); $i < $j; $i++) {
        $seconds = $chunks[$i][0];
        $name = $chunks[$i][1];

        // finding the biggest chunk (if the chunk fits, break)
        if (($count = floor($since / $seconds)) != 0) {
            break;
        }
    }

    $output = ($count == 1) ? '1 '.$name : "$count {$name}s";

    // step two: the second chunk
    if ($i + 1 < $j) {
        $seconds2 = $chunks[$i + 1][0];
        $name2 = $chunks[$i + 1][1];

        if (($count2 = floor(($since - ($seconds * $count)) / $seconds2)) != 0) {
            // add to output var
            $output .= ($count2 == 1) ? ', 1 '.$name2 : ", $count2 {$name2}s";
        }
    }

    return $output;
    }
	
	public static function ToHTMLParagraph($arrayLength, $Index, $result, $paragraph)
	{
		if ($Index == 0)
	    {
	      $result = '<p>'.$paragraph.'</p>';
	    }
	    else
	    {
	      $result = $result.'<p>'.$paragraph.'</p>';
	    }
		return $result;
	}
}

?>