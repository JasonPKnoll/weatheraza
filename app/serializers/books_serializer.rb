class BooksSerializer
  include FastJsonapi::ObjectSerializer
  set_id nil
  set_type 'books'
  attributes :destination, :forecast, :total_books_found, :books

end
