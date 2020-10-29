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
		startDate = document.getElementsByClassName("at-startdate");
		endDate = document.getElementsByClassName("at-enddate");
		for (let i = 0; i <= startDate.length; i++) {
			if(null!= startDate[i])new Lightpick({field:startDate[i],secondField:endDate[i],singleDate:!1,onSelect:function(e,a){e&&e.format("Do MMMM YYYY"),a&&a.format("Do MMMM YYYY")}});
		}
		startDateTwo = document.getElementsByClassName("at-startdatetwo");
		endDateTwo = document.getElementsByClassName("at-enddatetwo");
		for (let i = 0; i < startDateTwo.length; i++) {
			if(null!=startDateTwo[i])new Lightpick({field:startDateTwo[i],secondField:endDateTwo[i],singleDate:!1,onSelect:function(e,a){e&&e.format("Do MMMM YYYY"),a&&a.format("Do MMMM YYYY")}})
		}
	}
}