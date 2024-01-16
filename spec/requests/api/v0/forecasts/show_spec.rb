require 'rails_helper'

#Testing should look for more than just the presence of attribute fields in the response. 
#Testing should also determine which fields should NOT be present. (don’t send unnecessary data)

describe "Forecast geocode and mapquest API Endpoint" do
  it "send weather about a specific location", :vcr do
    get '/api/v0/forecast?location=cincinatti,oh'
    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    forecast = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(forecast[:id]).to eq(nil)
    expect(forecast[:type]).to eq("forecast")

    expect(forecast[:attributes][:current_weather]).to have_key(:last_updated)
    expect(forecast[:attributes][:current_weather]).to have_key(:temperature)
    expect(forecast[:attributes][:current_weather]).to have_key(:feels_like)
    expect(forecast[:attributes][:current_weather]).to have_key(:humidity)
    expect(forecast[:attributes][:current_weather]).to have_key(:uvi)
    expect(forecast[:attributes][:current_weather]).to have_key(:visibility)
    expect(forecast[:attributes][:current_weather]).to have_key(:condition)
    expect(forecast[:attributes][:current_weather]).to have_key(:icon)
    expect(forecast[:attributes][:current_weather]).to be_a(Hash)

    expect(forecast[:attributes][:daily_weather]).to be_a(Array)
    forecast[:attributes][:daily_weather].each do |d|
      binding.pry
      expect(d).to have_key(:date)
      expect(d).to have_key(:sunrise)
      expect(d).to have_key(:sunset)
      expect(d).to have_key(:max_temp)
      expect(d).to have_key(:min_temp)
      expect(d).to have_key(:condition)
      expect(d).to have_key(:icon)
      expect(d).to be_a(Hash)
    end

    expect(forecast[:attributes][:hourly_weather]).to be_a(Array)
    forecast[:attributes][:hourly_weather].each do |h|
      binding.pry
      expect(h).to have_key(:time)
      expect(h).to have_key(:temp)
      expect(h).to have_key(:condition)
      expect(h).to have_key(:icon)
      expect(h).to be_a(Hash)
    end

  end
  #include a test for what the serializer does NOT include
end