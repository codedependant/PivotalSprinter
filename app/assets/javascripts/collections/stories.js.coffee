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
      calcPoints= (prev,cur,state) ->
        if cur.get("current_state") == state then cur.get("estimate") + prev[state] else prev[state]


      if cur.get("estimate")
        return_obj =
          total : prev.total + cur.get("estimate")
          started : calcPoints(prev,cur,"started")
          unstarted : calcPoints(prev,cur,"unstarted")
          accepted : calcPoints(prev,cur,"accepted")
          finished : calcPoints(prev,cur,"finished")
      else
        prev

    ,{total:0,started:0,unstarted:0,accepted:0,finished:0})    