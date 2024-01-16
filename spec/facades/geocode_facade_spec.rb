require "rails_helper"

RSpec.describe GeocodeFacade do

  it "::search", :vcr do
    location = "denver,co"
    search_results = GeocodeFacade.new.find_lat_lon(location)
    expect(search_results).to be_a(Array)
    expect(search_results.first.lat).to be_a(Float)
    expect(search_results.first.lon).to be_a(Float)
  end
end