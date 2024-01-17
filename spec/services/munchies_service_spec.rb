require 'rails_helper'

describe MunchiesService do
  context "instance methods" do
    context "#weather location" do
      it "connects", :vcr do
        service = MunchiesService.new 
        expect(service.conn).to be_instance_of Faraday::Connection
      end

      it "searches a specific endpoint via destination and food", :vcr do
        destination = "denver,co"
        food = "thai"
        search = MunchiesService.new.find_munchies(destination, food)
        expect(search).to be_a Faraday::Response
      end
    end
  end
end