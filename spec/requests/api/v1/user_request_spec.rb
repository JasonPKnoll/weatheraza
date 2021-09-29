require 'rails_helper'

describe 'User Controller', type: :request do
  describe 'POST /api/v1/users', :vcr do

    context 'when I give correct user params' do
      let(:json) do
        {
          email: 'sample@email.com',
          password: 'hunter2',
          password_confirmation: 'hunter2'
        }
      end

      it 'returns user with correct information' do
        aggregate_failures 'test background' do
          post '/api/v1/users', params: json

          user = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(201)

          expect(response.body).to include(json[:email])

          expect(user[:data][:attributes]).to_not have_key([:password_digest])

          expect(user[:data][:attributes].keys).to eq([:email, :api_key])
          expect(user[:data][:attributes][:api_key]).to be_a(String)
          expect(user[:data][:attributes][:api_key].length).to eq(24)
        end
      end

    end

    context 'when I give incorrect user params' do
      let(:empty_email) do
        {
          password: 'hunter2',
          password_confirmation: 'hunter2'
        }
      end
      let(:mismatched_password) do
        {
          email: 'sample@email.com',
          password: 'hunter2',
          password_confirmation: 'hunter1'
        }
      end

      it 'returns error and status when missing param' do
        post '/api/v1/users', params: empty_email

        user = JSON.parse(response.body, symbolize_names: true)

        expect(user[:error]).to eq('missing paramater')
        expect(response.status).to eq(400)
      end

      it 'returns error and status when passwords mismatch' do
        post '/api/v1/users', params: mismatched_password

        user = JSON.parse(response.body, symbolize_names: true)

        expect(user[:error]).to eq('passwords do not match')
        expect(response.status).to eq(400)
      end
    end

  end
end
