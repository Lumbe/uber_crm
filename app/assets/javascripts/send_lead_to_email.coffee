$(document).on 'turbolinks:load', ->
  $('.send-mail-button').on 'click', ->
    $('input#send_to_email').val $('.send-mail-button').html()
    return