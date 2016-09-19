# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # Set departments select tag without search field, fixed width & medium size
  $('.select-departments').select2
    minimumResultsForSearch: Infinity
    containerCssClass: 'select-sm'
    width: 200

  # DataTable SETUP
  # ------------------------------
  # Setting datatable defaults
  $.extend $.fn.dataTable.defaults,
    autoWidth: false
    columnDefs: [ {
      orderable: false
      width: '100px'
      targets: [ 5 ]
    } ]
    dom: '<"datatable-header"fl><"datatable-scroll"t><"datatable-footer"ip>'
    language:
      search: '<span>Поиск:</span> _INPUT_'
      lengthMenu: '<span>Показать:</span> _MENU_'
      paginate:
        'first': 'Первая'
        'last': 'Последняя'
        'next': '&rarr;'
        'previous': '&larr;'
      info: 'Записи с _START_ до _END_ из _TOTAL_ записей'
      infoEmpty: 'Нет ни одной записи'
    drawCallback: ->
      $(this).find('tbody tr').slice(-3).find('.dropdown, .btn-group').addClass 'dropup'
      return
    preDrawCallback: ->
      $(this).find('tbody tr').slice(-3).find('.dropdown, .btn-group').removeClass 'dropup'
      return
  table = $('.datatable-leads').DataTable(
    serverSide: true
    sAjaxSource: location.pathname
    stateSave: true
    fnServerParams: (aoData) ->
      statuses = $('.lead_status').map(->
        # array of lead status codes
        result = if $(this).prop('checked') then parseInt($(this).val()) else null
        # if status is checked, push it to array result[]
        result
        # statuses[] = result[]
      )
      # send to leads controller(index action) array - statuses[] with status codes, e.g. [0, 1, 2, 3, 4]
      aoData.push
        name: 'statuses'
        value: statuses.toArray()
      # not returning proper array, to fix added .toArray()
      # send to leads controller START and END date for datapicker
      aoData.push
        name: 'start'
        value: $('.datatables-datapicker').data('start')
      aoData.push
        name: 'end'
        value: $('.datatables-datapicker').data('end')
      # send to leads controller selected department value(:id)
      aoData.push
        name: 'department'
        value: $('.select-departments').val()
      return
    columnDefs: [
      {
        aTargets: [
          0
          1
          2
          3
          4
          5
          6
        ]
        bSortable: false
      }
      {
        aTargets: [ 6 ]
        sClass: 'text-center'
      }
    ])
  # redraw datatable with filtered statuses, when status checkbox is checked or unchecked
  $('.lead_status').on 'change', ->
    table.draw()
    return
  $('.select-departments').on 'change', ->
    table.draw()
    return
  # Alternative pagination
  $('.datatable-pagination').DataTable
    pagingType: 'simple'
    language: paginate:
      'next': 'Next &rarr;'
      'previous': '&larr; Prev'
  # Datatable with saving state
  $('.datatable-save-state').DataTable stateSave: true
  # Scrollable datatable
  $('.datatable-scroll-y').DataTable
    autoWidth: true
    scrollY: 300
  # External table additions
  # ------------------------------
  # Add placeholder to the datatable filter option
  $('.dataTables_filter input[type=search]').attr 'placeholder', 'Введите имя, телефон...'
  # Enable Select2 select for the length option
  $('.dataTables_length select').select2
    minimumResultsForSearch: Infinity
    width: 'auto'
  return