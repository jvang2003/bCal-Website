// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require chosen-jquery
//= require_tree .


jQuery(function() {
    var fadeTime = 200;
    var fadeDelay = 50;
    var fadingOut = {};
    jQuery('ul.nav li.dropdown').hover(function() {
        var $this = jQuery(this);
        var menu = $this.find('.dropdown-menu');
        if (fadingOut[$this.attr('id')]) {
            menu.stop(true, true);
        }
        else {
            if (menu.is(":visible")) {
                menu.hide();
            }
        }
        menu.fadeIn(fadeTime);
    }, function() {
        var $this = jQuery(this);
        var menu = $this.find('.dropdown-menu');
        fadingOut[$this.attr('id')] = true;
        menu.stop(true, true).delay(fadeDelay).fadeOut(fadeTime/3, function () {
            fadingOut[$this.attr('id')] = false;
        });
    });
});
