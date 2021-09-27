class OpenWeatherService
  class << self
    def conn
      Faraday.new(
        url: 'https://api.openweathermap.org',
        params: {appid: ENV['open_weather_key']},
        headers: {
          'Content-Type' => 'application/json'
        }
      )
    end

    def get_forecast(lat, lon)
      response = conn.get('/data/2.5/onecall') do |req|
        req.params['lat'] = lat
        req.params['lon'] = lon
        # req.params['exclude'] = ['minutely']
      end
      JSON.parse(response.body, symbolize_names: true)
    end

  end
end
