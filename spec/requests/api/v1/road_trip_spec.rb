require 'rails_helper'

describe 'RoadTrip Controller', type: :request do
  describe 'POST /api/v1/road_trip', :vcr do
    let(:user_params) do
      {
        email: 'sample@email.com',
        password: 'hunter2',
        password_confirmation: 'hunter2'
      }
    end

    # let(:params) do
    #   {
    #     origin: 'Denver, CO',
    #     destination: 'Pueblo, CO',
    #     api_key: 'jgn983hy48thw9begh98h4539h4',
    #   }
    # end

    let(:headers) do
      {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
       }
    end

    it 'returns user with correct information' do
      aggregate_failures 'test background' do
        new_user = create(:user)

        road_trip_params = {
          origin: 'Denver, CO',
          destination: 'Pueblo, CO',
          api_key: new_user.api_key,
        }

        post '/api/v1/road_trip', params: road_trip_params.to_json, headers: headers
        road_trip = JSON.parse(response.body, symbolize_names: true)

      end
    end

  end
end
