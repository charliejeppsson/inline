
$(document).ready(function() {
  $('.attachinary-input').attachinary();
});

// CUSTOMIZED ATTACHINARY INPUT DESIGN
$.attachinary.config.template = '\
  <ul class="list-unstyled">\
    <% for(var i=0; i<files.length; i++){ %>\
      <li>\
        <% if(files[i].resource_type == "raw") { %>\
          <div class="raw-file"></div>\
        <% } else { %>\
          <img\
            src="<%= $.cloudinary.url(files[i].public_id, { "version": files[i].version, "format": "jpg", "crop": "fill", "width": 455, "text-align": "left" }) %>"\
            alt="" />\
        <% } %>\
        <a href="#" data-remove="<%= files[i].public_id %>"><i class="md md-clear md-2x"></i></a>\
      </li>\
    <% } %>\
  </ul>\
';
