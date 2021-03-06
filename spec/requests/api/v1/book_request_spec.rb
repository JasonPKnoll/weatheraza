require 'rails_helper'

describe 'BookController', type: :request do
  describe 'GET /api/v1/book-search', :vcr do
    context 'when I give correct location params' do
      let(:location) { 'Denver' }
      let(:quantity) { 5 }


      it 'returns forcast with correct information' do
        aggregate_failures 'test background' do
          get '/api/v1/book-search', params: { location: location, quantity: quantity }

          res = JSON.parse(response.body, symbolize_names: true)

          expect(res).to be_a(Hash)

          expect(res[:data]).to have_key(:id)
          expect(res[:data][:id]).to eq(nil)
          expect(res[:data]).to have_key(:type)
          expect(res[:data][:type]).to eq('books')

          expect(res[:data][:attributes]).to have_key(:destination)
          expect(res[:data][:attributes][:destination]).to be_a(String)
          expect(res[:data][:attributes]).to have_key(:forecast)
          expect(res[:data][:attributes][:forecast]).to be_a(Hash)
          expect(res[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
          expect(res[:data][:attributes][:forecast][:summary]).to be_a(String)
          expect(res[:data][:attributes][:forecast][:temperature]).to be_a(Float)

          expect(res[:data][:attributes]).to have_key(:total_books_found)
          expect(res[:data][:attributes][:total_books_found]).to be_a(Integer)
          expect(res[:data][:attributes]).to have_key(:books)
          expect(res[:data][:attributes][:books]).to be_a(Array)

          expect(res[:data][:attributes][:books][0]).to have_key(:isbn)
          expect(res[:data][:attributes][:books][0][:isbn]).to be_a(Array)
          expect(res[:data][:attributes][:books][0][:isbn][0]).to be_a(String)
          expect(res[:data][:attributes][:books][0]).to have_key(:title)
          expect(res[:data][:attributes][:books][0][:title]).to be_a(String)
          expect(res[:data][:attributes][:books][0]).to have_key(:publisher)
          expect(res[:data][:attributes][:books][0][:publisher]).to be_a(Array)
          expect(res[:data][:attributes][:books][0][:publisher][0]).to be_a(String)
        end
      end

      context 'when I give incorrect params' do
        let(:location) { 'Denver' }
        let(:quantity) { -5 }
        it 'returns error when given quantity that is a negative number' do
          get '/api/v1/book-search', params: { location: location, quantity: quantity }

          res = JSON.parse(response.body, symbolize_names: true)

          expect(res.keys).to include(:error)
          expect(res.values).to include("invalid quantity")
        end

        let(:location) { 'Denver' }
        let(:quantity) { 0 }
        it 'returns error when given quantity 0' do
          get '/api/v1/book-search', params: { location: location, quantity: quantity }

          res = JSON.parse(response.body, symbolize_names: true)

          expect(res.keys).to include(:error)
          expect(res.values).to include("invalid quantity")
        end
      end

    end

  end
end
