	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var tabContainers = $("#tabs > div");
			
			$("#tabs ul.tabNavigation a").click(function () {
				tabContainers.hide().filter(this.hash).show();
				
				$("#tabs ul.tabNavigation a").removeClass("selected");
				$(this).addClass("selected");
				
				return false;
			}).filter(":first").click();
			
			
			$(".mainheader_pulldown").click(function() {
				var pulldown = $("#pulldown");
				
				if (pulldown.css("display") == "none") {
					pulldown.css("display", "block");
				} else {
					pulldown.css("display", "none");
				}
				
				
			});
			
			$(".UIobjectlist").css("width", $(window).width() + 'px');
			
			$(window).resize(function() {
				$(".UIobjectlist").css("width", $(window).width() + 'px');
			});
		});
	</script>