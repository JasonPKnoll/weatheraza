require 'rails_helper'

describe 'User Controller', type: :request do
  describe 'POST /api/v1/users', :vcr do
    context 'when I give correct user params' do


      it 'returns user with correct information' do
        aggregate_failures 'test background' do
          get '/api/v1/users', params: { }

          res = JSON.parse(response.body, symbolize_names: true)

        end
      end

    end

  end
end
