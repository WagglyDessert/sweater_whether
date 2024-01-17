require "rails_helper"

RSpec.describe RoadtripFacade do

  it "::search", :vcr do
    destination = "Boulder,CO"
    origin = "Denver,CO"
    search_results = RoadtripFacade.new.duration(destination, origin)
    expect(search_results).to be_a(Object)
    expect(search_results.id).to eq(nil)
    expect(search_results.type).to be_a(String)
    expect(search_results.start_city).to be_a(String)
    expect(search_results.end_city).to be_a(String)
    expect(search_results.travel_time).to be_a(String)
    expect(search_results.weather_at_eta).to be_a(Hash)
  end
end