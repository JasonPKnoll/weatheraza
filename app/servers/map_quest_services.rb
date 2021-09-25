class MapQuestServices

  conn = Faraday.new('http://www.mapquestapi.com') do |req|
    req.headers['key'] = ENV[map_quest_key]
  end

end
