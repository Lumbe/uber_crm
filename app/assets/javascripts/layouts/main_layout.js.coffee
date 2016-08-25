# Layout elements to use throughout application

# Sticky SIDEBAR with custom scrollbar
$ ->
  # Initialize
  # Mini sidebar
  # -------------------------
  # Setup

  miniSidebar = ->
    if $('body').hasClass('sidebar-xs')
      $('.sidebar-main.sidebar-fixed .sidebar-content').on('mouseenter', ->
        if $('body').hasClass('sidebar-xs')
          # Expand fixed navbar
          $('body').removeClass('sidebar-xs').addClass 'sidebar-fixed-expanded'
        return
      ).on 'mouseleave', ->
        if $('body').hasClass('sidebar-fixed-expanded')
          # Collapse fixed navbar
          $('body').removeClass('sidebar-fixed-expanded').addClass 'sidebar-xs'
        return
    return

  # Nice scroll
  # ------------------------------
  # Setup

  initScroll = ->
    $('.sidebar-fixed .sidebar-content').niceScroll
      mousescrollstep: 100
      cursorcolor: '#ccc'
      cursorborder: ''
      cursorwidth: 3
      hidecursordelay: 100
      autohidemode: 'scroll'
      horizrailenabled: false
      preservenativescrolling: false
      railpadding:
        right: 0.5
        top: 1.5
        bottom: 1.5
    return

  # Remove scroll on tablets and mobile

  removeScroll = ->
    $('.sidebar-fixed .sidebar-content').getNiceScroll().remove()
    $('.sidebar-fixed .sidebar-content').removeAttr('style').removeAttr 'tabindex'
    return

  miniSidebar()
  # Toggle mini sidebar
  $('.sidebar-main-toggle').on 'click', (e) ->
    # Initialize mini sidebar 
    miniSidebar()
    return
  # Initialize
  initScroll()
  # Remove scrollbar on mobile
  $(window).on('resize', ->
    setTimeout (->
      if $(window).width() <= 768
        # Remove nicescroll on mobiles
        removeScroll()
      else
        # Init scrollbar
        initScroll()
      return
    ), 100
    return
  ).resize()

  # JQuery UI BASIC TABS init
  # -------------------------------
  # Setup
  $('.jui-tabs-basic').tabs()

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
    $('.datatable-basic').DataTable().draw()
    return
  # Format date
  $('.daterange-ranges span').html moment().subtract('days', 29).format('D MMM YYYY') + ' - ' + moment().format('D MMM YYYY')
  return
