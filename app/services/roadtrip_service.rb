class RoadtripService 
  def conn
    conn = Faraday.new("https://www.mapquestapi.com/directions/v2/route") do |faraday| #base url
      faraday.params["key"] = Rails.application.credentials.mapquest[:key]
    end
  end

  def duration(destination, origin)
    response = conn.get("?from=#{destination}&to=#{origin}")
  end

end
