class Sprinter.Collections.Stories extends Backbone.Collection
  url: '/project/306415/story'
  model: Sprinter.Models.Story

    

  parse: (response) ->
    @start = response.start
    @finish = response.finish
    @number = response.number
    response.stories