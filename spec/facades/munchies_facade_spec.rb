require "rails_helper"

RSpec.describe MunchiesFacade do

  it "::search", :vcr do
    destination = "denver,co"
    food = "thai"
    search_results = MunchiesFacade.new.find_munchies(destination, food)
    expect(search_results).to be_a(Object)
    expect(search_results.destination_city).to be_a(String)
    expect(search_results.destination_city).to eq("Denver, CO")
    expect(search_results.forecast).to be_a(Hash)
    expect(search_results.forecast[:summary]).to be_a(String)
    expect(search_results.forecast[:temperature]).to be_a(Float)
    expect(search_results.restaurant).to be_a(Hash)
    expect(search_results.restaurant[:name]).to be_a(String)
    expect(search_results.restaurant[:address]).to be_a(String)
    expect(search_results.restaurant[:rating]).to be_a(Float)
    expect(search_results.restaurant[:reviews]).to be_a(Integer)
    expect(search_results.id).to eq(nil)
    expect(search_results.type).to eq("munchie")
  end
end