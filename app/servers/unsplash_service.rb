class UnsplashService
  class << self
    def conn
      Faraday.new(
        url: 'https://api.unsplash.com',
        params: {client_id: ENV['unsplash_key']},
        headers: {
        }
      )
    end

    def get_background(location)
      response = conn.get('/search/photos') do |req|
        req.params['content_filter'] = 'high'
        req.params['per_page'] = '1'
        req.params['query'] = "#{location}"
      end
      JSON.parse(response.body, symbolize_names: true)
    end

  end
end
