class RoadtripFacade  

  def duration(destination, origin)
    roadtrip = RoadtripService.new.duration(destination, origin)
    roadtrip_data = JSON.parse(roadtrip.body, symbolize_names: true)
    geocode = GeocodeService.new.find_lat_lon(destination)
    geocode_data = JSON.parse(geocode.body, symbolize_names: true)
    lat = geocode_data[:results].first[:locations].first[:latLng][:lat]
    lon = geocode_data[:results].first[:locations].first[:latLng][:lng]
    weather = WeatherService.new.find_weather(lat, lon) 
    weather_data = JSON.parse(weather.body, symbolize_names: true)
    if roadtrip_data[:route][:routeError].present?
      binding.pry
      roadtrip_data = "impossible"
      weather_data = {}
    end
    Roadtrip.new(roadtrip_data, weather_data, destination, origin)
  end
end