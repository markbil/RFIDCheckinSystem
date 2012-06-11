$(document).ready(function() {

	// hide all but .collapse-nohide
	$('.collapse-content').each(function(index) {
		if ($(this).attr('class') != 'collapse-nohide') {
			$(this).hide();
		}
	});

	// toggle content
	$(document).on('click', '.collapse-head', function(event) {
		event.preventDefault();
		var content_name = '#' + $(this).attr("id") + '-content';
		var content = $(content_name);
		content.slideToggle();
	});
	
});
