class WeatherCallService 
  def initialize(params)
    @city = params[:city]
    @api_key = Rails.application.credentials.dig(:open_weather_api, :api_key)
    @celsius = 'metric'
  end

  attr_reader :celsius, :api_key

  def valid_city?(city)
    
  end

  def call_weather
    get_weather(@city)
  end

  private 

  def get_weather(city)
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{city}&units=#{celsius}&appid=#{api_key}"
    response = HTTParty.get(url)
  end
end
