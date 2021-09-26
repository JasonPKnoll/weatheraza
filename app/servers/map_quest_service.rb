class MapQuestService
  class << self
    def conn
      Faraday.new('http://www.mapquestapi.com') do |req|
        req.headers['key'] = ENV['map_quest_key']
      end
    end

    def get_location(location)
      JSON.parse(
        conn.get("/geocoding/v1/#{location}").body,
        symoblize_names: true
      )
      # response = conn.get("/geocoding/v1/")
      # JSON.parse(response.body)
    end
  end
end
