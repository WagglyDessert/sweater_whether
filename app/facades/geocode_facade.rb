class GeocodeFacade
  #init
  def initialize
    @service = GeocodeService.new
  end

  def find_lat_lon(city, state)
    response = @service.parks_per_state(state_code)
    #want to return ruby objects
    data = JSON.parse(response.body, symbolize_names: true)

    #require 'pry'; binding.pry
    #make a Poro
    data[:data].map do |d|
      Park.new(d)
    end
  end
end