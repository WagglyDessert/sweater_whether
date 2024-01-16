require 'rails_helper'

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
      expect(h).to have_key(:time)
      expect(h).to have_key(:temp)
      expect(h).to have_key(:condition)
      expect(h).to have_key(:icon)
      expect(h).to be_a(Hash)
    end

  end
  it "does not include extranneous information", :vcr do
    get '/api/v0/forecast?location=cincinatti,oh'
    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    forecast = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(forecast[:attributes]).to_not have_key(:location)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:last_updated_epoch)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:temp_c)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:is_day)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:wind_mph)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:wind_kph)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:wind_dir)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:pressure_mb)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:pressure_in)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:cloud)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:feelslike_c)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:vis_km)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:gust_mph)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:gust_kph)

    forecast[:attributes][:daily_weather].each do |d|
      expect(d).to_not have_key(:date_epoch)
      expect(d).to_not have_key(:maxtemp_c)
      expect(d).to_not have_key(:mintemp_c)
      expect(d).to_not have_key(:avgtemp_c)
      expect(d).to_not have_key(:avgtemp_f)
      expect(d).to_not have_key(:maxwind_mph)
      expect(d).to_not have_key(:maxwind_kph)
      expect(d).to_not have_key(:totalprecip_mm)
      expect(d).to_not have_key(:totalprecip_in)
      expect(d).to_not have_key(:totalsnow_cm)
      expect(d).to_not have_key(:avgvis_km)
      expect(d).to_not have_key(:avgvis_mi)
      expect(d).to_not have_key(:avghumidity)
      expect(d).to_not have_key(:daily_will_it_rain)
      expect(d).to_not have_key(:daily_chance_of_snow)
      expect(d).to_not have_key(:uv)
      expect(d).to_not have_key(:astro)
    end

    forecast[:attributes][:hourly_weather].each do |h|
      expect(h).to_not have_key(:time_epoch)
      expect(h).to_not have_key(:temp_c)
      expect(h).to_not have_key(:is_day)
      expect(h).to_not have_key(:wind_mph)
      expect(h).to_not have_key(:wind_kph)
      expect(h).to_not have_key(:wind_degree)
      expect(h).to_not have_key(:wind_dir)
      expect(h).to_not have_key(:pressure_mb)
      expect(h).to_not have_key(:pressure_in)
      expect(h).to_not have_key(:precip_mm)
      expect(h).to_not have_key(:precip_in)
      expect(h).to_not have_key(:snow_cm)
      expect(h).to_not have_key(:humidity)
      expect(h).to_not have_key(:cloud)
      expect(h).to_not have_key(:feelslike_c)
      expect(h).to_not have_key(:feelslike_f)
      expect(h).to_not have_key(:windchill_c)
      expect(h).to_not have_key(:windchill_f)
      expect(h).to_not have_key(:heatindex_c)
      expect(h).to_not have_key(:heatindex_f)
      expect(h).to_not have_key(:dewpoint_c)
      expect(h).to_not have_key(:dewpoint_f)
      expect(h).to_not have_key(:will_it_rain)
      expect(h).to_not have_key(:chance_of_rain)
      expect(h).to_not have_key(:will_it_snow)
      expect(h).to_not have_key(:chance_of_snow)
      expect(h).to_not have_key(:vis_km)
      expect(h).to_not have_key(:vis_miles)
      expect(h).to_not have_key(:gust_mph)
      expect(h).to_not have_key(:gust_kph)
      expect(h).to_not have_key(:uv)
      expect(h).to_not have_key(:short_rad)
      expect(h).to_not have_key(:diff_rad)
    end

  end

end