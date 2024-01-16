require "rails_helper"

RSpec.describe WeatherFacade do

  it "::search", :vcr do
    lat = 39.74204
    lon = -104.99153
    search_results = WeatherFacade.new.find_weather(lat, lon)
    expect(search_results).to be_a(Object)
    expect(search_results.current_weather).to be_a(Hash)
    expect(search_results.daily_weather).to be_a(Array)
    expect(search_results.hourly_weather).to be_a(Array)
  end
end