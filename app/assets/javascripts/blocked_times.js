# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function(){
 	$("#date").datepicker();
 	DateSlider.render('#slider', 'new_request', 'time[(4i)]', 'time[(5i)]', 'finish_time[(4i)]', 'finish	_time[(5i)]');
});
