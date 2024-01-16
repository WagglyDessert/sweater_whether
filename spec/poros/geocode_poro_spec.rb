require "rails_helper"

RSpec.describe Geocode do
  it "exists" do
    attrs = {
    :latLng=>{:lat=>39.74204, :lng=>-104.99153}
    }

    search = Geocode.new(attrs)

    expect(search).to be_a Geocode
    expect(search.lat).to eq(39.74204)
    expect(search.lon).to eq(-104.99153)
  end
end