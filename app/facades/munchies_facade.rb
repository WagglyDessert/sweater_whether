class MunchiesFacade

  def find_munchies(destination, food)
    munchies = MunchiesService.new.find_munchies(destination, food)
    geocode = GeocodeService.new.find_lat_lon(destination)
    geocode_data = JSON.parse(geocode.body, symbolize_names: true)
    lat = geocode_data[:results].first[:locations].first[:latLng][:lat]
    lon = geocode_data[:results].first[:locations].first[:latLng][:lng]
    weather = WeatherService.new.find_weather(lat, lon)
    #want to return ruby objects
    munchies_data = JSON.parse(munchies.body, symbolize_names: true)
    weather_data = JSON.parse(weather.body, symbolize_names: true)
    #make a Poro
    Munchie.new(destination, munchies_data, weather_data)
  end
end
