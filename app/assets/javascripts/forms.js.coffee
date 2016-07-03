
window.savePagesSort = ->
  order = $('#sort_pages tbody').sortable('serialize')
  $.ajax
    method: 'post'
    url: '/forms/' + $('#page_form_id').val() + '/pages/save_sort'
    data: order: order
    success: (result) ->
  return

window.askDeletePage = (id) ->
  $.ajax
    method: 'get'
    url: '/forms/' + $('#page_form_id').val() + '/pages/' + id + '/ask_delete'
  return

$ ->

  $('#sort_pages tbody').sortable
    cursor: 'move'
    opacity: 0.7
    update: (e, ui) ->
      savePagesSort()
      return

  $('a[id^="ad_page_"]').each ->
      $($(this)).click ->
        askDeletePage $(this).attr('id').split('_')[2]
        return
