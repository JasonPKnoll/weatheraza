class BooksFacade
  class << self

    def get_books(location, quantity)
      books = OpenLibraryService.get_books(location, quantity)
      geocode = MapQuestFacade.get_geocoding(location)
      forecast = OpenWeatherFacade.get_forecast(geocode[:lat], geocode[:lon])
      BooksSerializer.format(books, forecast, location)
    end

  end
end
