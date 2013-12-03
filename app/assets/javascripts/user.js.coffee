# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# $(document).ready(function(){
#   $("#date").datepicker();
#   $("#time").timepicker();
# });

console.log jQuery ->
    console.log "HIHIHI"
    $('a.disabled').each (index, item) -> item.href = "javascript:void(0);"

