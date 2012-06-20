$(document).ready(function() {



	// hide all but .collapse-nohide on load, change arrows
	$('.collapse-head').each(function(index) {
		var content_name = '#' + $(this).attr('id') + '-content';
		var content = $(content_name);

		if ($(this).is('.collapse-floating')) {
			$(this).hide();
			content.css('padding-top', '1em').css('margin-top', '1em');
			return;
		}

		if (!$(this).is('.collapse-nohide')) {
			content.hide();

			var arrow_name = '#' + $(this).attr('id') + '-arrow-expanded';
			var arrow = $(arrow_name);

			if (arrow.length) {
				arrow.hide();
			}
		} else {
			var arrow_name = '#' + $(this).attr('id') + '-arrow-collapsed';
			var arrow = $(arrow_name);

			if (arrow.length) {
				arrow.hide();
			}
		}
	});



	// toggle content
	$(document).on('click', '.collapse-head', function(event) {
		if ($(this).is('.no-collapse')) {
			return;
		}
		
		// stops from toggling on radio button click
		if ($(this).children('input').length) {
			var target = event.target || event.srcElement || event.originalTarget; // cross-browser

			if ($(target).is("input")) {
				return; // is a button, don't toggle
			}
		}


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
