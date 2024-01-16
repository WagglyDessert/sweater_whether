require 'rails_helper'

describe "Create User" do
  it "receives a hash, checks pw and pw confirmation, stores digest pw, and creates secure api_key" do
    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post '/api/v0/users', params: params

    expect(response).to be_successful
    expect(response.status).to eq(201)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:data]).to be_a(Hash)
    expect(response_body[:data][:type]).to eq("users")
    expect(response_body[:data]).to have_key(:id)
    expect(response_body[:data][:attributes]).to be_a(Hash)
    expect(response_body[:data][:attributes]).to have_key(:email)
    expect(response_body[:data][:attributes]).to have_key(:api_key)
  end

  it "provides an error when missing a pw, pw confirmation, or email field" do
    params = {
      "email": "",
      "password": "password",
      "password_confirmation": "password"
    }
    post '/api/v0/users', params: params

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:error]).to be_a(Array)
    expect(response_body[:error].first[:status]).to eq("422")
    expect(response_body[:error].first[:detail]).to eq("Email, password, and password confirmation are required.")

  end

  it "provides an error if pw and pw confirmation don't match" do
    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "notpassword"
    }
    post '/api/v0/users', params: params

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to be_a(Hash)
    expect(response_body[:error]).to be_a(Array)
    expect(response_body[:error].first[:status]).to eq("422")
    expect(response_body[:error].first[:detail]).to eq("Password and password confirmation do not match.")
  end

  it "returns error if email already exists" do
    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post '/api/v0/users', params: params

    expect(response).to be_successful
    expect(response.status).to eq(201)
    post '/api/v0/users', params: params
    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body[:error].first[:detail]).to eq("Email already exists.")
    end
end