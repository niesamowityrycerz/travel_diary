class TravelNotesController < ApplicationController

  before_action :authenticate_user!

  def index
    @travel_notes = current_user.travel_notes.order('created_at DESC').page(params[:page] || 0)
    respond_to do |format|
      format.html #travel_note.html.erb
      format.json { render json: @travel_notes }
    end
  end

  def create
    # TODO -> error handling
    api_key = Rails.application.credentials.dig(:open_weather_api, :api_key)
    celsius = 'metric'
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{travel_note_params[:city]}&units=#{celsius}&appid=#{api_key}"
    response = HTTParty.get(url)
    current_temperature = response["main"]["temp"]


    params = travel_note_params.merge({
      current_temperature: current_temperature
    })

    @travel_note = current_user.travel_notes.new(params)
    respond_to do |format|
      if @travel_note.save
        format.js 
        format.html  { redirect_to @travel_note }
        #format.json { render :show }
      else 
        format.html  { redirect_to @travel_note }
        #format.json { render json: @travel_note.errors } 
      end
    end 
  end

  def show 
    @travel_note = TravelNote.find_by(id: params[:id])
  end

  def destroy
    @travel_note = TravelNote.find_by(id: params[:id])

    respond_to do |format|
      if @travel_note.destroy
        format.js 
        format.html { render :index }
      else 
        format.html { redirect_to root_url }
      end
    end 
  end

  private 

  def travel_note_params
    # check if without :current_temperature it works 
    # params.require(:travel_note).permit(:body, :city)
    params.require(:travel_note).permit(:body, :city, :current_temperature)
  end

end
