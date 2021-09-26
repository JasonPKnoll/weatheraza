class UnsplashService
  class << self
      def conn
        Faraday.new('https://api.unsplash.com') do |req|
          req.headers['client_id'] = ENV['unsplash_key']
          req.headers['Accept-Version:'] = ['v1']
      end
    end
  end
end
