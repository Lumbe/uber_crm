# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # Primary file input
  $('.file-styled-primary').uniform
    fileButtonClass: 'action btn bg-green-600'
    fileDefaultText: 'Файл не выбран'
    fileBtnText: 'Выберите файл'
