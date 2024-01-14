class GeocodeFacade
  #init
  def initialize
    @service = GeocodeService.new
  end

  def find_lat_lon(location)
    response = @service.find_lat_lon(location)
    #want to return ruby objects
    data = JSON.parse(response.body, symbolize_names: true)

    #make a Poro
    #require 'pry'; binding.pry
    data[:results].first[:locations].map do |g|
      Geocode.new(g)
    end
  end
end