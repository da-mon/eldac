
window.doModal = (id, title, content, closeBtnTitle, closeBtnClass) ->
  html = '<div id="' + id + '" class="modal fade" tabindex="-1" role="dialog">'
  html += '<div class="modal-dialog">'
  html += '<div class="modal-content">'
  html += '<div class="modal-header">'
  html += '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
  html += '<h4 class="modal-title">' + title + '</h4>'
  html += '</div>'
  html += '<div class="modal-body">'
  html += content
  html += '</div>'
  html += '<div class="modal-footer">'
  html += '<button type="button" class="btn btn-default btn-' + closeBtnClass + '" data-dismiss="modal">' + closeBtnTitle + '</button>'
  html += '</div>'
  html += '</div>'
  html += '</div>'
  html += '</div>'
  $('body').append html
  $('#' + id).modal()
  return
