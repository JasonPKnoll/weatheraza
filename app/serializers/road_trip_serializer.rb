class RoadTripSerializer
  include FastJsonapi::ObjectSerializer

  def self.format(directions, forecast, params)
    if directions[:route][:realTime].nil?
      format_without_route(directions, forecast, params)
    else
      format_with_route(directions, forecast, params)
    end
  end

  def self.format_with_route(directions, forecast, params)
    x = (directions[:route][:realTime] / (60 * 60.0)).round - 1
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: params[:origin],
          end_city: params[:destination],
          travel_time: directions[:route][:formattedTime],
          weather_at_eta: {
            temperature: forecast[:data][:attributes][:hourly_weather][x][:temperature],
            conditions: forecast[:data][:attributes][:hourly_weather][x][:conditions],
          }
        }
      }
    }
  end

  def self.format_without_route(directions, forecast, params)
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: params[:origin],
          end_city: params[:destination],
          travel_time: 'impossible',
          weather_at_eta: {
          }
        }
      }
    }
  end

end
