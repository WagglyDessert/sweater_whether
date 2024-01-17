class Munchie
  attr_reader :id,
              :type,
              :destination_city,
              :forecast,
              :restaurant



  def initialize(destination, munchies_data, weather_data)
    @id = nil
    @type = "munchie"
    @destination_city = destination.split(',').map(&:capitalize).join(', ').sub(/\b\w{2}\b/, &:upcase)
    @forecast = {
      summary: weather_data[:current][:condition][:text],
      temperature: weather_data[:current][:temp_f],
    }
    @restaurant = {
      name: munchies_data[:businesses].first[:name],
      address: munchies_data[:businesses].first[:location][:display_address].join(', '),
      rating: munchies_data[:businesses].first[:rating],
      reviews: munchies_data[:businesses].first[:review_count]
    }
  end
end