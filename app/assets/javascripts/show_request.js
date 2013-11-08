$(function() {
	var filterEl = $('#filter'),
		tableList = $('.req');
	function filterTable(value) {
		value = value.toLowerCase();
		tableList.each(function() {
			var el = $(this);
			if (el.hasClass(value) || value == "all") {
				el.show();
			} else {
				el.hide();
			}
		});
	};
	filterEl.change(function() {
		filterTable(filterEl.val());
	});
});