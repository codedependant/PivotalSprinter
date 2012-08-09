class Sprinter.Views.AppView extends Backbone.View
  el: "#container"
  template: HoganTemplates['app']


  events: {
    'click ul.story_list.nav-list li:not(".nav-header"):not(".nav-header"):not(".nav-search")' : 'show_story'
    'click ul.user_list.nav-list li:not(".nav-header"):not(".nav-search")' : 'show_user'
    'keyup ul.story_list.nav-list li.nav-search input' : 'filter_stories'
  }

  initialize: () ->
    data = $("#data_backup").data('stories')
    console.log(data)
    @collection = new Sprinter.Collections.Stories(data.stories)
    @collection.start = data.start
    @collection.finish = data.finish
    @collection.number = data.number

    @collection.on("reset",@render_story_list)
    @collection.fetch()

  render: () ->
    console.log this.model
    html = @template.render()
    this.$el.hide().html(html).fadeIn(300)
    this

  render_story_list: () =>
    users = @collection.map((story) -> if story.get("owned_by") then story.get("owned_by") else "Unassigned" )
    users = _.uniq(users)
    
    this.$(".sidebar-nav").html(HoganTemplates['standup/story_list'].render({stories: @collection.toJSON(),users:users}) )
    days = Math.floor(((new Date(@collection.finish)).getTime() - (new Date()).getTime()) / 86400000 )
    points = @collection.points()


    this.$(".sprintEnd").html("#{days} Days Left")
    this.$(".sprintNumber").html("Sprint number: #{@collection.number}")
    this.$(".sprintPoints").html("#{points.total} / #{points.unstarted} / #{points.completed} / #{points.started}")

  show_story: (event) =>
    event.preventDefault()
    this.$('.story_list.nav-list li.nav-search input').val("")

    
    this.$(".story_list.nav-list li").removeClass("active")

    id = $(event.currentTarget).data('pk-story-id')
    this.$(".story_list.nav-list li[data-pk-story-id=#{id}]").addClass("active")
    story = @collection.get(id)
    this.$(".standup_view").html(HoganTemplates['standup/story'].render(story.toJSON()))

  show_user: (event) =>
    event.preventDefault()
    this.$('.story_list.nav-list li.nav-search input').val("")


    this.$(".user_list.nav-list li").removeClass("active")
    $(event.currentTarget).addClass("active")

    user =  $(event.currentTarget).text().trim()
    user = null if user == "Unassigned"
    users_stories = @collection.where({owned_by: user})
    
    this.$('.story_list.nav-list li:not(".nav-header"):not(".nav-search")').hide()
    _.each(@collection.where({owned_by: user}),(story) ->
      this.$(".story_list.nav-list li[data-pk-story-id='#{story.id}']").show()
    )
    user_stories_collection = new Sprinter.Collections.Stories(users_stories)
    points = user_stories_collection.points()
    user_view = new Sprinter.Views.UserView({model:{name:user},collection:user_stories_collection,parentView:this})
    user_view.render()

    


  filter_stories: (event) =>
    console.log event
    search_text = $(event.currentTarget).val()
    if search_text != ''
      this.$('.story_list.nav-list li:visible:not(".nav-header"):not(".nav-search")').filter((index) ->
        if $(this).text().toLowerCase().search(search_text) > 0
          $(this).show() 
        else 
          $(this).hide()
      )
    else
      this.$('.story_list.nav-list li').show()
