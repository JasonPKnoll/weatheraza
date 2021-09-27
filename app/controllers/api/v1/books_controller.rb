class Api::V1::BooksController < ApplicationController

  def index
    books = OpenLibraryService.get_books(params[:location], params[:quantity])
    geocode = MapQuestFacade.get_geocoding(params[:location])
    forecast = OpenWeatherFacade.get_forecast(geocode[:lat], geocode[:lon])

  end

end
