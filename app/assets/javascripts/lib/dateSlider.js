//= require vendor/jQAllRangeSliders-withRuler-min.js

var DateSlider = (function() {
	var me = {};
	var defaultStart = new Date(2013, 0, 1, 6, 0),
		defaultEnd = new Date(2013, 0, 1, 18, 0);

	function _formatDate(date, shortened){
	    var hours = date.getHours();
	  	var minutes = date.getMinutes();
	  	var ampm = hours >= 12 ? 'pm' : 'am';
	  	hours = hours % 12;
	  	hours = hours ? hours : 12; // the hour '0' should be '12'
	  	minutes = minutes < 10 ? '0'+minutes : minutes;
	  	if (shortened) {
	  		var strTime = hours + ' ' + ampm;
	  	} else {
	  		var strTime = hours + ':' + minutes + ' ' + ampm;
	  	}
	  	return strTime;
	};

	function updateHiddenFields(e, data) {
		console.log(data);
		$('#input1').val(data.values.min.getHours());
		$('#input2').val(data.values.min.getMinutes());
		$('#input3').val(data.values.max.getHours());
		$('#input4').val(data.values.max.getMinutes());
	}

	me.render = function(renderDiv, formId, nameStartHour, nameStartMin, nameEndHour, nameEndMin) {
		var input1 = document.createElement("input");
		input1.setAttribute("id", "input1");
		input1.setAttribute("type", "hidden");
		input1.setAttribute("name", nameStartHour);
		// input.setAttribute("value", "value_you_want");
		document.getElementById(formId).appendChild(input1);
		var input2 = document.createElement("input");
		input2.setAttribute("id", "input2");
		input2.setAttribute("type", "hidden");
		input2.setAttribute("name", nameStartMin);
		// input.setAttribute("value", "value_you_want");
		document.getElementById(formId).appendChild(input2);
		var input3 = document.createElement("input");
		input3.setAttribute("id", "input3");
		input3.setAttribute("type", "hidden");
		input3.setAttribute("name", nameEndHour);
		// input.setAttribute("value", "value_you_want");
		document.getElementById(formId).appendChild(input3);
		var input4 = document.createElement("input");
		input4.setAttribute("id", "input4");
		input4.setAttribute("type", "hidden");
		input4.setAttribute("name", nameEndMin);
		// input.setAttribute("value", "value_you_want");
		document.getElementById(formId).appendChild(input4);

		$(renderDiv).dateRangeSlider({
	  		step: {
	  			'minutes': 5
	  		},
		  	bounds: {
		  		min: new Date(2013, 0, 1, 0, 0),
		  		max: new Date(2013, 0, 1, 23, 59),
		  	},
		  	arrows: false,
		  	formatter: _formatDate,
		    defaultValues: {
		    	min: defaultStart,
		    	max: defaultEnd
		    },
		    scales: [
			{
			    first: function(val){ 
			    	// return new Date(2013, 0, 1, 0, 0);
			    	return val;
			    },
			    next: function(val){
			    	var date = new Date(val); 
			    	date.setHours(val.getHours() + 1);
			    	return date;
			    	// return val + 10;
			    },
			    end: function(val) {
			    	return val;
			    },
			    stop: function(val){ 
			    	// return val.getHours() == 23;
			    	return false;
			    },
			    label: function(val){ 
			    	return _formatDate(val, true); 
			    }	
			}]
		});

		$(renderDiv).bind("userValuesChanged", updateHiddenFields);
		updateHiddenFields(null, {
			values: {
				min: defaultStart,
				max: defaultEnd
			}
		});
	};
	return me;
})();