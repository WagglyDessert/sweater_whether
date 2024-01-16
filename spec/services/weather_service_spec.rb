require 'rails_helper'

describe WeatherService do
  context "instance methods" do
    context "#weather location" do
      it "connects", :vcr do
        service = WeatherService.new 
        expect(service.conn).to be_instance_of Faraday::Connection
      end

      it "searches a specific endpoint with lat and lon", :vcr do
        lat = 39.74204
        lon = -104.99153
        search = WeatherService.new.find_weather(lat, lon)
        expect(search).to be_a Faraday::Response
      end
    end
  end
end