<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Project Nightlife</title>

<style>
body { font-family: Tahoma, Geneva, sans-serif; color: #ccc; font-size: 12px; margin: 0; }
input { color: #ccc; }
</style>

<script type="text/javascript">
function initUploader()
{
  if (window.location.search.lastIndexOf("BlogUploadProfile") != -1)
  {
    document.getElementById('uploadForm').action += "?type=BlogUploadProfile";
	document.getElementById('return').value += "?type=BlogUploadProfile";
  }
  else
  {
	document.getElementById('uploadForm').action += "?type=BlogUploadPhoto";
    document.getElementById('return').value += "?type=BlogUploadPhoto";
  }
  try {
    document.getElementById('file').addEventListener("change", function (e) {
	  parent.uploadStarted();
      document.forms['upload'].submit();
    }, false);
  }
  catch (e)
  {
	document.getElementById('file').attachEvent("onchange", function (e) {
	  parent.uploadStarted();
      document.forms['upload'].submit();
    }, false);
  }
  <?php
  if (isset($_GET['photo']))
  {
	  echo "parent.uploadComplete('".$_GET['photo']."');";
  }
  if (isset($_GET['error']))
  {
	  echo "parent.uploadError();";
  }
  ?>
}
</script>

</head>

<body onload="initUploader()">
<form id="uploadForm" action="http://upload.projectnightlife.co.uk/photo.php" method="post" name="upload" enctype="multipart/form-data">
  <input id="file" name="image" class="text" type="file" />
  <input type="hidden" name="caption" value="" />
  <input type="hidden" name="return" id="return" value="<?php print $_SERVER['HTTP_HOST']; ?>/blogupload.php" />
</form>
</body>
</html>