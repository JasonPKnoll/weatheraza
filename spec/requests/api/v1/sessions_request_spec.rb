require 'rails_helper'

describe 'Sessions Controller', type: :request do
  describe 'POST /api/v1/users', :vcr do
      let(:params) do
        {
          email: 'example@email.com',
          password: 'hunter2',
          password_confirmation: 'hunter2',
        }
      end

      let(:headers) do
        {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
         }
      end

    it 'returns user with correct information' do
      aggregate_failures 'test background' do
        new_user = create(:user)

        post '/api/v1/sessions', params: params.to_json, headers: headers
        user = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)

        expect(user[:data]).to have_key(:id)
        expect(user[:data][:id]).to eq(new_user.id.to_s)
        expect(user[:data]).to have_key(:type)
        expect(user[:data][:type]).to eq('user')


        expect(user[:data][:attributes]).to_not have_key(:password_digest)
        expect(user[:data][:attributes]).to_not have_key(:password)

        expect(user[:data][:attributes]).to have_key(:email)
        expect(user[:data][:attributes][:email]).to be_a(String)
        expect(user[:data][:attributes]).to have_key(:api_key)
        expect(user[:data][:attributes][:api_key]).to be_a(String)
        expect(user[:data][:attributes][:api_key].length).to eq(24)
      end
    end

    let(:bad_params) do
      {
        email: 'bademail@email.com',
        password: 'hunter2',
        password_confirmation: 'hunter2',
      }
    end
    let(:bad_password) do
      {
        email: 'example@email.com',
        password: '1234',
        password_confirmation: '1234',
      }
    end

    it 'returns 401 status error when given a wrong email' do
      new_user = create(:user)

      post '/api/v1/sessions', params: bad_params.to_json, headers: headers
      user = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
    end

    it 'returns 401 status error when given a wrong password' do
      new_user = create(:user)

      post '/api/v1/sessions', params: bad_password.to_json, headers: headers
      user = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
    end

  end
end
