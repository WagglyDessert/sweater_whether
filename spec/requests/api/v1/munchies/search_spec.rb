require 'rails_helper'

#Testing should look for more than just the presence of attribute fields in the response. 
#Testing should also determine which fields should NOT be present. (don’t send unnecessary data)

describe "Munchies and weather API Endpoint" do
  it "sends munchies data for specific location and food-type craving", :vcr do
    get '/api/v1/munchies?destination=pueblo,co&food=italian'
    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    munchie = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(munchie[:id]).to eq(nil)
    expect(munchie[:type]).to eq("munchie")
    expect(munchie[:attributes]).to be_a(Hash)
    expect(munchie[:attributes][:destination_city]).to eq("Pueblo, CO")
    expect(munchie[:attributes][:forecast]).to be_a(Hash)
    expect(munchie[:attributes][:forecast][:summary]).to be_a(String)
    expect(munchie[:attributes][:forecast][:temperature]).to be_a(Float)
    expect(munchie[:attributes][:restaurant]).to be_a(Hash)
    expect(munchie[:attributes][:restaurant][:name]).to be_a(String)
    expect(munchie[:attributes][:restaurant][:address]).to be_a(String)
    expect(munchie[:attributes][:restaurant][:rating]).to be_a(Float)
    expect(munchie[:attributes][:restaurant][:reviews]).to be_a(Integer)
  end
end