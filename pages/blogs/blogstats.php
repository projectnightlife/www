<?php

date_default_timezone_set('Europe/London');
$lastMonday = strtotime("last monday");
$oneWeek =  604800; // seconds
$month = array();
$month[] = $blogService->GetBlogInsights($blog->id, 0, $lastMonday);
$month[] = $blogService->GetBlogInsights($blog->id, $lastMonday - 1, $lastMonday - $oneWeek);
$month[] = $blogService->GetBlogInsights($blog->id, $lastMonday - $oneWeek - 1, $lastMonday - $oneWeek * 2);
$month[] = $blogService->GetBlogInsights($blog->id, $lastMonday - $oneWeek * 2 - 1, $lastMonday - $oneWeek * 3);
                        
$xmlPostsServed = <<<XML
<?xml version='1.0' standalone='yes'?>
	<chart>
	<chart_type>line</chart_type>
    <chart_rect x='113' y='60' width='564' height='196' positive_color='0a0a0a' />
    <chart_grid_h color='5a5a5a' />
    <chart_border color='666666' /> 
	<axis_category font='Tahoma' bold='false' size='11' color='aaaaaa' />
	<series_color>
		<color>3399ff</color>
	</series_color>
	<legend layout='vertical' fill_color='0a0a0a' color='aaaaaa' size='12' bold='false' font='Tahoma' />
	<axis_value size='11' color='aaaaaa' />
	<tooltip color='FFFFFF' alpha='75' size='11' background_color_1='282828' background_alpha='85' shadow='low' />
</chart>
XML;

$xmlComments = <<<XML
<?xml version='1.0' standalone='yes'?>
	<chart>
	<chart_type>line</chart_type>
    <chart_rect x='113' y='60' width='564' height='196' positive_color='0a0a0a' />
    <chart_grid_h color='5a5a5a' />
    <chart_border color='666666' /> 
	<axis_category font='Tahoma' bold='false' size='11' color='aaaaaa' />
	<series_color>
		<color>97e35f</color>
	</series_color>
	<legend layout='vertical' fill_color='0a0a0a' color='aaaaaa' size='12' bold='false' font='Tahoma' />
	<axis_value size='11' color='aaaaaa' />
	<tooltip color='FFFFFF' alpha='75' size='11' background_color_1='282828' background_alpha='85' shadow='low' />
</chart>
XML;

$xmlSubscribers = <<<XML
<?xml version='1.0' standalone='yes'?>
	<chart>
	<chart_type>line</chart_type>
    <chart_rect x='113' y='60' width='564' height='196' positive_color='0a0a0a' />
    <chart_grid_h color='5a5a5a' />
    <chart_border color='666666' /> 
	<axis_category font='Tahoma' bold='false' size='11' color='aaaaaa' />
	<series_color>
		<color>aa59ff</color>
	</series_color>
	<legend layout='vertical' fill_color='0a0a0a' color='aaaaaa' size='12' bold='false' font='Tahoma' />
	<axis_value size='11' color='aaaaaa' />
	<tooltip color='FFFFFF' alpha='75' size='11' background_color_1='282828' background_alpha='85' shadow='low' />
</chart>
XML;

$xmlPosts = <<<XML
<?xml version='1.0' standalone='yes'?>
	<chart>
	<chart_type>line</chart_type>
    <chart_rect x='113' y='60' width='564' height='196' positive_color='0a0a0a' />
    <chart_grid_h color='5a5a5a' />
    <chart_border color='666666' /> 
	<axis_category font='Tahoma' bold='false' size='11' color='aaaaaa' />
	<series_color>
		<color>fc1e75</color>
	</series_color>
	<legend layout='vertical' fill_color='0a0a0a' color='aaaaaa' size='12' bold='false' font='Tahoma' />
	<axis_value size='11' color='aaaaaa' />
	<tooltip color='FFFFFF' alpha='75' size='11' background_color_1='282828' background_alpha='85' shadow='low' />
</chart>
XML;
?>
<?php

// month posts Served

$chart = new SimpleXMLElement($xmlPostsServed);

$chartData = $chart->addChild('chart_data');

$row = $chartData->addChild('row');
$row->addChild('null', '');

$row->addChild('string', date("D j M Y", $lastMonday - $oneWeek * 3)." to \n".date("D j M Y", $lastMonday - $oneWeek * 2 - 1));
$row->addChild('string', date("D j M Y", $lastMonday - $oneWeek * 2)." to \n".date("D j M Y", $lastMonday - $oneWeek - 1));
$row->addChild('string', date("D j M Y", $lastMonday - $oneWeek)." to \n".date("D j M Y", $lastMonday - 1));
$row->addChild('string', date("D j M Y", $lastMonday)."\nto now");

$row = $chartData->addChild('row');
$row->addChild('string', 'Post views');

for ($i = count($month) - 1; $i >= 0; $i--)
{
	$data = $month[$i];	
	$elem = $row->addChild('number', $data->postsServed);
    $elem->addAttribute('tooltip', $data->postsServed.' post view'.($data->postsServed == 1 ? '' : 's'));
}

$chart->asXML("c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\stats\\blogs\\".md5($blog->id)."_month_posts_served.xml");

// month comments

$chart = new SimpleXMLElement($xmlComments);

$chartData = $chart->addChild('chart_data');

$row = $chartData->addChild('row');
$row->addChild('null', '');

$row->addChild('string', date("D j M Y", $lastMonday - $oneWeek * 3)." to \n".date("D j M Y", $lastMonday - $oneWeek * 2 - 1));
$row->addChild('string', date("D j M Y", $lastMonday - $oneWeek * 2)." to \n".date("D j M Y", $lastMonday - $oneWeek - 1));
$row->addChild('string', date("D j M Y", $lastMonday - $oneWeek)." to \n".date("D j M Y", $lastMonday - 1));
$row->addChild('string', date("D j M Y", $lastMonday)."\nto now");

$row = $chartData->addChild('row');
$row->addChild('string', 'Post comments');

for ($i = count($month) - 1; $i >= 0; $i--)
{
	$data = $month[$i];	
	$elem = $row->addChild('number', $data->comments);
    $elem->addAttribute('tooltip', $data->comments.' comment'.($data->comments == 1 ? '' : 's'));
}

$chart->asXML("c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\stats\\blogs\\".md5($blog->id)."_month_comments.xml");

// month subscribers

$chart = new SimpleXMLElement($xmlSubscribers);

$chartData = $chart->addChild('chart_data');

$row = $chartData->addChild('row');
$row->addChild('null', '');

$row->addChild('string', date("D j M Y", $lastMonday - $oneWeek * 3)." to \n".date("D j M Y", $lastMonday - $oneWeek * 2 - 1));
$row->addChild('string', date("D j M Y", $lastMonday - $oneWeek * 2)." to \n".date("D j M Y", $lastMonday - $oneWeek - 1));
$row->addChild('string', date("D j M Y", $lastMonday - $oneWeek)." to \n".date("D j M Y", $lastMonday - 1));
$row->addChild('string', date("D j M Y", $lastMonday)."\nto now");

$row = $chartData->addChild('row');
$row->addChild('string', 'New blog subscriptions');

for ($i = count($month) - 1; $i >= 0; $i--)
{
	$data = $month[$i];	
	$elem = $row->addChild('number', $data->subscriptions);
    $elem->addAttribute('tooltip', $data->subscriptions.' subscriber'.($data->subscriptions == 1 ? '' : 's'));
}

$chart->asXML("c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\stats\\blogs\\".md5($blog->id)."_month_subscribers.xml");

// month posts

$chart = new SimpleXMLElement($xmlPosts);

$chartData = $chart->addChild('chart_data');

$row = $chartData->addChild('row');
$row->addChild('null', '');

$row->addChild('string', date("D j M Y", $lastMonday - $oneWeek * 3)." to \n".date("D j M Y", $lastMonday - $oneWeek * 2 - 1));
$row->addChild('string', date("D j M Y", $lastMonday - $oneWeek * 2)." to \n".date("D j M Y", $lastMonday - $oneWeek - 1));
$row->addChild('string', date("D j M Y", $lastMonday - $oneWeek)." to \n".date("D j M Y", $lastMonday - 1));
$row->addChild('string', date("D j M Y", $lastMonday)."\nto now");

$row = $chartData->addChild('row');
$row->addChild('string', 'Posts you\'ve made');

for ($i = count($month) - 1; $i >= 0; $i--)
{
	$data = $month[$i];	
	$elem = $row->addChild('number', $data->posts);
    $elem->addAttribute('tooltip', $data->posts.' post'.($data->posts == 1 ? '' : 's'));
}

$chart->asXML("c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\stats\\blogs\\".md5($blog->id)."_month_posts.xml");

?>