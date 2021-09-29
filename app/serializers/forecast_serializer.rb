class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  def self.format(data)
    {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: {
            datetime: Time.zone.at(data[:current][:dt]),
            sunrise: Time.zone.at(data[:current][:sunrise]),
            sunset: Time.zone.at(data[:current][:sunset]),
            temperature: data[:current][:temp],
            feels_like: data[:current][:feels_like],
            humidity: data[:current][:humidity],
            uvi: data[:current][:uvi],
            visibility: data[:current][:visibility],
            conditions: data[:current][:weather][0][:description],
            icon: data[:current][:weather][0][:icon]
          },
          daily_weather: data[:daily].first(5).map do |day|
            {
              date: Time.zone.at(day[:dt]),
              sunrise: Time.zone.at(day[:sunrise]),
              sunset: Time.zone.at(day[:sunset]),
              max_temp: day[:temp][:max],
              min_temp: day[:temp][:min],
              conditions: day[:weather][0][:description],
              icon: day[:weather][0][:icon],
            }
          end,
          hourly_weather: data[:hourly].first(8).map do |hour|
            {
              time: Time.zone.at(hour[:dt]).to_s(:time),
              temperature: hour[:temp],
              conditions: hour[:weather][0][:description],
              icon: hour[:weather][0][:icon],
            }
          end,
        }
      }
    }
  end

end
