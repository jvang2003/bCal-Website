//=require lib/dateSlider.js

$(function(){
 	$("#date").datepicker();
 	DateSlider.render('#slider', 'new_request', '#startHour', '#startMin', '#endHour', '#endMin');
});
