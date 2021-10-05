require 'rails_helper'

describe 'ForecastController', type: :request do
  describe 'GET /api/v1/forecast', :vcr do
    context 'when I give correct location params' do
      let(:location) { 'Denver,CO' }

      it 'returns forcast with correct information' do
        aggregate_failures 'test forecast' do
          get '/api/v1/forecast', params: { location: location }

          res = JSON.parse(response.body, symbolize_names: true)

          expect(res).to be_a(Hash)

          expect(res[:data]).to have_key(:id)
          expect(res[:data][:id]).to eq(nil)
          expect(res[:data]).to have_key(:type)
          expect(res[:data][:type]).to eq('forecast')

          expect(res[:data][:attributes]).to have_key(:current_weather)
          expect(res[:data][:attributes]).to have_key(:daily_weather)
          expect(res[:data][:attributes]).to have_key(:hourly_weather)

          current_weather = res[:data][:attributes][:current_weather]

          expect(current_weather).to have_key(:datetime)
          expect(current_weather[:datetime]).to be_a(String)
          expect(current_weather).to have_key(:sunrise)
          expect(current_weather[:sunrise]).to be_a(String)
          expect(current_weather).to have_key(:sunset)
          expect(current_weather[:sunset]).to be_a(String)
          expect(current_weather).to have_key(:temperature)
          expect(current_weather[:temperature]).to be_a(Float)
          expect(current_weather).to have_key(:feels_like)
          expect(current_weather[:feels_like]).to be_a(Float)
          expect(current_weather).to have_key(:humidity)
          expect(current_weather[:humidity]).to be_a(Integer)
          expect(current_weather).to have_key(:uvi)
          expect(current_weather[:uvi]).to be_a(Integer)
          expect(current_weather).to have_key(:visibility)
          expect(current_weather[:visibility]).to be_a(Integer)
          expect(current_weather).to have_key(:conditions)
          expect(current_weather[:conditions]).to be_a(String)
          expect(current_weather).to have_key(:icon)
          expect(current_weather[:icon]).to be_a(String)

          daily_weather = res[:data][:attributes][:daily_weather]

          expect(daily_weather.count).to eq(5)
          expect(daily_weather[0]).to have_key(:date)
          expect(daily_weather[0][:date]).to be_a(String)
          expect(daily_weather[0]).to have_key(:sunrise)
          expect(daily_weather[0][:sunrise]).to be_a(String)
          expect(daily_weather[0]).to have_key(:sunset)
          expect(daily_weather[0][:sunset]).to be_a(String)
          expect(daily_weather[0]).to have_key(:max_temp)
          expect(daily_weather[0][:max_temp]).to be_a(Float)
          expect(daily_weather[0]).to have_key(:min_temp)
          expect(daily_weather[0][:min_temp]).to be_a(Float)
          expect(daily_weather[0]).to have_key(:conditions)
          expect(daily_weather[0][:conditions]).to be_a(String)
          expect(daily_weather[0]).to have_key(:icon)
          expect(daily_weather[0][:icon]).to be_a(String)

          hourly_weather = res[:data][:attributes][:hourly_weather]

          expect(hourly_weather.count).to eq(8)
          expect(hourly_weather[0]).to have_key(:time)
          expect(hourly_weather[0][:time]).to be_a(String)
          expect(hourly_weather[0]).to have_key(:temperature)
          expect(hourly_weather[0][:temperature]).to be_a(Float)
          expect(hourly_weather[0]).to have_key(:conditions)
          expect(hourly_weather[0][:conditions]).to be_a(String)
          expect(hourly_weather[0]).to have_key(:icon)
          expect(hourly_weather[0][:icon]).to be_a(String)
        end
      end
      it 'returns forcast with correct information' do
        aggregate_failures 'test forecast' do
          get '/api/v1/forecast', params: { location: location }

          res = JSON.parse(response.body, symbolize_names: true)

          expect(res[:data][:attributes]).to_not have_key(:minutely)
          expect(res[:data][:attributes]).to_not have_key(:wind_speed)
          expect(res[:data][:attributes]).to_not have_key(:main)
        end
      end

    end

    context 'when I give no location params' do
      let(:location) { ' ' }


      it 'returns error and status 400' do
        aggregate_failures 'test forecast' do
          get '/api/v1/forecast', params: { location: location }

          res = JSON.parse(response.body, symbolize_names: true)

          expect(res).to have_key(:error)
          expect(res[:error]).to eq('no location given')
          expect(response.status).to eq(400)
        end
      end

    end

  end
end
