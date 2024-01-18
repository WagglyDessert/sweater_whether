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
      travel_time = "impossible"
      weather_at_eta = {}
    else
      travel_time = roadtrip_data[:route][:legs].first[:formattedTime]
      calculated_datetime = calculate_travel_time(travel_time, weather_data)
      temperature = find_destination_forecast(calculated_datetime, weather_data)
      condition =  eta_condition(calculated_datetime, weather_data)
      weather_at_eta = {
        datetime: calculated_datetime,
        temperature: temperature,
        condition: condition
      }
    end
    Roadtrip.new(travel_time, weather_at_eta, destination, origin)
  end

  def calculate_travel_time(travel_time, weather_data)
    hours, minutes, seconds = travel_time.split(':').map(&:to_i)
    total_seconds = hours * 3600 + minutes * 60 + seconds
    travel_duration = total_seconds.seconds
    current_time_obj = DateTime.parse(weather_data[:location][:localtime])
    end_date = current_time_obj + travel_duration
    formatted_result = end_date.strftime("%Y-%m-%d %H:%M")
  end

  def find_destination_forecast(datetime, weather_data)
    date_time_obj = DateTime.parse(datetime)
    date_component = date_time_obj.strftime("%Y-%m-%d")
    time_component = (date_time_obj.strftime("%H").to_i).round
    formatted_time_component = format('%02d:00', time_component)
    rounded_datetime_str = "#{date_component} #{formatted_time_component}"
    weather_data[:forecast][:forecastday].each do |f|
      if f[:date] == date_component
        eta_hour = f[:hour].find { |hour| hour[:time] == rounded_datetime_str }
        @result = eta_hour[:temp_f]
        break
      end
    end
    @result
  end

  def eta_condition(datetime, weather_data)
    date_time_obj = DateTime.parse(datetime)
    date_component = date_time_obj.strftime("%Y-%m-%d")
    time_component = (date_time_obj.strftime("%H").to_i).round
    formatted_time_component = format('%02d:00', time_component)
    rounded_datetime_str = "#{date_component} #{formatted_time_component}"
    weather_data[:forecast][:forecastday].each do |f|
      if f[:date] == date_component
        eta_condition = f[:hour].find { |hour| hour[:time] == rounded_datetime_str }
        @result = eta_condition[:condition][:text]
      end
    end
    @result
  end
end