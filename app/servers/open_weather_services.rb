class OpenWeatherServices

  conn = Faraday.new('https://api.openweathermap.org') do |req|
    req.headers['appid'] = ENV[open_weather_key]
  end

end
