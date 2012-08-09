window.Sprinter =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new Sprinter.Routers.App()
    Backbone.history.start()

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
  
  