//= require moment
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-datetimepicker-3
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require underscore
//= require gmaps/google
//= require_tree ./channels
//= require_tree .

(function() {
  $(document).on('click', '.toggle-window', function(e) {
    e.preventDefault();
    var panel = $(this).parent().parent();
    var messages_list = panel.find('.messages-list');

    panel.find('.panel-body').toggle();
    panel.attr('class', 'panel');

    if (panel.find('.panel-body').is(':visible')) {
      var height = messages_list[0].scrollHeight;
      messages_list.scrollTop(height);
    }
  });
})();

$(document).ready(function() {
  $('#datetimepicker1').datetimepicker();
  $('#datetimepicker2').datetimepicker();

  $('#datetimepicker1').on('dp.change', function (e) {
    $('#datetimepicker2').data('DateTimePicker').minDate(e.date);
  });
});
