class Api::V1::ForecastController < ApplicationController

  def index
    geocode = MapQuestFacade.get_geocoding(params[:location])
    forecast = OpenWeatherFacade.get_forecast(geocode[:lat], geocode[:lon])

    render json: ForecastSerializer.new(forecast)
  end

end
