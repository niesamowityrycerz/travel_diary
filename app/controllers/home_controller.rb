class HomeController < ApplicationController

  #before_action :authenticate_user!

  def index 
    if current_user 
      @greetings = { "welcome": "Hello #{current_user.username}" }
    else 
      @greetings = { "welcome": "This is Traveler Dairy" }
    end 
    respond_to do |format|  
      format.html 
      format.json { render json: @greetings }
    end
  end
end
