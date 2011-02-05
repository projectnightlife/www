<?php

class Debug extends Module
{
	
	const DEBUG = 0;
	const LOG = 1;
	const WARNING = 2;
	const ERROR = 3;
	const OFF = 4;

	private static $currentLevel;
	
	public static function Init()
	{
		//should be set externally (probably from db)
		self::$currentLevel = self::OFF;
		
		self::ExportFunction("writeLog", "log");
	}
	
	public static function Log($string)
	{
		self::writeDebug($string, self::LOG);	
	}
	
	private static function writeDebug($value, $level)
	{
		if($level >= self::$currentLevel)
		{
			print("<span style=\"color:red\">".$value."</span>");
		}
	}
}

?>

