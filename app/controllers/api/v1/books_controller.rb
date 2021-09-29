class Api::V1::BooksController < ApplicationController
  before_action :valid_params, only: [:index]

  def index
    books_formated = BooksFacade.get_books(params[:location], params[:quantity])

    render json: books_formated
  end

  private

  def valid_params
    if params[:quantity].to_i < 1
      render json: {:error => 'invalid quantity'}, status: 400
    else
    end
  end
end
