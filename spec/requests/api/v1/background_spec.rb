require 'rails_helper'

describe 'BackgroundController', type: :request do
  describe 'GET /api/v1/background', :vcr do
    context 'when I give correct location params' do
      let(:location) { 'Denver,CO' }

      it 'returns forcast with correct information' do
        aggregate_failures 'test background' do
          get '/api/v1/background', params: { location: location }

        end
      end

    end

  end
end
