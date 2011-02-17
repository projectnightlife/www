{include file='../../includes/templates/page.tpl'}
<title>Guide | Project Nightlife</title>
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="screen, projection">
  <style type="text/css">
    .tutorial h3 { font-size: 20px; color: #ABA0C0; margin-bottom: 12px; line-height: 22px; }
	.tutorial h4 { color: #777; }
    .tutorial { font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif !important; }
	.tutorial img { display: block; margin: 5px auto 20px; padding: 3px; border: 1px solid #333; }
  </style>
</head>

<body id="blogs{if $ismobile == "true"} mobile{/if}">
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="masthead">
 	    <div class="heading">
          <h1 class="left">{$blog->name}</h1><h1 class="right">Guide</h1>
        </div>
        <hr />
      </div>
      
      <div class="canvas">
         
        <div class="span180">
          {include file='../../includes/templates/blogs/editblog_nav.tpl'}
        </div> <!-- span200 -->
          
        <div class="span770 leftspcr">
          <div class="UIpanel">
            <div class="tutorial">
              <p>At Project Nightlife, we pride ourselves on the quality of our site. We want to ensure you guys know how to create quality posts which will be recognised both for their cutting edge, industry leading content and for how that content is presented to our readers.</p>
              <p>The following guide details how to use our blogging system as well as how to gain the best results from it. We've worked hard to make the site as user friendly and intuitive as possible, however if you feel we could improve something or even add new features, then we want to <a href="#" onClick="return api.composeMessage('Contact Us', api.contactus(), '{$pageData['hostname']}/backend/communicate.php', 0);" title="Contact us">hear your suggestions</a>.</p>
              <p>To ensure all of our features work as they should, make sure you've got the latest version of your browser installed. In particular, if you use Internet Explorer, we highly recommend upgrading to version 9. You can get the update <a href="http://windows.microsoft.com/en-US/internet-explorer/download/ie-9/worldwide" target="_blank">here</a>.</p>
              <h3>Accessing the dashboard</h3>
              <p>In order to access your blog dashboard, you'll need to be logged in. Once you've logged in, you'll see a dashboard button appear at the top right of each page.</p>
              <img src="images/tutorials/bloggers/dashboard_button.jpg" alt="Dashboard button" />
              
              <h3>The dashboard</h3>
              <p>The dashboard provides a brief overview of your blog. In particular, it highlights your current blog profile picture, the name of your blog, your slogan and the author (i.e. you). If you're part of a multi-author blog you'll see listed everybody who has permission to contribute to your blog.</p>
              <p>Whenever we need to update our bloggers with the latest news and info, you'll see this listed in the messages area.</p>
              <p>Finally, you're also presented with some brief stats for your blog - although more about stats later.</p>
              <img src="images/tutorials/bloggers/dashboard.jpg" alt="The dashboard" />
              
              <h3>Left Menu</h3>
              <p>The left menu is only available when you enter the dashboard, or any of the blogger only pages.</p>
              <img src="images/tutorials/bloggers/left_menu.jpg" alt="The left menu" />
              
              <h3>Creating a post</h3>
              <p>Creating posts rich in content is easy. The powerful yet simple tools we provide allow you to upload photos, embed Flash (such as Youtube, Soundcloud and content from other sites) as well as insert links with ease. You can also style text in bold, italic and underlined.</p>
              <p>Try to include at least one photo with each post. Posts with photos are always read more than those without. For example if you're blogging about an artist, try and find an official press photo or a photo of the artist playing live. If you're blogging about a track, try and find a photo of the release's artwork, or failing that, a photo of the artist.</p>
              <p>If you're struggling to find a photo to use, try and find an official website and look for press photos.</p>
              <p>If you think its appropriate, add a youtube video or soundcloud clip, especially if you're blogging about a new track. You may even be posting your latest mix!</p>
              <p>To create a post, choose <i>New post</i> from the left menu. You're presented with the following page.</p>
              <img src="images/tutorials/bloggers/post.jpg" alt="A new post" />
              <p>Try to come up with an intriguing title in order to make your post stand out and entice the reader to read more.</p>
              <p>The Body of your post is where you write your content. We recommend opening your post with a photo - posts with an opening photo look a lot better than those without. If your post is longer than the box provided, it'll automatically expand as you type.</p>
              
              <h4>Formatting</h4>
              <p>To format text in your post, simply surround it with the appropriate tag pairing.</p>
              <p><b>Bold text</b> is achieved by typing [b]This text will be bold[/b].<br />
                 <i>Italic text</i> is achieved by typing [i]This text will be italic[/i].<br />
                 <u>Underlined text</u> is achieved by typing [u]This text will be underlined[/u].<br /></p>
              <p>You can also combine these tags to create more complex text formatting such as <b><i>bold italic</i></b>. This is achieved like this [b][i]This text will be bold italic[/i][/b].</p>
              <img src="images/tutorials/bloggers/formatting.jpg" alt="Formatting text in your posts" />
              <p>Ensure you have both an opening and closing tag around your desired text and that the closing tag contains a forward slash before the b, i or u. If you're layering formatting, ensure you close inner tags before outter tags.</p>
              
              <h4>Adding links</h4>
              <p>Adding links is as simple as pasting the address into the body of your post at the position you want it. We'll automatically detect any links and make them clickable when the post is viewed.</p>
              
              <h4>Adding photos</h4>
              <p>To add a photo, begin by clicking the <i>Add photos</i> link, this will uncover the upload facility.</p>
              <img src="images/tutorials/bloggers/add_photo.jpg" alt="Add photo" />
              <p>Select <i>Choose File</i> and pick the photo you wish to upload. <i>Don't worry if your button looks different</i></p>
              <img src="images/tutorials/bloggers/upload.jpg" alt="Upload a photo" />
              <p>As soon as you select your photo, it'll automatically start uploading.</p>
              <img src="images/tutorials/bloggers/uploading.jpg" alt="Uploading a photo" />
              <p>Once complete, it'll appear as a thumbnail in your post and the upload facility will reappear again. To upload a second photo, simply repeat the previous steps. <i>Don't worry if your photo has been cropped in the thumbnail, we'll display the whole photo when the post is viewed</i><p>
              <img src="images/tutorials/bloggers/photo_thumb.jpg" alt="Photo thumbnail" />
              <p>Every post is given a thumbnail which will be displayed whenever we preview your post and by default, this is set to the first photo in the list. To change this, simply check the <i>Main Photo</i> box under the photo you wish to make the thumbnail. Always ensure you pick the best photo from those in your post to entice readers in.</p>
              <p>If you want to remove one of the photos you've uploaded, simply click the cross in the upper right hand corner of the photo.</p>
              <p>When you upload a photo, you'll notice a tag appear at the end of the text in the <i>Body</i> box e.g. &lt;Photo 1&gt;. This tag corresponds to the photo with the matching name located below it and allows you to control where that particular photo will appear in your post.</p>
              <img src="images/tutorials/bloggers/tag_insertion.jpg" alt="Initial tag placement" />
              <p>By default we place the tag below the text you've currently written, however you can cut and paste it anywhere within your post. If you want to open your post with a photo at the very top, you can do so as shown below.</p>
              <img src="images/tutorials/bloggers/photos.jpg" alt="Photos within a post" />
              <p><i>Don't worry if you delete one of these tags and can't get it back, simply retype the tag again e.g. &lt;Photo 3&gt;.</i>
              <p>We accept virtually any image format, however the image must be under 5mb in size.</p>
              
              <h4>External images</h4>
              <p>If you wish to display a photo from another website, you'll need to save it to your computer first and then upload it to your blog post. This can usually be done by right clicking the photo you wish to use and selecting the menu option along the lines of <i>Save Image As</i>. Make a note of where the image has been saved so you can select it when uploading to Project Nightlife.</p>
              <!--<p>Please remember when using images from other websites, unless its a press photo or states otherwise, you'll need to cite the source of the photo in your post. We recommend having a section at the bottom of your post citing each photo. For example</p>
              <p>[1] Name of website<br />
                 [2] Name of website<br />
                 etc...</p>-->
              
              <h4>Adding audio and video</h4>
              <p>To add flash audio or video, begin by clicking the <i>Add flash content</i> link, this will uncover the embed facility.</p>
              <img src="images/tutorials/bloggers/add_flash.jpg" alt="Add Flash" />
              <p>You're presented with a text box and an <i>add flash</i> button. The text box is where we paste the content for the flash file.</p>
              <p>Adding content from Youtube is easy, however adding flash from other websites is slightly different.</p>
              <h4>Youtube videos</h4>
              <p>If you're adding a youtube video, all thats required is to simply paste the youtube address from your browser's address bar into the box provided and click add flash.</p>
              <img src="images/tutorials/bloggers/youtube_browser.jpg" alt="Youtube address" />
              <img src="images/tutorials/bloggers/add_youtube.jpg" alt="Add Youtube" />
              <p>Upon adding your video, Your flash file will appear as a thumbnail in just the same way as photos.</p>
              <img src="images/tutorials/bloggers/youtube.jpg" alt="Youtube video" />
              <h4>SoundCloud</h4>
              <p>Adding a SoundCloud flash audio file is a little more tricky. We need to find whats known as the <i>embed code</i> and paste that into the box we provide.</p>
              <p>You'll notice in the upper left corner of the SoundCloud waveform is a <i>Share</i> button, clicking this provides you with all the ways you can share it. You'll see one of fields contains the embed code.</p>
              <img src="images/tutorials/bloggers/soundcloud.jpg" alt="Get SoundCloud" />
              <p>Clicking the code in the embed box automatically highlights it for you. Once you've copied it, switch to your <i>Add Post</i> window and paste it into the box we provide. <i>The code looks rather lengthy and complicated, but you theres no need to worry youself with what it all means</i>.</p>
              <img src="images/tutorials/bloggers/embed_soundcloud.jpg" alt="Embed SoundCloud" />
              <p>Finally, click <i>Add Flash</i>. Once again, you'll see a thumbnail appear of the SoundCloud waveform.</p>
              <img src="images/tutorials/bloggers/soundcloud_preview.jpg" alt="SoundCloud preview" />
              <h4>Other websites</h4>
              <p>To embed audio and video from all other websites requires you to again locate the embed code for the video. This can be found in much the same way as the SoundCloud example. Simply look for a share button or link and copy the embed code it provides.</p>
              <h4>General audio and video info</h4>
              <p>At present we only support Flash based audio and video files, however almost all audio and video on the web is Flash based.</p>
              <p>We're working hard to make it easier to embed audio and video from other popular websites in much the same way we do for youtube. We'll let you all know when these improvements become available.</p>
              <h4>Keywords</h4>
              <p>The final step to creating a new post is adding your chosen keywords. Keywords allow us to very quickly relate your post to others in the database and this is how we're able to recommend similar posts when you're reading a post.</p>
              <p>Picking good keywords is very important. The following points will ensure you always select good quality keywords for your post.</p>
              <ol>
                <li>Generally, only use Nouns. These include words representing people, places and things.</li>
                <li>Don't pick too many. Picking too many will ultimately result in us recommending two posts which really don't have much in common.</li>
              </ol>
              <p>As a general rule, try and pick around 3-6 keywords which when read back give a pretty good summary of what your post is about.</p>
              <p>For example if your post is about a new Swedish House Mafia track which was played for the first time at the Winter Music Conference 2011, good keywords would be <i>Swedish House Mafia</i>, <i>the name of the new track</i>, <i>Winter Music Conference</i> and <i>WMC</i>. If one of your keywords is regularly abbreviated, include the abbreviation as well.</p>
              <p>If you're reviewing a club night or a gig, include keywords such as the <i>name of the event</i> and maybe the <i>headlining act</i> as well as any other words you feel appropriate.</p>
              <p>If you're posting about this summer's fashion trends and you feature a section on shoes, make sure your keywords include <i>Summer Fashion</i> and <i>Shoes</i></p>
              <p>If you only mention something/somebody very briefly in your post i.e. just one or two sentences, we would recommend against including that as a keyword because it isn't representative of the overall post.</p>
              <p>To actually add a keyword, type it into the keyword box and hit the <i>enter</i> key. To remove it, simply select it and press <i>Remove Keyword</i>.</p>
              <p>Finally, we require you to enter at least two keywords to ensure we can gain a minimal understanding of what your post is about. Upon doing so, the warning box will fade away.</p>
              <img src="images/tutorials/bloggers/keyword_warning.jpg" alt="Keywords" />
              
              <h4>Publishing or discarding your post</h4>
              <p> When you're ready to publish your post, click <i>publish</i>. If we're ever unable to publish your post, you'll see a popup telling you to try again in a moment.</p>
              <p>if you choose against publishing your post, click the <i>discard</i> button and confirm this to return to a list of your previous posts.</p>
              <img src="images/tutorials/bloggers/publish_discard.jpg" alt="Publishing" />
              <p>Once you've begun writing a post, if you try and leave the page without publishing it, we'll display a confirmation warning ensuring you really do want to dispose of the post. This will prevent you losing your post if you accidently click a link.</p>
              <img src="images/tutorials/bloggers/navigation_alert.jpg" alt="Leaving the page without saving your post" />
              
              <h3>Managing your posts</h3>
              <p>To see a list of all of your previous posts, simply click <i>Manage posts</i> from the left menu. From this page you can view, edit or delete any post you've ever created.</p>
              <img src="images/tutorials/bloggers/manage.jpg" alt="Manage posts" />
              
              <h3>Editing a post</h3>
              <p>There are two ways to edit one of your posts. Each post listed in <i>Manage posts</i> has an <i>Edit</i> option <i>(as seen above)</i>. Alternatively, if you wish to edit the post you're reading, <i>(providing you or another member of your blog authored it)</i> you'll see an edit button along side the title of the post.</p>
              <img src="images/tutorials/bloggers/edit_post.jpg" alt="Edit post" />
              <p>Editing a post is identical to writing a new one and every aspect of your post is editable. Simply make any alterations and press save.</p>
              <p>One point worth mentioning is photos. If you remove a photo from your post, you'll see the following warning fade in.</p>
              <img src="images/tutorials/bloggers/edit_photos.jpg" alt="Edit photos" />
              <p>If you accidently remove the wrong photo, it can be recovered by not saving your changes. If you have already made changes elsewhere in your post, copy and paste them somewhere safe and reload the page <i>(either by pressing the back button and clicking edit again, or press the refresh button)</i>.
              <p>When you reload the page, you'll see the original photos again.</p>
              
              <h3>Deleting a post</h3>
              <p>If you ever wish to delete a post, again there are two ways to do this. Every post listed on the <i>Manage post</i> page also contains a delete option <i>(see above)</i>, clicking it presents you with a confirmation dialogue asking you to confirm or cancel your action.</p>
              <img src="images/tutorials/bloggers/confirm_delete.jpg" alt="Confirm delete" />
              <p>Alternatively, you can delete a post whilst editing it, simply click the <i>Delete</i> button next to save. Once again, confirm the warning and the post will be removed.</p>
              <img src="images/tutorials/bloggers/delete_post.jpg" alt="Delete post" />
              
              <h3>Changing blog details</h3>
              <p>If you need to change any of your blog's info, you can do so by clicking <i>Blog details</i> from the left menu. Once again, if you decide against the photo change you make, not saving your changes will restore your previous photo.</p>
              <h4>Genres and styles</h4>
              <p>Genres are possibly the most important aspect of your blog, as they allow us to categorise and relate your blog to others.</p>
              <p>We've got a pretty comprehensive database of music types and styles for you to choose from, however you can only add a style if it appears in the drop down when you begin typing it. If you require a new style, you can requesting it by clicking the link next to the search box. To add the genre, either click it or select it using the up/down keys and press enter.</p>
              <img src="images/tutorials/bloggers/genres.jpg" alt="Genres" />
              <p>Because they are so fundamental to categorising your blog, we require you to enter at least one. If you blog heavily about a very specific style of music such as <i>Acid House</i>, add this style. If you blog about all different types of house music, just add <i>House</i>. If your blog is even more general, simply add <i>Electronic</i>.
              <p>Genres are hierarchical and in the example given, <i>Acid House</i> is a sub-genre of <i>House</i> which is a sub-genre of <i>Electronic</i>. As a result, any searches for electronic blogs will also return acid house blogs.</p>
              <p>Unlike keywords, enter as many genres/styles as you like, providing you write posts related to those styles of music fairly often.</p>
              <p>If your blog is non music related, you can also select categories such as <i>fashion</i> and <i>film</i> from the drop down menu. We also allow you to choose styles which are non genre specific, such as <i>deep</i>, <i>mellow</i> or <i>remix</i>.</p>
              
              <h3>Insights</h3>
              <p>Insights allow you to visualise your blog's activity. Selecting <i>Insights</i> from the left menu presents you with graphs for the number of times your posts have been read, the number of comments your posts have received, the number of subscribers your blog has and the number of posts you've created.</p>
              <p>These statistics are live and allow you to easily track how popular your blog is or the rate at which your blog is growing. If your blog is in decline, you can take measures to win readers back.</p>
              
              <h3>Rewards</h3>
              <p>As our brand begins to gain ground and become industry recognised, we want to share our success with you. Afterall, you're just as much a part of Project Nightlife as the people who run the company on a day to day basis.</p>
              <p>In time, we'll give you the opportunity to experience some truly memorable nights out.</p>
              <p>When the time is right, we plan to advertise through the website. Don't worry, we don't plan on bombarding you with ads for the latest mobile phone deals or claiming to give you free bets when you sign up to online betting websites.</p>
              <p>Instead, we're working with companies in the music/nightlife and fashion industries to provide adverts directly related to your blog and which we hope your readers will find interesting. This is another reason why it is so important to pick good keywords for your posts and relavent genres and styles for your blog.</p>
              <p>When we do begin advertising, we'll pay you a cut of any advertising revenue your blog generates.</p>
              <p>We'll announce our plans regarding these in due course.</p>
            </div>
          </div>
        </div> <!-- span770 -->
        
      </div> <!-- canvas -->
    </div> <!-- container -->
    <div class="push"></div>
  </div> <!-- wrapper -->
  {include file='../../includes/templates/footer.tpl'}
  <div id="fb-root"></div>
</body>
</html>
{include file='../../includes/templates/critical_js.tpl'}
<script type="text/javascript" src="{$pageData['jsFile']}"></script>
{include file='../../includes/templates/js.tpl'}