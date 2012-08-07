class MainController < ApplicationController
  


  def index
    #PivotalTracker::Client.token('shayarealg@gmail.com', 'g3mini1')  
    #@projects = PivotalTracker::Project.all
    #puts @projects.inspect
    if !session.has_key?('signed_in') or !session[:signed_in]
      redirect_to :action => 'sign_in'
    end
      

  end

  def sign_in

  end

  def sign_user_in
    begin
      session[:signed_in] = true
      session[:username] = params[:username]
      session[:password] = params[:password]
      PivotalTracker::Client.token(session[:username], session[:password])  
      redirect_to :action => 'index'
    rescue RestClient::Unauthorized
      redirect_to({:action => 'sign_in'},:flash => { :error => "Insufficient rights!" })
    end
  end

  def sign_user_out
      session[:signed_in] = false
      session[:username] = nil
      session[:password] = nil
      redirect_to({:action => 'sign_in'},:flash => { :error => "signed out!" })
  end



end
