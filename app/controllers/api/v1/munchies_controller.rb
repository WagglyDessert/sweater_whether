class Api::V1::MunchiesController < ApplicationController

  def search
    #GET /api/v1/munchies?destination=pueblo,co&food=italian
    #{?destination=pueblo,co&food=italian} are params
    destination = params[:destination]
    food = params[:food]
    #binding.pry
    munchies_facade = MunchiesFacade.new.find_munchies(destination, food)
    render json: MunchieSerializer.new(munchies_facade)
  end

end