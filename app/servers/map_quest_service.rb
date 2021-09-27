class MapQuestService
  class << self
    def conn
      Faraday.new(
        url: 'http://www.mapquestapi.com',
        params: {key: ENV['map_quest_key']},
        headers: {
          'Content-Type' => 'application/json',
        }
      )
    end

    def get_geocoding(location)
      response = conn.get('/geocoding/v1/address') do |req|
        req.params['location'] = ("#{location}")
        # req.params['exclude'] = ['minutely']
      end
      JSON.parse(response.body, symbolize_names: true)
    end

  end
end
