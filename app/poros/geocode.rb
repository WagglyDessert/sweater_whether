class Geocode
  attr_reader :lat, :lon

  def initialize(data)
    @lat = data[:latLng][:lat]
    @lon = data[:latLng][:lng]
  end
end