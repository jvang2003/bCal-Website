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

	function updateHiddenFields(e, data, one, two, three, four) {
		console.log(data);
		$(one).val(data.values.min.getHours());
		$(two).val(data.values.min.getMinutes());
		$(three).val(data.values.max.getHours());
		$(four).val(data.values.max.getMinutes());
	}

	me.render = function(renderDiv, formId, nameStartHour, nameStartMin, nameEndHour, nameEndMin) {
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

		$(renderDiv).bind("userValuesChanged", (function() {
			return function(e, data) {
				updateHiddenFields.apply(this, [e, data, nameStartHour, nameStartMin, nameEndHour, nameEndMin]);
			};
		})()
		);
		updateHiddenFields(null, {
			values: {
				min: defaultStart,
				max: defaultEnd
			}
		}, nameStartHour, nameStartMin, nameEndHour, nameEndMin);
	};
	return me;
})();