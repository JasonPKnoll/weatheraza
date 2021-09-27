require 'rails_helper'

RSpec.describe UnsplashService, type: :service do
  describe 'class methods' do
    describe 'connection setup' do
      it 'succesfully establishes the connection and defines the headers', :vcr do
        setup = UnsplashService.conn

        expect(setup.params).to include('client_id')
        expect(setup.params.values).to include(ENV['unsplash_key'])
      end
    end

  end
end
