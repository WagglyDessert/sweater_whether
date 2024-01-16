require 'rails_helper'

describe GeocodeService do
  context "instance methods" do
    context "#geocode location" do
      it "connects", :vcr do
        service = GeocodeService.new 
        expect(service.conn).to be_instance_of Faraday::Connection
      end

      it "searches a specific endpoint with location", :vcr do
        location = "denver,co"
        search = GeocodeService.new.find_lat_lon(location)
        expect(search).to be_a Faraday::Response
      end
    end
  end
end