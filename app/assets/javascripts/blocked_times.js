//= require lib/dateSlider.js

$(function(){
 	$("#date").datepicker();
 	DateSlider.render('#slider', 'new_blocked_times', 'time[(4i)]', 'time[(5i)]', 'finish_time[(4i)]', 'finish_time[(5i)]');
});
