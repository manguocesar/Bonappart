//= require jquery
//= require jquery_ujs
//= require popper
//= require jquery.validate
//= require common/bootstrap-select.min
//= require dashboard/plugins
//= require dashboard/main
//= require dashboard/Chart.bundle
//= require dashboard/dashboard
//= require dashboard/widgets
//= require apartments/custom
//= require apartment_types/validate
//= require admin/users_validate
//= require common/moment.min
//= require common/lightpick
//= require common/bootstrap-select.min
//= require settings/custom
//= require invoices/custom

var $ = jQuery

DatePicker = {
  init: function () {
    startDate = document.getElementsByClassName("datepicker");
    for (let i = 0; i <= startDate.length; i++) {
      if (null != startDate[i]) new Lightpick({
        field: startDate[i],
        minDate: new Date(),
        onSelect: function (date) {
          startDate[i].innerHTML = date.format('Do MMMM YYYY');
        }
      });
    }
  }
}