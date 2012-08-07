class StoryController < ApplicationController

  before_filter :pt_sign_in

  def pt_sign_in
    begin
      PivotalTracker::Client.connection
    rescue PivotalTracker::Client::NoToken
      #PivotalTracker::Client.token('shayarealg@gmail.com', 'g3mini1')  
      session[:signed_in] = true
    end
  end

  def index
    @project = PivotalTracker::Project.find(params[:project_id])
    puts @project.inspect
    begin
      @stories = PivotalTracker::Iteration.current(@project)
    rescue
      @stories = []
    end
    render json: @stories 
  end

  def show
    @project = PivotalTracker::Project.find(params[:project_id])
    @story = @project.stories.find(params[:id])
    task_arr = @story.tasks.all().map { |task| task.description }
    @story.task_arr = task_arr
    render json: @story
  end

end


class PivotalTracker::Story
  attr_accessor :task_arr
end