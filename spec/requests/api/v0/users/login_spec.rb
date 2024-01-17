require 'rails_helper'

describe "Login User" do
  it "receives email and pw to login" do
    user = User.create(email: "what@ever.com", password: "password", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
    params = {
      "email": "what@ever.com",
      "password": "password",
    }
    post '/api/v0/sessions', params: params

    expect(response).to be_successful
    expect(response.status).to eq(201)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:data][:type]).to eq("users")
    expect(response_body[:data]).to have_key(:id)
    expect(response_body[:data][:attributes]).to be_a(Hash)
    expect(response_body[:data][:attributes]).to have_key(:email)
    expect(response_body[:data][:attributes]).to have_key(:api_key)
  end

  it "user doesn't exist provides error" do
    user = User.create(email: "what@ever.com", password: "password", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
    params = {
      "email": "why@never.com",
      "password": "password",
    }
    post '/api/v0/sessions', params: params

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:error]).to be_a(Array)
    expect(response_body[:error].first[:status]).to eq("422")
    expect(response_body[:error].first[:detail]).to eq("Sorry, your credentials are bad.")
  end

  it "bad password provides error" do
    user = User.create(email: "what@ever.com", password: "password", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
    params = {
      "email": "what@ever.com",
      "password": "wrongpassword",
    }
    post '/api/v0/sessions', params: params

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:error]).to be_a(Array)
    expect(response_body[:error].first[:status]).to eq("422")
    expect(response_body[:error].first[:detail]).to eq("Sorry, your credentials are bad.")
  end

end