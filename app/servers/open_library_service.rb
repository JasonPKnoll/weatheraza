class OpenLibraryService
  class << self
    def conn
      Faraday.new(
        url: 'http://openlibrary.org',
      )
    end

    def get_books(location, quantity)
      response = conn.get('/search.json') do |req|
        req.params['q'] = ("#{location}")
        req.params['limit'] = ("#{quantity}")
      end
      JSON.parse(response.body, symbolize_names: true)
    end

  end
end
