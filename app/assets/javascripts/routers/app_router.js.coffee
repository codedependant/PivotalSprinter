class Sprinter.Routers.App extends Backbone.Router
  routes:
    '': 'index'  

  initialize: ->


  index: ->
    console.log @s
    v = new Sprinter.Views.AppView()
    v.render()
