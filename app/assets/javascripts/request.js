//=require lib/dateSlider.js

$(function(){
 	$("#date").datepicker();
 	DateSlider.render('#slider', 'new_request', 'time[hour]', 'time[min]', 'end_time[hour]', 'end_time[min]');
});
