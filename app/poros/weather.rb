class Weather
  attr_reader :id,
              :type,
              :current_weather,
              :daily_weather,
              :hourly_weather



  def initialize(data)
    @id = nil
    @type = "forecast"
    @daily_weather = []
    @hourly_weather = []

    current_data = data[:current]
    @current_weather = {
      last_updated: current_data[:last_updated],
      temperature: current_data[:temp_f],
      feels_like: current_data[:feelslike_f],
      humidity: current_data[:humidity],
      uvi: current_data[:uv],
      visibility: current_data[:vis_miles],
      condition: current_data[:condition][:text],
      icon: current_data[:condition][:icon]
    }
    
    daily_forecast_data = data[:forecast][:forecastday]
    daily_forecast_data.first(5).each do |day_data|
      @daily_weather << {
        date: day_data[:date],
        sunrise: day_data[:astro][:sunrise],
        sunset: day_data[:astro][:sunset],
        max_temp: day_data[:day][:maxtemp_f],
        min_temp: day_data[:day][:mintemp_f],
        condition: day_data[:day][:condition][:text],
        icon: day_data[:day][:condition][:icon]
      }
    end

    hourly_forecast_data = data[:forecast][:forecastday][0][:hour]
    hourly_forecast_data.each do |hour_data|
      @hourly_weather << {
        time: hour_data[:time].last(5),
        temp: hour_data[:temp_f],
        condition: hour_data[:condition][:text],
        icon: hour_data[:condition][:icon]
      }
    end
    
  end
  
end