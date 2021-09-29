class Books
  attr_reader :id, :type, :destination, :forecast, :total_books_found, :books

  def initialize(books, forecast, location)
    @id = nil
    @type = 'books'
    @destination = location
    @forecast = set_forecast(forecast)
    @total_books_found = books[:numFound]
    @books = set_books(books)
  end

  def set_forecast(forecast)
    {
      summary: forecast.current_weather[:conditions],
      temperature: forecast.current_weather[:temperature],
    }
  end

  def set_books(books)
    books[:docs].map do |book|
      {
        isbn: book[:isbn],
        title: book[:title],
        publisher: book[:publisher]
      }
    end
  end

end
