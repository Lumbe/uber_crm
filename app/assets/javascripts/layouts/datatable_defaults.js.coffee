$ ->
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
  return