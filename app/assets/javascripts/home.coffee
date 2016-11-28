$ ->
  # DataTable for Contacts
  table = $('.datatable-top-contacts').DataTable(
    serverSide: true
    sAjaxSource: location.pathname
    fnServerParams: (aoData) ->
      if $('.contacts-export').length                                                  # check if element exists on page
        data = {}
        aoData.forEach (item)->
          data[item.name] = item.value
        link = $('.contacts-export')
        link.attr('href', link.attr('href').split('?')[0] + '?' + $.param(data))
      return
    searching: false
    paging: false
    language: {
      infoFiltered: ''
    }
    columnDefs: [
      {
        aTargets: [
          0
          1
          2
        ]
        bSortable: false
      }
      {
        aTargets: [ 1, 2 ]
        sClass: 'text-center'
      }
    ])