class Sprinter.Views.AppView extends Backbone.View
  el: "#container"
  template: HoganTemplates['app']


  events: {
    'click ul#story_list.nav-list li' : 'show_story'
    'click ul#user_list.nav-list li' : 'filter_by_user'
  }

  initialize: () ->
    data = $("#data_backup").data('stories')
    console.log(data)
    @collection = new Sprinter.Collections.Stories(data.stories)
    @collection.start = data.start
    @collection.finish = data.finish
    @collection.number = data.number

    #@collection.on("reset",@render_story_list)
    #@collection.fetch()

  render: () ->
    console.log this.model
    html = @template.render()
    

    this.$el.hide().html(html).fadeIn(300)
    @render_story_list()
    this

  render_story_list: () =>
    users = @collection.map((story) -> if story.get("owned_by") then story.get("owned_by") else "Unassigned" )
    users = _.uniq(users)
    
    console.log users
    this.$(".sidebar-nav").html(HoganTemplates['standup/story_list'].render({stories: @collection.toJSON(),users:users}) )
    days = Math.floor(((new Date(@collection.finish)).getTime() - (new Date()).getTime()) / 86400000 )
    sum = @collection.reduce( (prev,cur) -> 
      return_obj =
        total : prev.total + cur.get("estimate")
        started : if cur.get("current_state") == "started" then cur.get("estimate") else 0
        unstarted : if cur.get("current_state") == "unstarted" then cur.get("estimate") else 0
        complete : if cur.get("current_state") == "complete" then cur.get("estimate") else 0
    ,{total:0,started:0,unstarted:0,complete:0})


    this.$(".sprintEnd").html("#{days} Days Left")
    this.$(".sprintNumber").html("Sprint number: #{@collection.number}")
    this.$(".sprintPoints").html("#{sum.total} / #{sum.unstarted} / #{sum.complete} / #{sum.started}")

  show_story: (event) =>
    event.preventDefault()
    id = $(event.currentTarget).data('pk-story-id')
    console.log id
    story = @collection.get(id)
    console.log story
    this.$(".story").html(HoganTemplates['standup/story'].render(story.toJSON()))

  filter_by_user: (event) =>

    this.$("#user_list.nav-list li").removeClass("active")
    $(event.currentTarget).addClass("active")

    user =  $(event.currentTarget).text().trim()
    user = null if user == "Unassigned"

    this.$("#story_list.nav-list li").hide()
    _.each(@collection.where({owned_by: user}),(story) ->
      this.$("#story_list.nav-list li[data-pk-story-id='#{story.id}']").show()
    )


    this.$(".story").html("Clicked on user #{user}")


