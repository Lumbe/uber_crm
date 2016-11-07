$ ->
  # DATE RANGE PICKER
  # ------------------------------
  # As a button
  # Setup
  $('.daterange-ranges').daterangepicker {
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
