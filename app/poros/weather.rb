class Weather
  attr_reader :id,
              :type,
              :last_updated,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :condition,
              :icon,
              :day1,
              :day1_sunrise,
              :day1_sunset,
              :day1_maxtemp,
              :day1_mintemp,
              :day1_condition,
              :day1_icon,



  def initialize(data)
    binding.pry
    @id = null
    @type = "forecast"
    #
    @last_updated = data[:current][:last_updated]
    @temperature = data[:current][:temp_f]
    @feels_like = data[:current][:feelslike_f]
    @humidity = data[:current][:humidity]
    @uvi = data[:current][:uv]
    @visibility = data[:current][:vis_miles]
    @condition = data[:current][:condition][:text]
    @icon = data[:current][:condition][:icon]
    #
    @day1 = data[:forecast][:forecastday].first[:date]
    @day1_sunrise = data[:forecast][:forecastday].first[:astro][:sunrise]
    @day1_sunset = data[:forecast][:forecastday].first[:astro][:sunset]
    @day1_maxtemp = data[:forecast][:forecastday].first[:day][:maxtemp_f]
    @day1_mintemp = data[:forecast][:forecastday].first[:day][:mintemp_f]
    @day1_condition = data[:forecast][:forecastday].first[:day][:condition][:text]
    @day1_icon = data[:forecast][:forecastday].first[:day][:condition][:icon]
  end
end