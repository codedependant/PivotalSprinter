class MainController < ApplicationController
  
  before_filter :pt_sign_in
  
  def pt_sign_in
    begin
      PivotalTracker::Client.connection
    rescue PivotalTracker::Client::NoToken
      PivotalTracker::Client.token(session[:username], session[:password])  
      session[:signed_in] = true
    end
  end

  def index
    #PivotalTracker::Client.token('shayarealg@gmail.com', 'g3mini1')  
    #@projects = PivotalTracker::Project.all
    #puts @projects.inspect
    if !session[:signed_in]
      redirect_to :action => 'sign_in'
    end
      

  end

  def sign_in

  end

  def sign_user_in
    begin
      PivotalTracker::Client.token(params[:username], params[:password])  
      session[:signed_in] = true
      session[:username] = params[:username]
      session[:password] = params[:password]
      redirect_to :action => 'index'
    rescue RestClient::Unauthorized
      redirect_to({:action => 'sign_in'},:flash => { :error => "Insufficient rights!" })
    end

  end



end
