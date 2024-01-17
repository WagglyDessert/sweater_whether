require "rails_helper"

RSpec.describe Munchie do
  it "exists" do
    destination = "denver,co"
    weather_json_data = File.read("spec/fixtures/denver_weather.json")
    weather_attrs = JSON.parse(weather_json_data, symbolize_names: true)
    munchie_json_data = File.read("spec/fixtures/denver_thai_restaurant_yelp.json")
    munchie_attrs = JSON.parse(munchie_json_data, symbolize_names: true)

    search = Munchie.new(destination, munchie_attrs, weather_attrs)

    expect(search).to be_a Munchie
    expect(search.id).to eq(nil)
    expect(search.type).to eq("munchie")
    expect(search.destination_city).to eq("Denver, CO")
    expect(search.forecast).to eq({:summary=>"Partly cloudy", :temperature=>15.3})
    expect(search.restaurant).to eq({:name=>"Aloy Modern Thai", :address=>"2134 Larimer St, Denver, CO 80205", :rating=>4.5, :reviews=>763})
  end
end