class UnsplashService
  class << self
    def conn
      Faraday.new(
        url: 'https://api.unsplash.com',
        params: {client_id: ENV['unsplash_key']},
        headers: {
          'Content-Type' => 'application/json',
          'Accept-Version:' => 'v1',
        }
      )
    end
  end
end
