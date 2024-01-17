require 'rails_helper'

describe RoadtripService do
  context "instance methods" do
    context "#roadtrip duration" do
      it "connects", :vcr do
        service = RoadtripService.new 
        expect(service.conn).to be_instance_of Faraday::Connection
      end

      it "searches a specific endpoint with origin and destination", :vcr do
        origin = "Denver,CO"
        destination = "Boulder,CO"
        search = RoadtripService.new.duration(destination, origin)
        expect(search).to be_a Faraday::Response
      end
    end
  end
end