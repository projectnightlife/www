<?php

abstract class Module
{

	//API registration plumbing
	public static function Init(){	}	
	
	protected static function ExportFunction($name, $function)
	{
		$classname = get_called_class();
		API::ExportFunction($name, $classname .  "::" . $function);
	}
	

	//allow the sub class to store data
	protected $data = array();
	
	protected $webService;
	
	//intercept the getXX methods which aren't implemented
	public function __call($name, $args)
	{
		if(substr($name, 0, 3) == "get")
		{
			$variableName = strtolower(substr($name, 3));
			if(array_key_exists($variableName, $this->data))
			{
				API::writeLog($name." called on superclass<br/>");
				return $this->data[$variableName];
			}
			else
			{
				//we dont know about this variable
				API::writeLog("Unknown variable '".$variableName."'");
			}
		}
		
		//should we have a 'set' here?
		//probably not, why would we want to change instance data?
		//
		//unless... we provide a serialise style teardown method which tells
		//the class to write back its instance data on destruct??
	
	}
}

?>