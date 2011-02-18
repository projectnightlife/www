<?php

/*	Resource Dependancy Manager automatically manages resources required by a webpage.
	Simply initialise with the page in question and the resource type and then add 
	each resource the page is dependant upon.
	
	The module will then collate each resource, minimise and optimise, them and add them 
	into a single file.
	
	If a previous copy of the managed file exists and is still valid, that will simply
	be returned instead of building a new copy.
	
	For optimal delivery efficiency, the webserver should be gzipping any responses.
	
	Resources must be added in order of their natural dependencies - add resources 
	required by others first.
	
	Resources contain the build metadata as a comment in their opening line in the form:
	expiration timestamp, build timestamp 
	
	Author: Marcus Williams
	Created: 12 Feb 2011
	Last revision: 18 Feb 2011 @ 20:20 GMT
	
*/

class ResourceDependancyManager
{
	private $URI;
	private $resourceType;
	private $resources = array();
	
	private static $cacheTime = 1; // num seconds to cache built resource

	private static $jsPath = 'c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\js\\';
	private static $jsBuildPath = 'c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\js\\build\\';
	private static $cssPath = 'c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\css\\';
	private static $cssBuildPath = 'c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\css\\build\\';
	
	public function __construct($URI, $resourceType)
	{
		// Adjust for developer host
		self::$jsPath = ($_SERVER['HTTP_HOST'] == 'developer.projectnightlife.co.uk') ? str_replace('www.projectnightlife.co.uk', 'developer.projectnightlife.co.uk', self::$jsPath) : self::$jsPath;
		self::$jsBuildPath = ($_SERVER['HTTP_HOST'] == 'developer.projectnightlife.co.uk') ? str_replace('www.projectnightlife.co.uk', 'developer.projectnightlife.co.uk', self::$jsBuildPath) : self::$jsBuildPath;
		self::$cssPath = ($_SERVER['HTTP_HOST'] == 'developer.projectnightlife.co.uk') ? str_replace('www.projectnightlife.co.uk', 'developer.projectnightlife.co.uk', self::$cssPath) : self::$cssPath;
		self::$cssBuildPath = ($_SERVER['HTTP_HOST'] == 'developer.projectnightlife.co.uk') ? str_replace('www.projectnightlife.co.uk', 'developer.projectnightlife.co.uk', self::$cssBuildPath) : self::$cssBuildPath;
		
		self::$cacheTime = ($_SERVER['HTTP_HOST'] == 'developer.projectnightlife.co.uk') ? 1 : 604800;
		
		$this->URI = strtolower($URI);
		$this->resourceType = strtolower($resourceType);
	}
	
	public function addResource($resourceName)
	{
		$this->resources[] = $resourceName;
	}
	
	public function build()
	{
		global $ismobile; 
		
		$mobilesfx	= ($ismobile == true) ? "-mobile" : ""; 
		$buildPath	= strcmp($this->resourceType, 'js') == 0 ? self::$jsBuildPath : self::$cssBuildPath;
		$sourcePath	= strcmp($this->resourceType, 'js') == 0 ? self::$jsPath : self::$cssPath;
		$filename	= md5($this->URI).$mobilesfx.'.'.$this->resourceType;
		
		if ($this->resourceExpired($buildPath, $filename))
		{
			try {
				// incase compilation fails we can revert to the original
				$originalContents = file_get_contents($buildPath.$filename);
		   		$fh = fopen($buildPath.$filename, 'w');
				
				// add each resource
				foreach($this->resources as $resourceName)
				{
					fwrite($fh, file_get_contents($sourcePath.$resourceName));
				}
				
				fclose($fh);
				
				// compress (removes standard comments so need to add meta comments after compression)
				exec('java -jar "c:\\Program Files (x86)\\Yui\\compressor\\yuicompressor-2.4.2.jar" "'.$buildPath.$filename.'" -o "'.$buildPath.$filename.'" --charset utf-8');
				
				// need to add meta data comment to first line of file
				$optimisedResource = file_get_contents($buildPath.$filename);
				$fh = fopen($buildPath.$filename, 'w');
				
				// add expiration and build time data {timestamp, timestamp} as comment in resource
				$metaHeader= '/* '.(time() + self::$cacheTime).','.time().' */'.PHP_EOL;
				fwrite($fh, $metaHeader.$optimisedResource);
				
				fclose($fh);
			}
			catch (Exception $e)
			{
				// File is prob locked due to another read, we'll try and build it next time
				// In the meantime, we'll try and restore the previous copy. 
				// Previous to this addition, the incomplete css file was being sent back to the browser!
				try {
					fclose($fh); // previous handle is still open due to exception being thrown.
					$fh = fopen($buildPath.$filename, 'w');
					fwrite($fh, $originalContents);
					fclose($fh);
				}
				catch (Exception $e) {}
			}
		}
		
		// return build file's web url (Not system path)
		return $this->resourceType.'/build/'.$filename;
	}
	
	// determine if previous build does not exist or has expired
	private function resourceExpired($buildPath, $filename)
	{
		$expired = false;
		
		if (file_exists($buildPath.$filename))
		{
			$fh = fopen($buildPath.$filename, 'r');
			$firstline = fgets($fh); // more efficient than loading the entire file in via get_file_contents
			fclose($fh);
			$meta = explode(",", preg_replace("/\/\* | \*\//", "", $firstline)); // strip comment markup from meta data and split each piece of data
			if(time() > (int)$meta[0]) // build expired
			    $expired = true;
		}
		else
		{
			$expired = true; // technically doesn't exist but expired just flags that a new build is required
		}
		
		return $expired;
	}
}

?>