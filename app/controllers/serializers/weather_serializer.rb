class WeatherSerializer
  include JSONAPI::Serializer
  def self.serialize(weather)
    {
      data: {
        id: weather.id,
        type: weather.type,
        attributes: {
          current_weather: {
            last_updated: weather.last_updated,
            temperature: weather.temperature,
            # other attributes for current_weather
          },
          daily_weather: weather.daily_weather.map { |daily|
            {
              date: daily.date,
              sunrise: daily.sunrise,
              # other attributes for daily weather
            }
          },
          hourly_weather: weather.hourly_weather.map { |hourly|
            {
              time: hourly.time,
              temperature: hourly.temperature,
              # other attributes for hourly weather
            }
          }
        }
      }
    }
  end
end