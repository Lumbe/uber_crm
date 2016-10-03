# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#notification-link").click ->
    $.ajax({
      type: "POST",
      url: "/notifications/mark_as_read",
      success: ->
        $("#notifications-counter").hide()
    })