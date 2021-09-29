require 'rails_helper'

describe UserSerializer, type: :serializer do

  it 'formats respose for users', :vcr do
    aggregate_failures 'test users serializer' do
      user = create(:user)
      user_formatted = UserSerializer.new(user).serialized_json
      user_info = JSON.parse(user_formatted, symbolize_names: true)

      expect(user_info).to be_a(Hash)

      expect(user_info).to have_key(:data)
      expect(user_info[:data]).to be_a(Hash)

      expect(user_info[:data].keys).to eq([:id, :type, :attributes])

      expect(user_info[:data][:id]).to be_a(String)
      expect(user_info[:data][:type]).to eq('user')
      expect(user_info[:data][:attributes]).to be_a(Hash)

      expect(user_info[:data][:attributes].keys).to eq([:email, :api_key])

      expect(user_info[:data][:attributes][:email]).to be_a(String)
      expect(user_info[:data][:attributes][:api_key]).to be_a(String)
      expect(user_info[:data][:attributes][:api_key].length).to eq(24)
    end
  end
end
