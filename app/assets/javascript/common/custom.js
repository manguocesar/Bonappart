$(window).on('load', function () {
	var preloader = $('#preloader');
	preloader.fadeOut('slow', function () { $(this).remove(); });
	$('.form-gp input').on('focus', function () {
		$(this).parent('.form-gp').addClass('focused');
	});
	$('.form-gp input').on('focusout', function () {
		if ($(this).val().length === 0) {
			$(this).parent('.form-gp').removeClass('focused');
		}
	});

	var windowResize = function () {
		var e = function () {
			var e = (window.innerHeight > 0 ? window.innerHeight : this.screen.height) - 5;
			(e -= 67) < 1 && (e = 1), e > 67 && $(".main-content").css("min-height", e + "px");
		};
		$(window).ready(e), $(window).on("resize", e);
	};
	windowResize();

	$(document).ready(function () {
		windowResize();
	});

	$('.nav-btn').on('click', function () {
		$('.page-container').toggleClass('sbar_collapsed');
	});

	$('select, .selectpicker').selectpicker({ liveSearch: false });
});
DatePickerRange = {
	init: function () {
		new Lightpick({field:document.getElementById("at-startdate"),secondField:document.getElementById("at-enddate"),singleDate:!1,onSelect:function(e,a){e&&e.format("Do MMMM YYYY"),a&&a.format("Do MMMM YYYY")}});
	}
}