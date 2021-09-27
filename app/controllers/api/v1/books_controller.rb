class Api::V1::BooksController < ApplicationController

  def index
    books_formated = BooksFacade.get_books(params[:location], params[:quantity])

    render json: books_formated
  end

end
