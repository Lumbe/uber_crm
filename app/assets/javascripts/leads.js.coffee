# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # Set departments select tag without search field, fixed width & medium size
  $('.select-departments').select2
    minimumResultsForSearch: Infinity
    containerCssClass: 'select-sm'
    width: 200

  # DataTable for Leads
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
      data = {}
      aoData.forEach (item)->
        data[item.name] = item.value
      link = $('.leads-export')
      link.attr('href', link.attr('href').split('?')[0] + '?' + $.param(data))
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

  # External table additions
  # ------------------------------
  # Add placeholder to the datatable filter option
  $('.dataTables_filter input[type=search]').attr 'placeholder', 'Имя, Телефон, Email'
  # Enable Select2 select for the length option
  $('.dataTables_length select').select2
    minimumResultsForSearch: Infinity
    width: 'auto'
  return