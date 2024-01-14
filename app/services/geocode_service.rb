class GeocodeService 
  def conn
    conn = Faraday.new("https://www.mapquestapi.com/geocoding/v1") do |faraday| #base url
      faraday.params["key"] = Rails.application.credentials.mapquest[:key]
    end
  end

  def find_lat_lon(location)
    response = conn.get("address?location=#{location}")
  end

end