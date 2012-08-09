class Sprinter.Views.UserView extends Backbone.View
  template: HoganTemplates['standup/user']
  el: ".standup_view"

  events: {
    'click li' : 'show_story'
  }

  initialize: (options) ->
    console.log options
    @parentView = options.parentView

  render: () ->
    html = @template.render({stories:@collection.toJSON(),points:@collection.points()})
    this.$el.hide().html(html).fadeIn(300)
    this


  show_story: (event) =>
    event.preventDefault()
    @parentView.show_story(event)