{include file='../../includes/templates/page.tpl'}
<title>Edit Blog | Project Nightlife</title>
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="screen, projection">
</head>

<body id="blogs{if $ismobile == "true"} mobile{/if}">
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="masthead">
 	    <div class="heading">
          <h1 class="left">{$blog->name}</h1><h1 class="right">Blog Details</h1>
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
              <h3>Blog details</h3>
            </div>
            <form id="blogForm" name="blogForm" action="backend/ajax.php" ajaxify="1" callback="blogSaved" spinner="blogSpinner:002" errorcallback="saveError" onformsubmit="saveBlog" autocomplete="off">
              <input type="hidden" name="params" value='{ "service":"blog","method":"AddOrUpdateBlog", "id":"{$blog->id}" }' autocomplete="off" />
              <table class="UIform">
                <tbody>
                  <tr>
                    <th><label>Name</label></th><td><div><input id="blogName" type="text" name="name" value="{$blog->name}" validator="api.validation.nonEmpty" maxlength="128" /></div></td>
                  </tr>
                  <tr>
                    <td colspan="2"><hr /></td>
                  </tr>
                </tbody>
                <tbody>
                  <tr>
                    <th><label>Slogan</label></th><td><div><input id="blogSlogan" type="text" name="slogan" value="{$blog->slogan}" maxlength="255" /></div></td>
                  </tr>
                  <tr>
                    <td colspan="2"><hr /></td>
                  </tr>
                </tbody>
                <tbody>
                  <tr>
                    <th><label>Description</label></th><td><textarea id="blogDescription" name="description" validator="api.validation.nonEmpty" class="expand260-1000" onKeyDown="api.limitText(this,4000);" onKeyUp="api.limitText(this,4000);" onChange="api.limitText(this,4000);"></textarea></td>
                  </tr>
                  <tr>
                    <td colspan="2"><hr /></td>
                  </tr>
                </tbody>
                <tbody>
                  <tr>
                    <th><label>Photo</label></th>
                    <td class="UIsinglePhotoUpload">
                      <div id="addedPhotos" class="addedContent"></div>
                      <div class="addContentContainer">
                        <a href="#" onClick="return initAddPhotos();" id="addPhotoText">Add photos</a>
                        <div id="photo_upload">
                          <span class="uploadPhotoText">Upload a photo</span>
                          <iframe id="upload_iframe" src="blogupload.php?type=BlogUploadProfile" frameborder="0" scrolling="no"></iframe>
                        </div>
                        <div id="uploading">
                          <img src="images/core/spinners/001.gif" />
                          <span style="margin-left: 10px;">Uploading Photo...</span>
                        </div>
                        <div id="photoUploadWarning" class="UIembeddedMsg">Your photo change will take effect once you press save. To restore your original photo (if one existed), <u>don't</u> save your changes.</div>
                      </div>
                      <input type="hidden" name="thumbnail" serializable="serializeThumbnail" value="" autocomplete="off" />
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2"><hr /></td>
                  </tr>
                </tbody>
                <tbody>
                  <tr>
                    <th><label>Genres / Styles</label></th>
                    <td>
                      <div style="position: relative; z-index: 100;" id="genreContainer">
                        <input id="genreInput" name="helper" class="UIoptionInput" type="text" /><span class="italic">Genre or style not listed? <a href="#" onClick="return requestGenre();">Request it</a> or <a href="genres.php" target="_blank">See all</a></span>
                        <div id="genreFilter" class="dropDown"></div>
                      </div>
                      <select id="genres" name="genres" class="UIoptions" serializable="serializeGenres" validator="validateGenres" size="{if $blogGenres|@count > 3}{$blogGenres|@count}{else}3{/if}">
                        {foreach from=$blogGenres item=genre name=blogGenres}
                          <option value="{$genre->id}">{$genre->name}</option>
                        {/foreach}
                      </select>
                      <label class="uiButton" style="margin: 1em 0;">
                        <input type="button" onClick="removeGenreOption()" value="Remove style" />
                      </label>
                      <div id="genreEmptyWarning" class="UIembeddedMsg">Warning: You must enter at least one genre or style in order for Project Nightlife to index your blog and any posts you make.</div>
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
                      <label class="uiButton uiButtonConfirm">
                        <input type="submit" id="saveBlog" value="Save" />
                      </label>
                      <div id="savingNotification" class="UIembeddedMsg">
                        <span>Awaiting server confirmation...</span>
                        <div class="ajaxSpinner" id="blogSpinner"></div>
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
  <textarea id="originalBlogDescription" style="display:none;">{$blog->description}</textarea>
  <input type="hidden" id="blogPhotoId" value="{if $blog->thumbnail != 1}{$blog->thumbnail}{/if}" />
</body>
</html>
{include file='../../includes/templates/critical_js.tpl'}
<script type="text/javascript" src="{$pageData['jsFile']}"></script>
{include file='../../includes/templates/js.tpl'}
<script type="text/javascript">
var genres = new Array(
{foreach from=$genres item=genre name=genres}
  { id:{$genre->id}, name:'{$genre->name}' }{if !$smarty.foreach.genres.last},{/if}
{/foreach}
);

genres.sort(sortGenres);
</script>