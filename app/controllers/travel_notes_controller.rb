class TravelNotesController < ApplicationController

  before_action :authenticate_user!
  before_action :call_city, only: [:create, :update]

  def index
    @travel_notes = current_user.travel_notes.order('created_at DESC').page(params[:page] || 0)
  end

  def create 
    params = travel_note_params.merge({
      current_temperature: @current_temperature
    })
    @travel_note = current_user.travel_notes.new(params)
    respond_to do |format|
      if @travel_note.save
        format.js 
        format.html  { redirect_to travel_notes_path, flash: { success: 'Travel note has been created!' } }
      else 
        format.html  { redirect_to travel_notes_path, flash: { error: @travel_note.errors.messages[:body].first } }
      end
    end   
  end

  def destroy
    @travel_note = current_user.travel_notes.find_by!(id: params[:id])

    respond_to do |format|
      if @travel_note.destroy
        format.js 
        format.html { render :index, flash: { info: 'Travel Note has been deleted!' } }
      else 
        format.html { redirect_to root_url }
      end
    end 
  end

  def edit
    @travel_note = current_user.travel_notes.find_by!(id: params[:id])
  end

  def update
    @travel_note = current_user.travel_notes.find_by(id: params[:id])

    @updated_note = @travel_note.update(
      {
        city: travel_note_params[:city],
        body: travel_note_params[:body],
        current_temperature: @current_temperature
      }.compact
    )

    if @updated_note
      redirect_to travel_notes_path, flash: { success: 'Travel note has been changed!' } 
    else 
      render :edit
    end
  end

  private 

  def travel_note_params
    params.require(:travel_note).permit(:body, :city, :current_temperature)
  end

  def call_city
    weather_api = ::WeatherCallService.new(travel_note_params).call_weather
    if weather_api.success?
      @current_temperature = weather_api["main"]["temp"]
    else
      redirect_to travel_notes_path, flash: { error: weather_api["message"] }
    end
  end
end
