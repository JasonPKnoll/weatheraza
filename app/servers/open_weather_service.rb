class OpenWeatherService
  class << self
    def conn
      Faraday.new('https://api.openweathermap.org') do |req|
        req.headers['appid'] = ENV['open_weather_key']
      end
    end

    def self.get_forecast(location)
      response = conn.get("/api/v1/forecast?location=#{location}")
      JSON.parse(response.body)
    end
  end
end
