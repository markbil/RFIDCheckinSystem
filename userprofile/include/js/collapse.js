$(document).ready(function() {

	// hide all but .collapse-nohide
	$('.collapse-head').each(function(index) {
		var content_name = '#' + $(this).attr('id') + '-content';
		var content = $(content_name);

		if (content.attr('class') != 'collapse-nohide') {
			content.hide();

			var arrow_name = '#' + $(this).attr('id') + '-arrow-expanded';
			var arrow = $(arrow_name);

			if (arrow.length) {
				arrow.hide();
			}
		}
		// insert code here to import the v ^ divs into each header, except the ones with no-collapse
		/*var arrow_name = '#' + $(this).attr('id') + '-arrow';
		var arrow = $(arrow_name);


			<div class="collapsed-arrow right" id="collapse-profile-arrow-collapsed">&darr;</div>
			<div class="expanded-arrow right" id="collapse-profile-arrow-expanded">&uarr;</div>*/
	});

	// toggle content
	$(document).on('click', '.collapse-head', function(event) {
		if ('no-collapse' == $(this).attr('class')) {
			return;
		}
		event.preventDefault();
		var content_name = '#' + $(this).attr('id') + '-content';
		var content = $(content_name);

		var arrow_expanded_name = '#' + $(this).attr('id') + '-arrow-expanded';
		var arrow_expanded = $(arrow_expanded_name);

		var arrow_collapsed_name = '#' + $(this).attr('id') + '-arrow-collapsed';
		var arrow_collapsed = $(arrow_collapsed_name);

		if (content.is(':hidden')) {
			arrow_expanded.show();
			arrow_collapsed.hide();
		} else {
			arrow_expanded.hide();
			arrow_collapsed.show();
		}

		content.slideToggle('fast');

	});
	
});
