class Api::V0::ForecastController < ApplicationController

  def location
    #GET /api/v0/forecast?location=cincinatti,oh
    #so fe routes to api/v0/forecast controller
    #{?location=cincinatti,oh} are params
    location = params[:location]
    # l_split = location.split(',')
    # state =  l_split.last
    # city = l_split.first
    #binding.pry
    @geocode_facade = GeocodeFacade.new.find_lat_lon(location)
    lat = @geocode_facade.first.lat.round(5)
    lon = @geocode_facade.first.lon.round(5)
    ## get back lat and lon for mq facade
    #@weather_facade = WeatherFacade.new.find_weather(lat, lon)
    weather(lat, lon)
  end

  def weather(lat, lon)
    weather_facade = WeatherFacade.new.find_weather(lat, lon)
    render json: ForecastSerializer.new(weather_facade)
  end

end