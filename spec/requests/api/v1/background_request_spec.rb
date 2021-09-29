require 'rails_helper'

describe 'BackgroundController', type: :request do
  describe 'GET /api/v1/background', :vcr do
    context 'when I give correct location params' do
      let(:location) { 'Denver,CO' }

      it 'returns forcast with correct information' do
        aggregate_failures 'test background' do
          get '/api/v1/backgrounds', params: { location: location }

          background = JSON.parse(response.body, symbolize_names: true)

          expect(background).to have_key(:data)

          expect(background[:data]).to have_key(:id)
          expect(background[:data][:id]).to eq(nil)
          expect(background[:data]).to have_key(:type)
          expect(background[:data][:type]).to eq('image')

          expect(background[:data]).to have_key(:attributes)

          expect(background[:data][:attributes][:image]).to have_key(:full_image)
          expect(background[:data][:attributes][:image][:full_image]).to be_a(String)
          expect(background[:data][:attributes][:image]).to have_key(:regular_image)
          expect(background[:data][:attributes][:image][:regular_image]).to be_a(String)
          expect(background[:data][:attributes][:image]).to have_key(:description)
          expect(background[:data][:attributes][:image][:description]).to be_a(String)
          expect(background[:data][:attributes][:image]).to have_key(:author)
          expect(background[:data][:attributes][:image][:author]).to be_a(String)
        end
      end

    end

  end
end
