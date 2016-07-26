/* ------------------------------------------------------------------------------
*
*  # Basic datatables
*
*  Specific JS code additions for datatable_basic.html page
*
*  Version: 1.0
*  Latest update: Aug 1, 2015
*
* ---------------------------------------------------------------------------- */

$(function() {


    // Table setup
    // ------------------------------

    // Setting datatable defaults
    $.extend( $.fn.dataTable.defaults, {
        autoWidth: false,
        columnDefs: [{ 
            orderable: false,
            width: '100px',
            targets: [ 5 ]
        }],
        dom: '<"datatable-header"fl><"datatable-scroll"t><"datatable-footer"ip>',
        language: {
            search: '<span>Поиск:</span> _INPUT_',
            lengthMenu: '<span>Показать:</span> _MENU_',
            paginate: { 'first': 'Первая', 'last': 'Последняя', 'next': '&rarr;', 'previous': '&larr;' },
            info: "Записи с _START_ до _END_ из _TOTAL_ записей",
            infoEmpty: "Нет ни одной записи"
        },
        drawCallback: function () {
            $(this).find('tbody tr').slice(-3).find('.dropdown, .btn-group').addClass('dropup');
        },
        preDrawCallback: function() {
            $(this).find('tbody tr').slice(-3).find('.dropdown, .btn-group').removeClass('dropup');
        }
    });

    var table = $('.datatable-basic').DataTable( {
        serverSide: true,
        sAjaxSource: location.pathname, // current page url '/leads'
        stateSave: true,
        "fnServerParams": function (aoData) {
          var statuses = [];
          var filter_new_status = $("#newly").is(":checked");
          var filter_closed_status = $("#closed").is(":checked");
          var filter_converted_status = $("#converted").is(":checked");
          var filter_sended_status = $("#sended").is(":checked");
          var filter_repeated_status = $("#repeated").is(":checked");

          // if checkbox is checked - push status code to array
          if (filter_new_status == true) {
            statuses.push(0) // new status code is 0
          }
          if (filter_closed_status == true) {
            statuses.push(1) // closed status code is 1
          }
          if (filter_converted_status == true) {
            statuses.push(2) // converted status code is 2
          }
          if (filter_sended_status == true) {
            statuses.push(3) // sended status code is 3
          }
          if (filter_repeated_status == true) {
            statuses.push(4) // repeated status code is 4
          }
          // send to leads index controller - statuses: [0, 1, 2, 3, 4], where [0, 1, 2, 3, 4] is status codes
          aoData.push({name: "statuses", value: statuses});
        },
        columnDefs: [
          {aTargets: [0, 1, 2, 3, 4, 5, 6], bSortable: false},
          {aTargets: [6], sClass: 'text-center'}
        ]
      });

    // when statuses checkbox is checked or unchecked - redraw the table with filtered statuses
    $("#newly, #closed, #converted, #sended, #repeated").on("change", function() {
      table.draw();
    });


    // Alternative pagination
    $('.datatable-pagination').DataTable({
        pagingType: "simple",
        language: {
            paginate: {'next': 'Next &rarr;', 'previous': '&larr; Prev'}
        },
        
    });


    // Datatable with saving state
    $('.datatable-save-state').DataTable({
        stateSave: true
    });


    // Scrollable datatable
    $('.datatable-scroll-y').DataTable({
        autoWidth: true,
        scrollY: 300
    });
    

    // External table additions
    // ------------------------------

    // Add placeholder to the datatable filter option
    $('.dataTables_filter input[type=search]').attr('placeholder','Введите имя, телефон...');


    // Enable Select2 select for the length option
    $('.dataTables_length select').select2({
        minimumResultsForSearch: Infinity,
        width: 'auto'
    });
    
});
