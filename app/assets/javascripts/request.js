//=require lib/dateSlider.js

$(function(){
 	$("#date").datepicker();
 	DateSlider.render('#slider', 'new_request', 'time[hour]', 'time[min]', 'finish_time[hour]', 'finish_time[min]');
});
