# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#general-notifications").on 'click', ->
    $.ajax
      type: "POST"
      url: "/notifications/mark_as_read"
      data:
        notification_type: 'general'
      success: ->
        $("#general-notifications-counter").hide()

  $("#message-notifications").on 'click', ->
    $.ajax
      type: "POST"
      url: "/notifications/mark_as_read"
      data:
        notification_type: 'message'
      success: ->
        $("#message-notifications-counter").hide()
