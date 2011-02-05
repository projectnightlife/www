<?php


/* This is the default API which should be included in each page yadda, yadda yadaa */

class API
{
	public static $exportedFunctions = array();
	
	public static $SUCCESS = 200;
	
	//function call to intercept unknown (read: dynamically added) methods
	public static function __callStatic($name, $arguments) 
	{
		if(array_key_exists($name, self::$exportedFunctions))
		{
			return call_user_func_array(
				self::$exportedFunctions[$name],
				$arguments);
		}
		else
		{
			//We dont know about this function
			print("Error: un-registered function '".$name."'");
		}
	}
	
	//allow a module to export a method and make it visible in the API
	public static function ExportFunction($name, $method)
	{
		self::$exportedFunctions[$name] = $method;
	}
	
	public static function GetDateString($timestamp)
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
}


?>