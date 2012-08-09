class StoryController < ApplicationController
  before_filter :get_project
  
  def get_project
    begin
      @project = PivotalTracker::Project.find(params[:project_id])
    rescue
      PivotalTracker::Client.token(session[:username], session[:password])  
    end
  end

  def index
    begin
      @stories = PivotalTracker::Iteration.current(@project)
    rescue
      @stories = []
    end
    render json: @stories 
  end

  def show
    @story = @project.stories.find(params[:id])
    task_arr = @story.tasks.all().map { |task| task.description }
    @story.task_arr = task_arr
    render json: @story
  end

end


class PivotalTracker::Story
  attr_accessor :task_arr
end