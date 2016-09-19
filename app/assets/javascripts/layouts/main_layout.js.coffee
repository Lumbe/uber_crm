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
  return