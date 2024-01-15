class WeatherService 
  def conn
    conn = Faraday.new("http://api.weatherapi.com/v1") do |faraday| #base url
      faraday.params["key"] = Rails.application.credentials.weather[:key]
    end
  end

  def find_weather(lat, lon)
    response = conn.get("forecast.json?&q=#{lat},#{lon}&days=5&aqi=no&alerts=no")
  end

end