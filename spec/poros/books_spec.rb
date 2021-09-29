require 'rails_helper'

describe Books, type: :poro do
  describe 'create books' do
    let(:location) { 'Denver,CO' }
    let(:quantity) { 5 }
    it 'gives back correct information', :vcr do
      aggregate_failures 'test books poro' do
        books_info = OpenLibraryService.get_books(location, quantity)
        geocode = MapQuestFacade.get_geocoding(location)
        forecast = OpenWeatherFacade.get_forecast(geocode[:lat], geocode[:lon])
        books = Books.new(books_info, forecast, location)

        expect(books).to be_a(Object)

        expect(books.books.count).to eq(5)
        expect(books.books.first[:isbn]).to be_a(Array)
        expect(books.books.first[:isbn][0]).to be_a(String)
        expect(books.books.first[:title]).to be_a(String)
        expect(books.books.first[:publisher]).to be_a(Array)
        expect(books.books.first[:publisher][0]).to be_a(String)

        expect(books.destination).to eq(location)
        expect(books.id).to eq(nil)
        expect(books.type).to eq('books')

        expect(books.forecast).to be_a(Hash)
        expect(books.forecast[:summary]).to be_a(String)
        expect(books.forecast[:temperature]).to be_a(Float)
      end
    end
  end
end
