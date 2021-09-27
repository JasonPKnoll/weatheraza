require 'rails_helper'

describe BooksSerializer, type: :serializer do
  describe 'class methods' do
    let(:location) { 'Denver,CO' }
    let(:quantity) { 5 }
    it 'formats respose for books', :vcr do
      aggregate_failures 'test books serializer' do
        books = OpenLibraryService.get_books(location, quantity)
        geocode = MapQuestFaqcade.get_geocoding(location)
        forecast = OpenWeatherService.get_forecast(geocode[:lat], geocode[:lon])

        books_formated = BooksSerializer.format(books, forecast)

        expect(books_formated).to be_a(Hash)

        expect(books_formated[:data]).to have_key(:id)
        expect(books_formated[:data][:id]).to eq(nil)
        expect(books_formated[:data]).to have_key(:type)
        expect(books_formated[:data][:type]).to eq('books')

        expect(books_formated[:data][:attributes]).to have_key(:destination)
        expect(books_formated[:data][:attributes][:destination]).to be_a(String)
        expect(books_formated[:data][:attributes]).to have_key(:forecast)
        expect(books_formated[:data][:attributes][:forecast]).to be_a(Hash)
        expect(books_formated[:data][:attributes][:forecast]).to have_key([:summary])
        expect(books_formated[:data][:attributes][:forecast][:summary]).to be_a(String)
        expect(books_formated[:data][:attributes][:forecast]).to have_key([:temperature])
        expect(books_formated[:data][:attributes][:forecast][:temperature]).to be_a(String)

        expect(books_formated[:data][:attributes]).to have_key(:total_books_found)
        expect(books_formated[:data][:attributes][:total_books_found]).to be_a(Hash)
        expect(books_formated[:data][:attributes]).to have_key(:books)
        expect(books_formated[:data][:attributes][:books]).to be_a(Array)

        expect(books_formated[:data][:attributes][:books][0]).to have_key(:isbn)
        expect(books_formated[:data][:attributes][:books][0][:isbn]).to be_a(Array)
        expect(books_formated[:data][:attributes][:books][0][:isbn][0]).to be_a(Integer)
        expect(books_formated[:data][:attributes][:books][0]).to have_key(:title)
        expect(books_formated[:data][:attributes][:books][0][:title]).to be_a(String)
        expect(books_formated[:data][:attributes][:books][0]).to have_key(:publisher)
        expect(books_formated[:data][:attributes][:books][0][:publisher]).to be_a(Array)
        expect(books_formated[:data][:attributes][:books][0][:publisher][0]).to be_a(String)

      end
    end

  end
end
