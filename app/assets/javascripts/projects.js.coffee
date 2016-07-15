
window.askDeleteForm = (id) ->
  project_id = $('#form_project_id').val()
  url = '/projects/' + project_id + '/forms/' + id + '/ask_delete'
  $.ajax
    method: 'get'
    url: url
  return

window.askDeleteFolder = (id) ->
  $.ajax
    method: 'get'
    url: '/folders/' + id + '/ask_delete'
  return

window.editFolder = (id) ->
  $.ajax
    method: 'get'
    url: '/folders/' + id + '/edit'
  return

window.toggleFolderCollapse = (id) ->
  visible = $('span#fc-' + id).is(':visible')
  if visible
    $('tr#header-' + id).show()
    $('span#fc-' + id).hide()
    $('span#fo-' + id).show()
  else
    $('tr#header-' + id).hide()
    $('span#fc-' + id).show()
    $('span#fo-' + id).hide()
  $('tr[id^=f' + id + ']').each (k, v) ->
    if visible
      $(v).show()
    else
      $(v).hide()
    return
  $.ajax
    method: 'post'
    url: '/folders/toggle_collapse'
    data: id: id
    success: (result) ->
  return

window.rebindControls = ->
  $('input:checkbox[id^="checkall"]').prop 'checked', projectsAllChecked()
  $('input:checkbox[id^="p_"]').each ->
    $($(this)).click ->
      toggleProjectFolder $(this).attr('id').split('_')[1]
      return
    return
  $('input:checkbox[id^="checkall"]').click ->
    checkAllProjects()
    return
  $('input:checkbox[id^="assigned"]').click ->
    setAssigned()
    return
  return

window.setAssigned = ->
  assigned = $('input:checkbox[id^="assigned"]').prop('checked')
  $.ajax
    method: 'post'
    url: '/projects/assigned_folder'
    data: assigned: if assigned then '1' else '0'
    success: (result) ->
      $('#projects_list').html result
      rebindControls()
      return
  return

window.checkAllProjects = ->
  folder_id = $('select#folder_id').val()
  if folder_id == 0
    return
  checkall = $('input:checkbox[id^="checkall"]').prop('checked')
  id = undefined
  project_ids = []
  $('input:checkbox[id^="p_"]').each ->
    id = $(this).attr('id').split('_')[1]
    project_ids.push id
    $(this).prop 'checked', checkall
    $('div#s_' + id).show()
    $('div#s_' + id).fadeOut 1000
    return
  if project_ids.length == 0
    return
  $.ajax
    method: 'post'
    url: '/projects/checkall_folder'
    data:
      folder_id: folder_id
      project_ids: project_ids
      checkall: if checkall then '1' else '0'
    success: (result) ->
  return

window.toggleProjectFolder = (project_id) ->
  folder_id = parseInt( $('select#folder_id').val() )
  if folder_id == 0
    return
  $('div#s_' + project_id).show()
  $('div#s_' + project_id).fadeOut 1000
  $.ajax
    method: 'post'
    url: '/projects/toggle_folder'
    data:
      folder_id: folder_id
      project_ids: [ project_id ]
    success: (result) ->
      $('input:checkbox[id^="checkall"]').prop 'checked', projectsAllChecked()
      return
  return

window.getProjects = ->
  folder_id = parseInt( $('select#folder_id').val() )
  $('#projects_list').html ''
  $.ajax
    method: 'post'
    url: '/folders/organize'
    data: folder_id: folder_id
    success: (result) ->
      $('#projects_list').html result
      rebindControls()
      return
  return

window.projectsAllChecked = ->
  cbs = $('input:checkbox[id^="p_"]')
  if cbs.length == 0
    return false
  r = true
  $('input:checkbox[id^="p_"]').each ->
    if !$(this).prop('checked')
      r = false
    return
  r

window.saveFoldersSort = ->
  order = $('#sort_folders tbody').sortable('serialize')
  $.ajax
    method: 'post'
    url: '/folders/save_sort'
    data: order: order
    success: (result) ->
  return

window.saveFormsSort = (project_id) ->
  order = $('#sort_forms tbody').sortable('serialize')
  $.ajax
    method: 'post'
    url: '/projects/' + project_id + '/forms/save_sort'
    data: order: order
    success: (result) ->
  return

$ ->

  $('#sort_folders tbody').sortable
    cursor: 'move'
    opacity: 0.7
    update: (e, ui) ->
      saveFoldersSort()
      return

  $('#sort_forms tbody').sortable
    cursor: 'move'
    opacity: 0.7
    update: (e, ui) ->
      saveFormsSort($('#form_project_id').val())
      return

  $('input:checkbox[id^="assigned"]').click ->
    getProjects()
    return

  $('select#folder_id').change ->
    getProjects()
    return

  $('a[id^="ad_folder_"]').each ->
    $($(this)).click ->
      askDeleteFolder $(this).attr('id').split('_')[2]
      return

  $('a[id^="folder_"]').each ->
    $($(this)).click ->
      editFolder $(this).attr('id').split('_')[1]
      return

  $('a[id^="ad_form_"]').each ->
    $($(this)).click ->
      askDeleteForm $(this).attr('id').split('_')[2]
      return

  return
