class Api::V1::ForecastController < ApplicationController
  before_action :validate_params, only: [:index]

  def index
    geocode = MapQuestFacade.get_geocoding(params[:location])
    forecast = OpenWeatherFacade.get_forecast(geocode[:lat], geocode[:lon])

    render json: ForecastSerializer.new(forecast)
  end

  private

  def validate_params
    if params[:location].nil? or params[:location].blank?
      render json: { error: 'no location given' }, status: 400
    else
    end
  end

end
