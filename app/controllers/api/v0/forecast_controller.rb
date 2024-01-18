class Api::V0::ForecastController < ApplicationController

  def location
    location = params[:location]
    @geocode_facade = GeocodeFacade.new.find_lat_lon(location)
    lat = @geocode_facade.first.lat.round(5)
    lon = @geocode_facade.first.lon.round(5)
    weather(lat, lon)
  end

  def weather(lat, lon)
    weather_facade = WeatherFacade.new.find_weather(lat, lon)
    render json: ForecastSerializer.new(weather_facade)
  end

end