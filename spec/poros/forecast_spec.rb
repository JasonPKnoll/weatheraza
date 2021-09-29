require 'rails_helper'

describe Forecast, type: :poro do
  describe 'create forecast' do
    let(:lat) { 45 }
    let(:lon) { 30 }
    it 'gives back correct information', :vcr do
      aggregate_failures 'test forecast poro' do
        request = OpenWeatherService.get_forecast(lat, lon)
        forecast = Forecast.new(request)

        expect(forecast).to be_a(Object)

        expect(forecast.current_weather.count).to eq(10)
        expect(forecast.current_weather[:datetime]).to be_a(Time)
        expect(forecast.current_weather[:sunrise]).to be_a(Time)
        expect(forecast.current_weather[:sunset]).to be_a(Time)
        expect(forecast.current_weather[:temperature]).to be_a(Float)
        expect(forecast.current_weather[:feels_like]).to be_a(Float)
        expect(forecast.current_weather[:humidity]).to be_a(Integer)
        expect(forecast.current_weather[:uvi]).to be_a(Float)
        expect(forecast.current_weather[:visibility]).to be_a(Integer)
        expect(forecast.current_weather[:conditions]).to be_a(String)
        expect(forecast.current_weather[:icon]).to be_a(String)

        expect(forecast.daily_weather.count).to eq(5)
        expect(forecast.daily_weather.first[:date]).to be_a(Time)
        expect(forecast.daily_weather.first[:sunrise]).to be_a(Time)
        expect(forecast.daily_weather.first[:sunset]).to be_a(Time)
        expect(forecast.daily_weather.first[:max_temp]).to be_a(Float)
        expect(forecast.daily_weather.first[:min_temp]).to be_a(Float)
        expect(forecast.daily_weather.first[:conditions]).to be_a(String)
        expect(forecast.daily_weather.first[:icon]).to be_a(String)

        expect(forecast.hourly_weather.count).to eq(8)
        expect(forecast.hourly_weather.first[:time]).to be_a(String)
        expect(forecast.hourly_weather.first[:temperature]).to be_a(Float)
        expect(forecast.hourly_weather.first[:conditions]).to be_a(String)
        expect(forecast.hourly_weather.first[:icon]).to be_a(String)
      end
    end
  end
end
