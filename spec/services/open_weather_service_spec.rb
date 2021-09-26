require 'rails_helper'

RSpec.describe OpenWeatherService do
  describe 'class methods' do
    describe 'connection setup' do
      it 'succesfully establishes the connection and defines the headers', :vcr do
        setup = OpenWeatherService.conn

        expect(setup.headers).to include('appid')
        expect(setup.headers.values).to include(ENV['open_weather_key'])
      end
    end
  end
end
