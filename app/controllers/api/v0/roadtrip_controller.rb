class Api::V0::RoadtripController < ApplicationController

  def duration
    if !params[:origin].present? || !params[:destination].present? || !params[:api_key].present?
      render json: { error: [{status: "422", detail: 'Origin, destination, and api_key are required.' }] }, status: :unprocessable_entity
    else
    user = User.find_by(api_key: params[:api_key])
      if user.nil?
        render json: ErrorSerializer.new(ErrorMessage.new("Sorry, your credentials are bad.", 401)).serialize_json, status: :unauthorized
      else
        destination = params[:destination]
        origin = params[:origin]
        roadtrip_facade = RoadtripFacade.new.duration(destination, origin)
        render json: RoadtripSerializer.new(roadtrip_facade)
      end
    end
  end

end