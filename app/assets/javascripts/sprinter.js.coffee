window.Sprinter =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new Sprinter.Routers.App()
    Backbone.history.start()


  
  