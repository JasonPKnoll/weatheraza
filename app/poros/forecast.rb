class Forecast
  attr_reader :id, :type, :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    # @id = nil
    # @type = 'forecast'
    @current_weather = set_current_weather(data)
    @daily_weather = set_daily_weather(data)
    @hourly_weather = set_hourly_weather(data)
  end

  def set_current_weather(data)
    {
      datetime: Time.zone.at(data[:current][:dt]),
      sunrise: Time.zone.at(data[:current][:sunrise]),
      sunset: Time.zone.at(data[:current][:sunset]),
      temperature: convert_to_fahrenheit(data[:current][:temp]),
      feels_like: convert_to_fahrenheit(data[:current][:feels_like]),
      humidity: data[:current][:humidity],
      uvi: data[:current][:uvi],
      visibility: data[:current][:visibility],
      conditions: data[:current][:weather][0][:description],
      icon: data[:current][:weather][0][:icon]
    }
  end

  def set_daily_weather(data)
    data[:daily].first(5).map do |day|
      {
        date: Time.zone.at(day[:dt]),
        sunrise: Time.zone.at(day[:sunrise]),
        sunset: Time.zone.at(day[:sunset]),
        max_temp: convert_to_fahrenheit(day[:temp][:max]),
        min_temp: convert_to_fahrenheit(day[:temp][:min]),
        conditions: day[:weather][0][:description],
        icon: day[:weather][0][:icon],
      }
    end
  end

  def set_hourly_weather(data)
    data[:hourly].first(8).map do |hour|
      {
        time: Time.zone.at(hour[:dt]).to_s(:time),
        temperature: convert_to_fahrenheit(hour[:temp]),
        conditions: hour[:weather][0][:description],
        icon: hour[:weather][0][:icon],
      }
    end
  end

  def convert_to_fahrenheit(x)
    ((x - 273.15) * 9 / 5 + 32).round(2)
  end

end
