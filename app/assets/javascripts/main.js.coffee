# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  Sprinter.init()
  $(".testrangeselector").selectRange 6, 15

$.fn.selectRange = (start, end) ->
  @each ->
    if @setSelectionRange
      @focus()
      @setSelectionRange start, end
    else if @createTextRange
      range = @createTextRange()
      range.collapse true
      range.moveEnd "character", end
      range.moveStart "character", start
      range.select()


