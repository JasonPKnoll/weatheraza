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

    let(:headers) do
      {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
       }
    end

    it 'returns roadtrip with correct information' do
      aggregate_failures 'test roadtrip' do

        new_user = create(:user)

        road_trip_params = {
          origin: 'Denver, CO',
          destination: 'Pueblo, CO',
          api_key: new_user.api_key,
        }

        post '/api/v1/road_trip', params: road_trip_params.to_json, headers: headers
        road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(road_trip).to have_key(:data)

        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:data][:id]).to eq(nil)
        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data][:type]).to eq('roadtrip')

        expect(road_trip[:data]).to have_key(:attributes)

        expect(road_trip[:data][:attributes]).to have_key(:start_city)
        expect(road_trip[:data][:attributes][:start_city]).to eq(road_trip_params[:origin])
        expect(road_trip[:data][:attributes]).to have_key(:end_city)
        expect(road_trip[:data][:attributes][:end_city]).to eq(road_trip_params[:destination])
        expect(road_trip[:data][:attributes]).to have_key(:travel_time)
        expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)


        expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)

        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
        expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
      end
    end

    it 'returns roadtrip when trip will take days' do
      aggregate_failures 'test roadtrip' do

        new_user = create(:user)

        road_trip_params = {
          origin: 'Phoneix, AZ',
          destination: 'Miami, FL',
          api_key: new_user.api_key,
        }

        post '/api/v1/road_trip', params: road_trip_params.to_json, headers: headers
        road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(road_trip[:data][:attributes][:travel_time].to_i).to be >= 24

        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:data][:id]).to eq(nil)
        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data][:type]).to eq('roadtrip')

        expect(road_trip[:data]).to have_key(:attributes)

        expect(road_trip[:data][:attributes]).to have_key(:start_city)
        expect(road_trip[:data][:attributes][:start_city]).to eq(road_trip_params[:origin])
        expect(road_trip[:data][:attributes]).to have_key(:end_city)
        expect(road_trip[:data][:attributes][:end_city]).to eq(road_trip_params[:destination])
        expect(road_trip[:data][:attributes]).to have_key(:travel_time)
        expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)


        expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)

        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
        expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)

      end
    end

    it 'returns 401 when given invalid api' do
      new_user = create(:user)

      road_trip_params = {
        origin: 'Denver, CO',
        destination: 'Pueblo, CO',
        api_key: 'notvalidapi',
      }

      post '/api/v1/road_trip', params: road_trip_params.to_json, headers: headers

      expect(response.status).to eq(401)
    end

    it 'returns information when no route can be made' do
      aggregate_failures 'test road trip' do

        new_user = create(:user)

        road_trip_params = {
          origin: 'Denver, CO',
          destination: 'London',
          api_key: new_user.api_key,
        }

        post '/api/v1/road_trip', params: road_trip_params.to_json, headers: headers
        road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(road_trip).to have_key(:data)

        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:data][:id]).to eq(nil)
        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data][:type]).to eq('roadtrip')

        expect(road_trip[:data]).to have_key(:attributes)

        expect(road_trip[:data][:attributes]).to have_key(:start_city)
        expect(road_trip[:data][:attributes][:start_city]).to eq(road_trip_params[:origin])
        expect(road_trip[:data][:attributes]).to have_key(:end_city)
        expect(road_trip[:data][:attributes][:end_city]).to eq(road_trip_params[:destination])
        expect(road_trip[:data][:attributes]).to have_key(:travel_time)
        expect(road_trip[:data][:attributes][:travel_time]).to eq('impossible')

        expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)

        expect(road_trip[:data][:attributes][:weather_at_eta]).to_not have_key(:temperature)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to_not have_key(:conditions)
      end
    end

  end
end
