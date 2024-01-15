class WeatherFacade
  #init
  def initialize
    @service = WeatherService.new
  end

  def find_weather(lat, lon)
    response = @service.find_weather(lat, lon)
    #want to return ruby objects
    data = JSON.parse(response.body, symbolize_names: true)

    #make a Poro
    Weather.new(data)
  end
end