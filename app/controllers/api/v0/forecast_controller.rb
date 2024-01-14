class Api::V0::ForecastController < ApplicationController

  def show
    #GET /api/v0/forecast?location=cincinatti,oh
    #so fe routes to api/v0/forecast controller
    #?location=cincinatti,oh are params
    location = params[:location]
    l_split = location.split(',')
    state =  l_split.last
    city = l_split.first
    #binding.pry
    @geocode_facade = GeocodeFacade.new.find_lat_lon(city, state)
    ## get back lat and lon for mq facade
    @mapquest_facade = MapquestFacade.new.find_weather(lat, lon)
  end

end

#http://api.weatherapi.com/v1/forecast.json?key=key&q=latlon&days=5&aqi=no&alerts=no

#https://www.mapquestapi.com/geocoding/v1/address

