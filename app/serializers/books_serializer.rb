class BooksSerializer
  include FastJsonapi::ObjectSerializer

  def self.format(books, forecast, location)
    {
      data: {
        id: nil,
        type: 'books',
        attributes: {
          destination: location,
          forecast: {
            summary: forecast[:data][:attributes][:current_weather][:conditions],
            temperature: forecast[:data][:attributes][:current_weather][:temperature],
          },
          total_books_found: books[:numFound],
          books: books[:docs].map do |book|
            {
              isbn: book[:isbn],
              title: book[:title],
              publisher: book[:publisher]
            }
          end,
        }
      }
    }
  end
end
