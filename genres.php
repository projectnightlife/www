<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Project Nightlife | Genre Hierarchy</title>
</head>

<body>
<?php
$global = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";

require($global.'backend\\global_include.php');

class node
{
	private $id;
	private $name;
	private $parent;
    private $isParent;	

	public function __construct($id, $name, $parent, $isParent)
	{
		$this->id = $id;
		$this->name = $name;
		$this->parent = $parent;
		$this->isParent = $isParent;
	}
	
	public function getId()
	{
		return $this->id;
	}
	
	public function getName()
	{
		return $this->name;
	}
	
	public function getParent()
	{
		return $this->parent;
	}
	
	public function getParentStatus()
	{
		return $this->isParent;
	}
	
	public function setParentStatus($status)
	{
	  $this->isParent = $status;
	}
}

// Authenticate with the Project Nightlife api
API::Authenticate();

$genreService = API::GetService("genre");
$topLevelGenres = $genreService->GetTopLevelGenres();

print '<h3>This shows the relationships between styles in our database.</h3><h3>It isn\'t meant to be technically correct. Instead it\'s as near, whilst being familiar for users to browse styles in popular categories.</h3><h4>A lot of genres still need sub genres. If you have genres for us to add, please let us know!</h4>';

foreach($topLevelGenres as $genre)
{
	print '<div style="display: inline-block; margin: 15px; vertical-align: top;">';
	$genres = $genreService->GetGenreHierarchy($genre->name);

	$tree = array();
	$stack = array();

	foreach ($genres as $genre)
	{
		$tree[] = new node((string)$genre->id, (string)$genre->name, (string)$genre->parentGenre, false);
	}

	foreach ($genres as $genre)
	{
		foreach ($tree as $node)
		{
			if (strcmp($node->getName(), $genre->parentGenre) == 0)
			{
				$node->setParentStatus(true);
				break;
			}
		}
	}

	foreach ($tree as $node)
	{
		if (count($stack) == 0 || $node->getParentStatus() && strcmp($node->getParent(), $stack[count($stack) - 1]) == 0)
		{
			foreach ($stack as $index => $object)
			{
				if ($index < count($stack) - 1)
					print '|&nbsp;&nbsp;&nbsp;';
				else
		   			print '| ';
			}
			if (count($stack) != 0)
		   		print '- ';
			print '<b>'.$node->getName().' <img style="margin-bottom: -3px;" src="images/genres/'.$node->getId().'.png" /></b><br />';
			$stack[] = $node->getName();
		}
		else if ($node->getParentStatus() || !strcmp($node->getParent(), $stack[count($stack) - 1]) == 0)
		{
			do
			{
				array_pop($stack);
			}
			while (count($stack) > 0 && !strcmp($node->getParent(), $stack[count($stack) - 1]) == 0); // backup to find common ancestor
			foreach ($stack as $index => $object)
			{
				if ($index < count($stack) - 1)
					print '|&nbsp;&nbsp;&nbsp;';
				else
		   			print '| ';
			}
			if ($node->getParentStatus())
			{
				print '- <b>'.$node->getName().' <img style="margin-bottom: -3px;" src="images/genres/'.$node->getId().'.png" /></b><br />';
				$stack[] = $node->getName();
			}
			else
				print '- '.$node->getName().' <img style="margin-bottom: -3px;" src="images/genres/'.$node->getId().'.png" /><br />';
		}
		else
		{
			foreach ($stack as $index => $object)
			{
				if ($index < count($stack) - 1)
					print '|&nbsp;&nbsp;&nbsp;';
				else
		   			print '| ';
			}
			print '- '.$node->getName().' <img style="margin-bottom: -3px;" src="images/genres/'.$node->getId().'.png" /><br />';
		}
	}
	print '</div>';
}//foreach

?>
</body>
</html>