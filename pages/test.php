<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Project Nightlife | Blog control panel</title>
<!-- Framework CSS -->
  <link rel="stylesheet" href="css/blueprint/screen.css" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="css/blueprint/print.css" type="text/css" media="print">
  <!--[if lte IE 7]><link rel="stylesheet" href="http://new.projectnightlife.co.uk/css/blueprint/ie.css" type="text/css" media="screen, projection"><![endif]-->
  <!--[if IE]><link rel="stylesheet" href="http://new.projectnightlife.co.uk/css/ie.css" type="text/css" media="screen, projection"><![endif]-->
  <link rel="stylesheet" href="css/core.css" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="css/blogs.css" type="text/css" media="screen, projection">
  
<script src="http://connect.facebook.net/en_US/all.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/corners.js"></script>
<script type="text/javascript" src="js/api.js"></script>
<!--[if lte IE 6]><script>api.upgradeBrowser();</script><![endif]-->
  
</head>

<body>
Post a comment
 <div class="comments">
<form id="commentForm" action="backend/ajax.php" ajaxify="1" callback="methodname">
                <input type="hidden" name="params" value="{&quot;service&quot;:&quot;blog&quot;,&quot;method&quot;:&quot;AddComment&quot;,&quot;postId&quot;:&quot;21&quot;}" autocomplete="off" />
                <textarea name="content" serializable="api.serializeString" validator="api.validateComment"></textarea>
                <input type="submit" value="Comment" />
 </form>
 </div>
 <div id="fb-root"></div>
</body>
</html>
<script type="text/javascript">
function methodname(response)
{
	alert("callback invoked!");
}
</script>
