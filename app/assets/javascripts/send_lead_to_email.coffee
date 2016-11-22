$(document).on 'turbolinks:load', ->
  $('#send-mail-button-lev').on 'click', ->
    $('input#send_to_email').val $('#send-mail-button-lev').html()
  $('#send-mail-button-ysg').on 'click', ->
    $('input#send_to_email').val $('#send-mail-button-ysg').html()
    return