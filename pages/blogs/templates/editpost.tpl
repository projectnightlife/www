<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Project Nightlife | Post</title>
<link rel="shortcut icon" href="images/core/icons/favicon.ico" type="image/x-icon" />
<link rel="icon" type="image/png" href="images/core/icons/favicon.png" />
<link rel="apple-touch-icon" href="images/core/icons/favicon.png" />
<!-- Framework CSS -->
  <link rel="stylesheet" href="css/blueprint/screen.css" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="css/blueprint/print.css" type="text/css" media="print">
  <!--[if lte IE 7]><link rel="stylesheet" href="http://www.projectnightlife.co.uk/css/blueprint/ie.css" type="text/css" media="screen, projection"><![endif]-->
  <!--[if IE]><link rel="stylesheet" href="http://www.projectnightlife.co.uk/css/ie.css" type="text/css" media="screen, projection"><![endif]-->
  <link rel="stylesheet" href="css/core.css" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="css/blogs.css" type="text/css" media="screen, projection">
</head>

<body id="blogs">
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="masthead">
 	    <div class="heading">
          <h1 class="left">{$blog->name}</h1><h1 class="right">{if $uri|strpos:"v=edit" === false}New Post{else}Edit Post{/if}</h1>
        </div>
        <hr />
      </div>
      
      <div class="canvas">
         
        <div class="span180">
          {include file='../../includes/templates/blogs/editblog_nav.tpl'}
        </div> <!-- span200 -->
          
        <div class="span770 leftspcr">
          <div class="UIpanel">
            <div class="UIheading">
              <h3>Blog post</h3>
            </div>
            <form id="postForm" name="postForm" action="backend/ajax.php" ajaxify="1" callback="postSubmitted" spinner="postSpinner:002" errorcallback="postError" onformsubmit="submitPost" autocomplete="off">
              <input type="hidden" name="params" value='{ "service":"blog","method":"AddOrUpdatePost", "id":"{$post->id}" }' autocomplete="off" />
              <table class="UIform">
                <tbody>
                  <tr>
                    <th><label>Title</label></th><td><div><input id="postTitle" type="text" name="title" value="{$post->title}" validator="api.validation.nonEmpty" maxlength="255" /></div></td>
                  </tr>
                  <tr>
                    <td colspan="2"><hr /></td>
                  </tr>
                </tbody>
                <tbody>
                  <tr>
                    <th><label>Body</label></th><td><textarea id="postBody" name="body" serializable="serializeBody:api.serializeStringFormatting" validator="api.validation.nonEmpty" class="expand260-1000"></textarea></td>
                  </tr>
                  <tr>
                    <td colspan="2"><hr /></td>
                  </tr>
                </tbody>
                <tbody>
                  <tr>
                    <th><label>Photos</label></th>
                    <td class="UIsinglePhotoUpload">
                      <div id="addedPhotos" class="addedContent"></div>
                      <div class="addContentContainer">
                        <a href="#" onclick="return initAddPhotos();" id="addPhotoText">Add photos</a>
                        <div id="photo_upload">
                          <span class="uploadPhotoText">Upload a photo</span>
                          <iframe id="upload_iframe" src="http://www.projectnightlife.co.uk/blogupload.php?type=BlogUploadPhoto" frameborder="0" scrolling="no"></iframe>
                        </div>
                        <div id="uploading">
                          <img src="images/core/spinners/001.gif" />
                          <span style="margin-left: 10px;">Uploading Photo...</span>
                        </div>
                        <div id="photoUploadWarning" class="UIembeddedMsg">Your photo changes will take effect once you press publish. If you deleted the wrong photo, you can restore your post's original photos (if any existed) by <u>not</u> saving your changes.</div>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2"><hr /></td>
                  </tr>
                </tbody>
                <tbody>
                  <tr>
                    <th><label>Audio & Video</label></th>
                    <td>
                      <div id="addedObjects" class="addedContent"></div>
                      <div class="addContentContainer">
                        <a href="#" onclick="return initAddObjects();" id="addObjectText">Add flash content</a>
                        <textarea id="object" name="helper" style="height: 50px; display: none;"></textarea>
                        <label class="uiButton" id="objectButton" style="display: none;">
                          <input type="button" onclick="addObject()" value="Add Flash" />
                        </label>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2"><hr /></td>
                  </tr>
                </tbody>
                <tbody>
                  <tr>
                    <th><label>Keywords</label></th>
                    <td>
                      <div>
                        <input id="keywordInput" name="helper" class="UIoptionInput" type="text" /><span class="italic">Type a keyword and press enter</span>
                      </div>
                      <select id="keywords" name="keywords" class="UIoptions" serializable="serializeKeywords" validator="validateKeywords" size="{if $keywords|@count > 3}{$keywords|@count}{else}3{/if}">
                      {foreach from=$keywords item=keyword name=keywords}
                        <option value="{$keyword->value}">{$keyword->value}</option>
                      {/foreach}
                      </select>
                      <label class="uiButton" style="margin: 1em 0;">
                        <input type="button" onclick="removeKeywordOption()" value="Remove keyword" />
                      </label>
                      <div id="keywordWarning" class="UIembeddedMsg">Warning: You must enter at least two keywords in order for Project Nightlife relate this post to others.</div>
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2"><hr /></td>
                  </tr>
                </tbody>
                <tbody>
                  <tr>
                    <th></th>
                    <td>
                      <input type="hidden" name="excerpt" serializable="serializeExcerpt" value="" autocomplete="off" />
                      <input type="hidden" name="thumbnail" serializable="serializeThumbnail" value="" autocomplete="off" />
                      <label class="uiButton uiButtonConfirm">
                        {if $uri|strpos:"v=edit" === false}
                        <input type="submit" id="submitPost" value="Publish" />
                        {else}
                        <input type="submit" id="submitPost" value="Save" />
                        {/if}
                      </label>
                      <label class="uiButton">
                        {if $uri|strpos:"v=edit" === false}
                        <input type="button" value="Discard" onclick="api.launchConfirmDialog(&quot;Do you wish to discard this post?&quot;, &quot;discardPost&quot;); return false;" />
                        {else}
                        <input type="button" value="Delete" onclick="api.launchConfirmDialog(&quot;Do you wish to delete this post?&quot;, &quot;removePost&quot;, &quot;{$post->id}&quot;); return false;" />
                        {/if}
                      </label>
                      <div id="savingNotification" class="UIembeddedMsg">
                        <span>Awaiting server confirmation...</span>
                        <div class="ajaxSpinner" id="postSpinner"></div>
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </form>
              
          </div><!-- UIpanel -->
        </div> <!-- span750 -->
        
      </div> <!-- canvas -->
    </div> <!-- container -->
    <div class="push"></div>
  </div> <!-- wrapper -->
  {include file='../../includes/templates/footer.tpl'}
  <div id="fb-root"></div>
  <textarea id="originalPostBody" style="display:none;">{$post->body}</textarea>
  <input type="hidden" id="postThumbnailId" value="{if $post->thumbnail != 1}{$post->thumbnail}{/if}" />
</body>
</html>
{include file='../../includes/templates/js.tpl'}
<script type="text/javascript" src="js/pnobject-linkify.js"></script>
<script type="text/javascript" src="js/jquery.textarea-expander.js"></script>
<script type="text/javascript" src="js/blogs/editpost.js"></script>