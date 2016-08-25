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
        fnServerParams: function (aoData) {
          var statuses = $('.lead_status').map(function(){ // array of lead status codes
            var result = $(this).prop('checked') ? parseInt($(this).val()) : null; // if status is checked, push it to array result[]
            return result; // statuses[] = result[]
          });
          // send to leads controller(index action) array - statuses[] with status codes, e.g. [0, 1, 2, 3, 4]
          aoData.push({name: "statuses", value: statuses.toArray()}); // not returning proper array, to fix added .toArray()
          // send to leads controller START and END date for datapicker
          aoData.push({name: "start", value: $('.datatables-datapicker').data('start')});
          aoData.push({name: "end", value: $('.datatables-datapicker').data('end')});
          // send to leads controller selected department value(:id)
          aoData.push({name: "department", value: $('.select-departments').val()});
        },
        columnDefs: [
          {aTargets: [0, 1, 2, 3, 4, 5, 6], bSortable: false},
          {aTargets: [6], sClass: 'text-center'}
        ]
      });

    // redraw datatable with filtered statuses, when status checkbox is checked or unchecked
    $('.lead_status').on("change", function() {
      table.draw();
    });
    
    $('.select-departments').on("change", function() {
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
