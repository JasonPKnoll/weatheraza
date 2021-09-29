class Api::V1::RoadTripController < ApplicationController
  before_action :check_params, only: [:create]

  def create
    roadtrip = RoadTripFacade.get_roadtrip(params)

    render json: roadtrip, status: 201
  end

  private

  def check_params
    if User.find_by(api_key: params[:api_key]).nil?
      render json: {error: 'no user found'}, status: 401
    else
    end
  end

end
