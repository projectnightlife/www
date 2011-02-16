	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var tabContainers = $("#tabs > div");
			
			// Tabbed navigation
			$("#tabs ul.tabNavigation a").click(function () {
				tabContainers.hide().filter(this.hash).show();
				
				$("#tabs ul.tabNavigation a").removeClass("selected");
				$(this).addClass("selected");
				
				return false;
			}).filter(":first").click();
			
			// Main header pull down
			$(".mainheader_pulldown").click(function() {
				var pulldown = $("#pulldown");
				
				if (pulldown.css("display") == "none") {
					pulldown.css("display", "block");
				} else {
					pulldown.css("display", "none");
				}	
			});
			
			// Apply .maxwidth to all images in 
			$("div.post img").each(function(i) { 
				$(this).addClass("maxwidth"); 
			});
			
			// Resize elements
			$(".widthfix").css("width", $(window).width() + 'px');
			$("#commentBox").css("width", $(window).width() - 40 + 'px');
			$("img.maxwidth").css("max-width", $(window).width() - 40 + 'px');
			
			$(window).resize(function() {
				$(".widthfix").css("width", $(window).width() + 'px');
				$("#commentBox").css("width", $(window).width() - 40 + 'px');
				$("img.maxwidth").css("max-width", $(window).width() - 40 + 'px');
			});
		});
	</script>