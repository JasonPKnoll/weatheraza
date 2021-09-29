class OpenWeatherFacade
  class << self

    def get_forecast(lat, lon)
      request = OpenWeatherService.get_forecast(lat, lon)
      # ForecastSerializer.format(request)
      Forecast.new(request)
    end

  end
end
