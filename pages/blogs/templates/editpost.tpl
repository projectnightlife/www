{include file='../../includes/templates/page.tpl'}
<title>{if $uri|strpos:"v=edit" === false}New{else}Edit{/if} Post | Project Nightlife</title>
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="screen, projection">
</head>

<body id="blogs{if $ismobile == "true"} mobile{/if}">
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="masthead">
 	    <div class="heading">
          <h1 class="left">{$blog->name}</h1><h1 class="right">{if $uri|strpos:"v=edit" === false}New{else}Edit{/if} Post</h1>
        </div>
        <hr />
      </div>
      
      <div class="canvas">
         
        <div class="span180">
          {include file='../../includes/templates/blogs/editblog_nav.tpl'}
        </div> <!-- span200 -->
          
        <div class="span770 leftspcr">
          <div class="UIpanel UIcontainer">
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
                        <a href="#" onClick="return initAddPhotos();" id="addPhotoText">Add photos</a>
                        <div id="photo_upload">
                          <span class="uploadPhotoText">Upload a photo</span>
                          <iframe id="upload_iframe" src="blogupload.php?type=BlogUploadPhoto" frameborder="0" scrolling="no"></iframe>
                        </div>
                        <div id="uploading">
                          <img src="images/core/spinners/001.gif" />
                          <span style="margin-left: 10px;">Uploading Photo...</span>
                        </div>
                        <div id="photoUploadWarning" class="UIembeddedMsg">Your photo changes will take effect once you press save. If you deleted the wrong photo, you can restore your post's original photos by <u>not</u> saving your changes.</div>
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
                        <a href="#" onClick="return initAddObjects();" id="addObjectText">Add flash content</a>
                        <textarea id="object" name="helper" style="height: 50px; display: none;"></textarea>
                        <label class="uiButton" id="objectButton" style="display: none;">
                          <input type="button" onClick="addObject()" value="Add Flash" />
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
                        <input type="button" onClick="removeKeywordOption()" value="Remove keyword" />
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
                        <input type="button" value="Discard" onClick="api.launchConfirmDialog(&quot;Do you wish to discard this post?&quot;, &quot;discardPost&quot;); return false;" />
                        {else}
                        <input type="button" value="Delete" onClick="api.launchConfirmDialog(&quot;Do you wish to delete this post?&quot;, &quot;removePost&quot;, &quot;{$post->id}&quot;); return false;" />
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
              
          </div><!-- UIpanel UIcontainer -->
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
{include file='../../includes/templates/critical_js.tpl'}
<script type="text/javascript" src="{$pageData['jsFile']}"></script>
{include file='../../includes/templates/js.tpl'}