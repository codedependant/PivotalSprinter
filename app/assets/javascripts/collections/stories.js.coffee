class Sprinter.Collections.Stories extends Backbone.Collection
  url: '/project/306415/story'
  model: Sprinter.Models.Story

    

  parse: (response) ->
    @start = response.start
    @finish = response.finish
    @number = response.number
    response.stories


  points: () ->
    @.reduce( (prev,cur) -> 
      return_obj =
        total : prev.total + cur.get("estimate")
        started : if cur.get("current_state") == "started" then cur.get("estimate") else 0
        unstarted : if cur.get("current_state") == "unstarted" then cur.get("estimate") else 0
        completed : if cur.get("current_state") == "complete" then cur.get("estimate") else 0
    ,{total:0,started:0,unstarted:0,complete:0})    