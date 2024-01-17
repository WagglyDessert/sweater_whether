require "rails_helper"

RSpec.describe Roadtrip do
  it "exists" do
    json_data_weather = File.read("spec/fixtures/denver_weather.json")
    json_data_roadtrip = File.read("spec/fixtures/denver_to_boulder.json")
    weather_data = JSON.parse(json_data_weather, symbolize_names: true)
    roadtrip_data = JSON.parse(json_data_roadtrip, symbolize_names: true)
    destination = "Boulder,CO"
    origin = "Denver,CO"

    search = Roadtrip.new(roadtrip_data, weather_data, destination, origin)

    expect(search).to be_a Roadtrip
    expect(search.id).to eq(nil)
    expect(search.type).to eq("road_trip")
    expect(search.start_city).to eq("Denver, CO")
    expect(search.end_city).to eq("Boulder, CO")
    expect(search.travel_time).to be_a(String)
    expect(search.weather_at_eta).to be_a(Hash)
    expect(search.weather_at_eta).to have_key(:datetime)
    expect(search.weather_at_eta[:datetime]).to be_a(String)
    expect(search.weather_at_eta).to have_key(:temperature)
    expect(search.weather_at_eta[:temperature]).to be_a(Float)
    expect(search.weather_at_eta).to have_key(:condition)
    expect(search.weather_at_eta[:condition]).to be_a(String)
  end
end