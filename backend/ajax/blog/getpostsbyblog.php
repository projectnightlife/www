<?php

function DataProcessor($xml)
{
  $local = array();
  foreach($xml->children() as $result)
  {
	  $local[] = array("id" => (string)$result->id, "title" => (string)$result->title, "created" => API::GetDateString((int)$result->created), "modified" => API::GetDateString((int)$result->modified), "tags" => (string)$result->tags, "excerpt" => (string)$result->excerpt, "thumbnail" => (string)$result->thumbnail, "numComments" => (string)$result->numComments, "blogId" => (string)$result->blogId);
  }
  
  return array("data" => array("local" => $local));
}
?>