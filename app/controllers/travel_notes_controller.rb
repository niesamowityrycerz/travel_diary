class TravelNotesController < ApplicationController

  before_action :authenticate_user!

  def index
    @travel_notes = current_user.travel_notes 
    respond_to do |format|
      format.html #travel_note.html.erb
      format.json { render json: @travel_notes }
    end
  end

  def create
    api_key = Rails.application.credentials.dig(:open_weather_api, :api_key)
    celsius = 'metric'
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{travel_note_params[:city]}&units=#{celsius}&appid=#{api_key}"
    response = HTTParty.get(url)
    binding.pry 
    current_temperature = response["main"]["temp"]


    params = travel_note_params.merge({
      current_temperature: current_temperature
    })

    @travel_note = current_user.travel_notes.new(params)
    if @travel_note.save
      render :index
    else 
      redirect_to root_path 
    end
  end

  private 

  def travel_note_params
    # check if without :current_temperature it works 
    # params.require(:travel_note).permit(:body, :city)
    params.require(:travel_note).permit(:body, :city, :current_temperature)
  end

end
