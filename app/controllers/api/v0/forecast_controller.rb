class Api::V0::ForecastController < ApplicationController

  def show
    #GET /api/v0/forecast?location=cincinatti,oh
    #so fe routes to api/v0/forecast controller
    #{?location=cincinatti,oh} are params
    location = params[:location]
    # l_split = location.split(',')
    # state =  l_split.last
    # city = l_split.first
    #binding.pry
    @geocode_facade = GeocodeFacade.new.find_lat_lon(location)
    binding.pry
    lat = @geocode_facade.first.lat
    lon = @geocode_facade.first.lon
    ## get back lat and lon for mq facade
    @weather_facade = WeatherFacade.new.find_weather(lat, lon)
  end

end

#http://api.weatherapi.com/v1/forecast.json?key=key&q=latlon&days=5&aqi=no&alerts=no
#weather key

#https://www.mapquestapi.com/geocoding/v1/address
#mapquest key

