# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  Sprinter.init()



  $(document).scroll ->
    if($(this).scrollTop() > 100)
      $(".story").css('top',60)
      $(".story").css('position','fixed')
      #$(".story").css('top',$(this).scrollTop()+40)
    else
      $(".story").css('top',100)
      $(".story").css('position','relatve')