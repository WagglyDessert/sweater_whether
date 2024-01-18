require 'date'
class Roadtrip
  attr_reader :id,
              :type,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta



  def initialize(travel_time, weather_at_eta, destination, origin)
    @id = nil
    @type = "road_trip"
    @start_city = origin.split(',').join(', ')
    @end_city = destination.split(',').join(', ')
    @travel_time = travel_time
    @weather_at_eta = weather_at_eta
  end

end