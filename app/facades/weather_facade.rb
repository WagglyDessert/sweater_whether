class WeatherFacade
  def initialize
    @service = WeatherService.new
  end

  def find_weather(lat, lon)
    response = @service.find_weather(lat, lon)
    data = JSON.parse(response.body, symbolize_names: true)
    Weather.new(data)
  end
end