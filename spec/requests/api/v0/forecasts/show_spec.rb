require 'rails_helper'

describe "Forecast geocode and mapquest API Endpoint" do
  it "send weather about a specific location", :vcr do
    get '/api/v0/forecast?location=cincinatti,oh'
    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    binding.pry
    third_spaces = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(third_spaces.count).to eq(5)

    third_spaces.each do |space|
      expect(space).to have_key(:id)

      expect(space).to have_key(:type)
      expect(space[:type]).to be_a(String)
    end
  end

end