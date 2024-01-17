require 'date'
class Roadtrip
  attr_reader :id,
              :type,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta



  def initialize(roadtrip_data, weather_data, destination, origin)
    @id = nil
    @type = "road_trip"
    @start_city = origin.split(',').join(', ')
    @end_city = destination.split(',').join(', ')
    @travel_time = roadtrip_data[:route][:legs].first[:formattedTime]
    calculated_datetime = calculate_travel_time(@travel_time, weather_data)
    @weather_at_eta = {
      datetime: calculated_datetime,
      temperature: find_destination_forecast(calculated_datetime, weather_data),
      condition: eta_condition(calculated_datetime, weather_data)
    }
  end

  def calculate_travel_time(travel_time, weather_data)
    travel_time_obj = DateTime.parse(travel_time)
    current_time_obj = DateTime.parse(weather_data[:location][:localtime])
    result_datetime = current_time_obj + Rational(travel_time_obj.hour * 3600 + travel_time_obj.min * 60 + travel_time_obj.sec, 86400)
    formatted_result = result_datetime.strftime("%Y-%m-%d %H:%M")
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