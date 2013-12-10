//= require lib/dateSlider.js

$(function(){
 	$("#date").datepicker();
 	DateSlider.render('#slider', 'new_blocked_times', 'start_time[hour]', 'start_time[min]', 'end_time[hour]', 'end_time[min]');
});
