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
var $ = jQuery

DatePicker = {
  init: function () {
    new Lightpick({
      field: document.getElementById('birthdate'),
      onSelect: function (date) {
        document.getElementById('birthdate').innerHTML = date.format('Do MMMM YYYY');
      }
    });
  }
}