<?php
class notification
{
	public $thumbnail;
	public $title;
	public $url;
	public $excerpt;
	public $time;
	
	public function __construct($thumbnail, $title, $url, $excerpt, $time)
	{
		$this->thumbnail = $thumbnail;
		$this->title = $title;
		$this->url = $url;
		$this->excerpt = $excerpt;
		$this->time = $time;
	}
}
?>