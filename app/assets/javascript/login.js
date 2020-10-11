//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap.min.js
//= require jquery.validate
//= require common/custom
//= require devise_forms/validate.js

$.validator.addMethod('CUSTOM_EMAIL', function (emailaddr, element) {
  emailaddr = emailaddr.replace(/\s+/g, '');
  return this.optional(element) ||
    emailaddr.match(/^([a-z\d+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i);
}, 'Enter valid email.' );

function popoverPlacement(error, element) {
  var elem = $(element);
  disablePopover(element);
  elem.popover({ content: error[0].innerText,
                  trigger: 'focus',
                  placement: function (context, source) {
                    var position = $(source).position();
                    if (window.innerWidth >= 500) {
                      return "left";
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