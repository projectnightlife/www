<?php

class Venue extends Module
{
		
	//static stuff
	public static function Init()
	{
		//yadda
		self::ExportFunction("getVenue", "Create");
	}
	
	public static function Create($id)
	{
		API::writeLog("Created venue ".$id."</br>");
		$venue = new Venue($id);
		return $venue;
	}

	//not sure I like this, having the module 'plumbing' and the object in the same class
	//but its the only way I can think to be able to use private constructors...

	
	private $id;
	
	protected function __construct($venueid)
	{
		//store the id
		$this->id = $venueid;
		
		API::writeLog("Getting name from Web Service<br/>");
		$venueService = API::CreateWS("http://projectnightlife.co.uk/api/VenueService.asmx?WSDL");
		
		$xml = $venueService->GetInfo(1);
		
		$this->data["name"] = $xml->name;
		$this->data["location"] = $xml->location;
	}
	
	
	public function getID()
	{
		API::writeLog("getID called on sub class<br/>");
		return $this->id;	
	}
}

?>