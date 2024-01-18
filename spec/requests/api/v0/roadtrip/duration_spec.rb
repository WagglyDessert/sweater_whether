require 'rails_helper'

describe "Roadtrip duration from start to end" do
  it "verifies api key for user to be able to get trip time between two locations", :vcr do
    user = User.create(email: "road@trip.com", password: "password", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
    params = {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
    post '/api/v0/road_trip', params: params

    expect(response).to be_successful
    expect(response.status).to eq(200)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:data]).to be_a(Hash)
    expect(response_body[:data]).to have_key(:id)
    expect(response_body[:data][:id]).to eq(nil)
    expect(response_body[:data]).to have_key(:type)
    expect(response_body[:data][:type]).to eq("roadtrip")
    expect(response_body[:data][:attributes]).to be_a(Hash)
    expect(response_body[:data][:attributes]).to have_key(:start_city)
    expect(response_body[:data][:attributes][:start_city]).to be_a(String)
    expect(response_body[:data][:attributes][:start_city]).to eq("Cincinatti, OH")
    expect(response_body[:data][:attributes]).to have_key(:end_city)
    expect(response_body[:data][:attributes][:end_city]).to be_a(String)
    expect(response_body[:data][:attributes][:end_city]).to eq("Chicago, IL")
    expect(response_body[:data][:attributes]).to have_key(:travel_time)
    expect(response_body[:data][:attributes][:travel_time]).to be_a(String)
    expect(response_body[:data][:attributes]).to have_key(:weather_at_eta)
    expect(response_body[:data][:attributes][:weather_at_eta]).to be_a(Hash)
    expect(response_body[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
    expect(response_body[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
    expect(response_body[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(response_body[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
    expect(response_body[:data][:attributes][:weather_at_eta]).to have_key(:condition)
    expect(response_body[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
  end

  it "returns error message when missing information in parameters" do
    user = User.create(email: "road@trip.com", password: "password", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
    params = {
      "origin": "",
      "destination": "Chicago,IL",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
    post '/api/v0/road_trip', params: params

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:error]).to be_a(Array)
    expect(response_body[:error].first[:status]).to eq("422")
    expect(response_body[:error].first[:detail]).to eq("Origin, destination, and api_key are required.")
  end

  it "returns error message if user doesn't exist with provided api_key" do
    user = User.create(email: "road@trip.com", password: "password", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
    params = {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": "x1h2i3s4_i5s6_l7e8g9i10t1x"
    }
    post '/api/v0/road_trip', params: params

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:error]).to be_a(Array)
    expect(response_body[:error].first[:status]).to eq("401")
    expect(response_body[:error].first[:detail]).to eq("Sorry, your credentials are bad.")
  end

  it "travels from nyc to la a day later", :vcr do
    user = User.create(email: "road@trip.com", password: "password", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
    params = {
      "origin": "nyc,NY",
      "destination": "LA,CA",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
    post '/api/v0/road_trip', params: params

    expect(response).to be_successful
    expect(response.status).to eq(200)
    response_body = JSON.parse(response.body, symbolize_names: true)
  end

  it "cannot travel from nyc to London", :vcr do
    user = User.create(email: "road@trip.com", password: "password", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
    params = {
      "origin": "nyc,NY",
      "destination": "London,UK",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
    post '/api/v0/road_trip', params: params

    expect(response).to be_successful
    expect(response.status).to eq(200)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:data][:id]).to eq(nil)
    expect(response_body[:data][:type]).to eq("roadtrip")
    expect(response_body[:data][:attributes][:start_city]).to eq("nyc, NY")
    expect(response_body[:data][:attributes][:end_city]).to eq("London, UK")
    expect(response_body[:data][:attributes][:travel_time]).to eq("impossible")
    expect(response_body[:data][:attributes][:weather_at_eta]).to be_a Hash
    expect(response_body[:data][:attributes][:weather_at_eta]).to eq({})
  end
end