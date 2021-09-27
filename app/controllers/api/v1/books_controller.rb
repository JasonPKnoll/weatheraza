class Api::V1::BooksController < ApplicationController

  def index
    books = OpenLibraryService.get_books(params[:location], params[:quantity])
    geocode = MapQuestFacade.get_geocoding(params[:location])
    forecast = OpenWeatherFacade.get_forecast(geocode[:lat], geocode[:lon])
    books_formated = BooksSerializer.format(books, forecast, params[:location])
    render json: books_formated
  end

end
