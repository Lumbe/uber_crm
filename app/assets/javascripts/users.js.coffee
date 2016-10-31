# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # DataTable for user leads
  table = $('.user-leads-datatable').DataTable(
    serverSide: true
    sAjaxSource: location.pathname
    stateSave: true
    columnDefs: [
      {
        aTargets: [
          0
          1
          2
          3
        ]
        bSortable: false
      }
    ])

  # External table additions
  # ------------------------------
  # Add placeholder to the datatable filter option
  $('.dataTables_filter input[type=search]').attr 'placeholder', 'Имя, Телефон, Email'
  # Enable Select2 select for the length option
  $('.dataTables_length select').select2
    minimumResultsForSearch: Infinity
    width: 'auto'
  return