// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function doModal(id, title, content, closeBtnTitle, closeBtnClass)
{
  html = '<div id="' + id + '" class="modal fade" tabindex="-1" role="dialog">';
  html += '<div class="modal-dialog">';
  html += '<div class="modal-content">';
  html += '<div class="modal-header">';
  html += '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
  html += '<h4 class="modal-title">' + title + '</h4>';
  html += '</div>';
  html += '<div class="modal-body">';
  html += '<p>' + content + '</p>';
  html += '</div>';
  html += '<div class="modal-footer">';
  html += '<button type="button" class="btn btn-default btn-' + closeBtnClass + '" data-dismiss="modal">' + closeBtnTitle + '</button>';
  html += '</div>';
  html += '</div>';
  html += '</div>';
  html += '</div>';

  $('body').append(html);
  $('#' + id).modal();
}
