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

	$(document).on('turbolinks:load', function () {
		windowResize();
	});

	$('.nav-btn').on('click', function () {
		$('.page-container').toggleClass('sbar_collapsed');
	});
});
