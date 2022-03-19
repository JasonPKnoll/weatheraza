class RoadTripFacade
  class << self

    def get_roadtrip(params)
      directions = MapQuestService.get_directions(params[:origin], params[:destination])
      geocode = MapQuestFacade.get_geocoding(params[:destination])
      forecast = OpenWeatherFacade.get_forecast(geocode[:lat], geocode[:lon])

      # RoadTripSerializer.format(directions, forecast, params)
      RoadTrip.new(directions, forecast, params)
    end

  end
end
