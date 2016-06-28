
window.saveSectionsSort = ->
  order = $('#sort_sections tbody').sortable('serialize')
  $.ajax
    method: 'post'
    url: '/pages/' + $('#page_id').val() + '/sections/save_sort'
    data: order: order
    success: (result) ->
  return

window.askDeleteSection = (page_id, id) ->
  $.ajax
    method: 'get'
    url: '/pages/' + page_id + '/sections/' + id + '/ask_delete'
  return

$ ->

  $('#sort_sections tbody').sortable
    cursor: 'move'
    opacity: 0.7
    update: (e, ui) ->
      saveSectionsSort()
      return

  $('a[id^="ad_section_"]').each ->
      $($(this)).click ->
        askDeleteSection $('#page_id').val(), $(this).attr('id').split('_')[2]
        return
