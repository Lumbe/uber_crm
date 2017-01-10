# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
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
    pageLength: 100
    fnServerParams: (aoData) ->
      aoData.push
        name: 'start'
        value: $('.datatables-datapicker').data('start')
      aoData.push
        name: 'end'
        value: $('.datatables-datapicker').data('end')
      aoData.push
          name: 'filtered_regions'
          value: $('.filtered-regions').val()
      if $('.contacts-export').length                                                  # check if element exists on page
        data = {}
        aoData.forEach (item)->
          data[item.name] = item.value
        link = $('.contacts-export')
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
  $('.dataTables_filter input[type=search]').attr 'placeholder', 'имя, телефон, email'
  # Enable Select2 select for the length option
  $('.dataTables_length select').select2
    minimumResultsForSearch: Infinity
    width: 'auto'

  $('#modal_new_contact_message #message_to').val(gon.contact_email)
  $('#modal_new_contact_message #message_to').attr('readonly', 'readonly')
  $('#modal_new_contact_message form#new_message').on 'submit', ->
    $('#modal_new_contact_message').modal('hide')
  return