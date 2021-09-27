class OpenWeatherFacade
  class << self

    def get_forecast(lat, lon)
      request = OpenWeatherService.get_forecast(lat, lon)
      ForecastSerializer.format(request)
    end

  end
end
