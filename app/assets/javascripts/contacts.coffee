# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # Set departments select tag without search field, fixed width & medium size
  $('.select-departments').select2
    minimumResultsForSearch: Infinity
    containerCssClass: 'select-sm'
    width: 200
    
  $('.filtered-regions').select2
    minimumResultsForSearch: Infinity
    containerCssClass: 'select-sm'
    width: 600
    
  $('.select-filtered-regions-clear').on 'click', ->
    $('.filtered-regions').val(null).trigger('change')


  # DataTable for Contacts
  table = $('.datatable-contacts').DataTable(
    serverSide: true
    sAjaxSource: location.pathname
    stateSave: true
    fnServerParams: (aoData) ->
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
      aoData.push
          name: 'filtered_regions'
          value: $('.filtered-regions').val()
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
        ]
        bSortable: false
      }
      {
        aTargets: [ 5 ]
        sClass: 'text-center'
      }
    ])
  # redraw datatable on departments change
  $('.select-departments').on 'change', ->
    table.draw()
    return
    
  # redraw datatable on regions change
  $('.filtered-regions').on 'change', ->
    table.draw()
    return

  # External table additions
  # ------------------------------
  # Add placeholder to the datatable filter option
  $('.dataTables_filter input[type=search]').attr 'placeholder', 'Введите имя, телефон...'
  # Enable Select2 select for the length option
  $('.dataTables_length select').select2
    minimumResultsForSearch: Infinity
    width: 'auto'
  return