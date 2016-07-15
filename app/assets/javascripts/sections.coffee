
window.saveFieldsSort = ->
  order = $('#sort_fields tbody').sortable('serialize')
  $.ajax
    method: 'post'
    url: '/sections/' + $('#field_section_id').val() + '/fields/save_sort'
    data: order: order
    success: (result) ->
  return

window.askDeleteField = (id) ->
  section_id = $('#field_section_id').val()
  $.ajax
    method: 'get'
    url: '/sections/' + section_id + '/fields/' + id + '/ask_delete'
  return

$ ->

  $('#sort_fields tbody').sortable
    cursor: 'move'
    opacity: 0.7
    update: (e, ui) ->
      saveFieldsSort()
      return

  $('a[id^="ad_field_"]').each ->
    $($(this)).click ->
      askDeleteField $(this).attr('id').split('_')[2]
      return
