class RoadTrip
  attr_reader :id, :type, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(directions, forecast, params)
    @start_city = params[:origin]
    @end_city = params[:destination]
    @travel_time = get_travel_time(directions)
    @weather_at_eta = get_weather(directions, forecast)
  end

  def get_weather(directions, forecast)
    if directions[:route][:realTime].nil?
      {}
    else
      x = (directions[:route][:realTime] / (60 * 60.0)).round - 1
      y = (directions[:route][:realTime] / (60 * 1440.0)).round - 1
      if x < 8
        {
          temperature: forecast.hourly_weather[x][:temperature],
          conditions: forecast.hourly_weather[x][:conditions],
        }
      else
        {
          temperature: forecast.hourly_weather[y][:temperature],
          conditions: forecast.hourly_weather[y][:conditions],
        }
      end
    end
  end

  def get_travel_time(directions)
    if directions[:route][:realTime].nil?
      'impossible'
    else
      directions[:route][:formattedTime]
    end
  end

  def convert_to_fahrenheit(x)
    ((x - 273.15) * 9 / 5 + 32).round(2)
  end
end
