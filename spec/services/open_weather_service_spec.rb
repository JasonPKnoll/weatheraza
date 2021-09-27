require 'rails_helper'

RSpec.describe OpenWeatherService, type: :service do
  describe 'class methods' do
    describe 'connection setup' do
      it 'succesfully establishes the connection and defines the headers', :vcr do
        setup = OpenWeatherService.conn

        expect(setup.params).to include('appid')
        expect(setup.params.values).to include(ENV['open_weather_key'])
      end
    end

    describe ':: get_forecast' do
      context 'when I provide valid coordinates', :vcr do
        subject(:forecast) { OpenWeatherService.get_forecast(lat, lon) }

        # let(:coordinate) { {lat: 33.44, lon: -94.04} }
        let(:lat) { 33.44 }
        let(:lon) { -94.04 }

        it 'provides valid forcast has' do
          aggregate_failures 'test forecast' do
            expect(forecast).to be_a(Hash)

            expect(forecast).to have_key(:lat)
            expect(forecast[:lat]).to eq(lat)
            expect(forecast).to have_key(:lon)
            expect(forecast[:lon]).to eq(lon)
            
            expect(forecast).to have_key(:current)
            expect(forecast[:current]).to be_a(Hash)
            expect(forecast[:current]).to have_key(:dt)
            expect(forecast[:current][:dt]).to be_a(Integer)
            expect(forecast[:current]).to have_key(:temp)
            expect(forecast[:current][:temp]).to be_a(Float)

            expect(forecast[:current]).to have_key(:weather)
            expect(forecast[:current][:weather][0]).to be_a(Hash)
            expect(forecast[:current][:weather][0]).to have_key(:description)
            expect(forecast[:current][:weather][0][:description]).to be_a(String)

            expect(forecast).to have_key(:hourly)
            expect(forecast[:hourly]).to be_a(Array)
            expect(forecast).to have_key(:daily)
            expect(forecast[:daily]).to be_a(Array)
          end
        end

      end
    end  # end of get_forecast

  end # end of class methods
end
