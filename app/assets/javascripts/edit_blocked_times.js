//= require lib/dateSlider.js

$(function(){
 	$("#date").datepicker();
 	DateSlider.render('#slider', 'edit_blocked_times', '#startHour', '#startMin', '#endHour', '#endMin');
});
