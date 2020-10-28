//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap.min
//= require common/owl.carousel.min
//= require common/moment.min
//= require common/fullcalendar.min
//= require common/prettyPhoto
//= require common/tipso
//= require common/readmore
//= require common/lightpick
//= require common/main-min
//= require jquery.validate
//= require common/custom
//= require devise_forms/validate

$.validator.addMethod('CUSTOM_EMAIL', function (emailaddr, element) {
  emailaddr = emailaddr.replace(/\s+/g, '');
  return this.optional(element) ||
    emailaddr.match(/^([a-z\d+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i);
}, 'Enter valid email.' );

$.validator.addMethod('PHONE_NUMBER', function (phoneNumber, element) {
  return this.optional(element) ||
    phoneNumber.match(/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/);
}, 'Enter valid phone number.' );

jQuery.validator.addMethod("lettersonly", function(value, element) {
  return this.optional(element) || /^[a-z]+$/i.test(value);
}, "Enter characters only.");

function popoverPlacement(error, element) {
  var elem = $(element);
  disablePopover(element);
  elem.popover({ content: error[0].innerText,
                  trigger: 'focus',
                  placement: function (context, source) {
                    var position = $(source).position();
                    if (window.innerWidth >= 500) {
                      if($("input:odd" ).toArray().includes($(source)[0])){
                        return "left";
                      }else{
                        return 'right';
                      }
                    }
                    return "top";
                },
                  animation: true,
                  template: '<div class="popover is-invalid-popover" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'
                });
  $(elem).popover("show");
}

function disablePopover(elem) {
  $(elem).popover('hide');
  $(elem).popover('disable');
  $(elem).popover('dispose');
}

$(document).ready(function () {
  $(".preloader-outer").delay(500).fadeOut();
  $(".at-preloader-holder").delay(200).fadeOut("slow");
})