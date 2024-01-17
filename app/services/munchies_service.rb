class MunchiesService 
  def conn
    Faraday.new(url: "https://api.yelp.com/v3/businesses/search") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.yelp[:key]
    end
  end

  def find_munchies(destination, food)
    response = conn.get("?location=#{destination}&term=#{food}&sort_by=best_match")
  end
end