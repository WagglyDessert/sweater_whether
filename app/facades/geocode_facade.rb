class GeocodeFacade
  def initialize
    @service = GeocodeService.new
  end

  def find_lat_lon(location)
    response = @service.find_lat_lon(location)
    data = JSON.parse(response.body, symbolize_names: true)
    data[:results].first[:locations].map do |g|
      Geocode.new(g)
    end
  end
end