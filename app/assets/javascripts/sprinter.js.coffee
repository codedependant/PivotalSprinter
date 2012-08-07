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
    console.log "dsfsfd"
    if($(this).scrollTop() > 100)
      $(".story").css('position','absolute')
      $(".story").css('top',$(this).scrollTop()+40)
    else
      $(".story").css('top',100)
      $(".story").css('position','absolute')
  
  