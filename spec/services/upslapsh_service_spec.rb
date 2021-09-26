require 'rails_helper'

RSpec.describe UnsplashService do
  describe 'class methods' do
    describe 'connection setup' do
      it 'succesfully establishes the connection and defines the headers', :vcr do
        setup = UnsplashService.conn

        expect(setup.headers).to include('client_id')
        expect(setup.headers.values).to include(ENV['unsplash_key'])
      end
    end
  end
end
