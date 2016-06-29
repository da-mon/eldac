
window.saveFieldsSort = ->
  order = $('#sort_fields tbody').sortable('serialize')
  $.ajax
    method: 'post'
    url: '/sections/' + $('#field_section_id').val() + '/fields/save_sort'
    data: order: order
    success: (result) ->
  return

$ ->

  $('#sort_fields tbody').sortable
    cursor: 'move'
    opacity: 0.7
    update: (e, ui) ->
      saveFieldsSort()
      return
