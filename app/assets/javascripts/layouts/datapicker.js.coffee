$ ->
  # DATE RANGE PICKER
  # ------------------------------
  # Setup
  $('#reportrange').daterangepicker {
    startDate: moment().subtract('days', 29)
    endDate: moment()
    minDate: '01/01/2014'
    maxDate: '12/31/2016'
    dateLimit: days: 60
    ranges:
      'Today': [
        moment()
        moment()
      ]
      'Yesterday': [
        moment().subtract('days', 1)
        moment().subtract('days', 1)
      ]
      'Last 7 Days': [
        moment().subtract('days', 6)
        moment()
      ]
      'This Month': [
        moment().startOf('month')
        moment().endOf('month')
      ]
      'Last Month': [
        moment().subtract('month', 1).startOf('month')
        moment().subtract('month', 1).endOf('month')
      ]
    opens: 'left'
    buttonClasses: [ 'btn' ]
    applyClass: 'btn-small btn-info btn-block'
    cancelClass: 'btn-small btn-default btn-block'
    separator: ' to '
    locale:
      applyLabel: 'Применить'
      fromLabel: 'С'
      toLabel: 'По'
      customRangeLabel: 'Диапазон дат'
      daysOfWeek: [
        'Пн'
        'Вт'
        'Ср'
        'Чт'
        'Пт'
        'Сб'
        'Вс'
      ]
      monthNames: [
        'Январь'
        'Февраль'
        'Март'
        'Апрель'
        'Май'
        'Июнь'
        'Июль'
        'Август'
        'Сентябрь'
        'Октябрь'
        'Ноябрь'
        'Декабрь'
      ]
      firstDay: 1
  }, (start, end) ->
    # Format date
    $('#reportrange .daterange-custom-display').html start.format('<i>D</i> <b><i>MMM</i> <i>YYYY</i></b>') + '<em>&#8211;</em>' + end.format('<i>D</i> <b><i>MMM</i> <i>YYYY</i></b>')
    return
  # Format date
  $('#reportrange .daterange-custom-display').html moment().subtract('days', 29).format('<i>D</i> <b><i>MMM</i> <i>YYYY</i></b>') + '<em>&#8211;</em>' + moment().format('<i>D</i> <b><i>MMM</i> <i>YYYY</i></b>')

  # As a button
  # Setup
  $('.daterange-ranges').daterangepicker {
    startDate: moment().subtract('days', 29)
    endDate: moment()
    minDate: '01/01/2014'
    maxDate: '12/31/2025'
    dateLimit: days: 60
    ranges:
      'Сегодня': [
        moment()
        moment()
      ]
      'Вчера': [
        moment().subtract('days', 1)
        moment().subtract('days', 1)
      ]
      'Последние 7 дней': [
        moment().subtract('days', 6)
        moment()
      ]
      'Последние 30 дней': [
        moment().subtract('days', 29)
        moment()
      ]
      'Этот месяц': [
        moment().startOf('month')
        moment().endOf('month')
      ]
      'Предыдущий месяц': [
        moment().subtract('month', 1).startOf('month')
        moment().subtract('month', 1).endOf('month')
      ]
    locale:
      format: 'DD/MM/YYYY'
      applyLabel: 'Применить'
      cancelLabel: 'Отменить'
      startLabel: 'Начальная дата:'
      endLabel: 'Конечная дата:'
      fromLabel: 'С'
      toLabel: 'По'
      customRangeLabel: 'Диапазон дат'
      daysOfWeek: [
        'Пн'
        'Вт'
        'Ср'
        'Чт'
        'Пт'
        'Сб'
        'Вс'
      ]
      monthNames: [
        'Январь'
        'Февраль'
        'Март'
        'Апрель'
        'Май'
        'Июнь'
        'Июль'
        'Август'
        'Сентябрь'
        'Октябрь'
        'Ноябрь'
        'Декабрь'
      ]
      firstDay: 1
    opens: 'left'
    applyClass: 'btn-small btn-primary btn-block'
    cancelClass: 'btn-small btn-default btn-block'
  }, (start, end) ->
    # Format date
    $('.daterange-ranges span').html start.format('D MMM YYYY') + ' - ' + end.format('D MMM YYYY')
    # get START and END date of datepicker from 'data-start' and 'data-end' HTML-attributes
    $('.datatables-datapicker').data 'start', start.format('YYYY-MM-DD HH:mm:ss')
    $('.datatables-datapicker').data 'end', end.format('YYYY-MM-DD HH:mm:ss')
    # redraw table after changing datepicker dates
    $('.datatable-leads').DataTable().draw()
    $('.datatable-contacts').DataTable().draw()
    return
  # Format date
  $('.daterange-ranges span').html moment().subtract('days', 29).format('D MMM YYYY') + ' - ' + moment().format('D MMM YYYY')
  return
