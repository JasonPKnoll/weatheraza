require 'rails_helper'

RSpec.describe MapQuestService, type: :service do
  describe 'class methods' do
    describe 'connection setup' do
      it 'succesfully establishes the connection and defines the headers', :vcr do
        setup = MapQuestService.conn

        expect(setup.params).to include('key')
        expect(setup.params.values).to include(ENV['map_quest_key'])
      end
    end

    describe ':: get_geocoding' do
      context 'when I provide valid coordinates', :vcr do
        subject(:geocode) { MapQuestService.get_geocoding(location) }

        let(:location) {'Denver+CO'}

        it 'provides valid forcast has' do
          aggregate_failures 'test geocode' do
            expect(geocode).to be_a(Hash)

            expect(geocode).to have_key(:results)
            expect(geocode[:results][0]).to be_a(Hash)

            expect(geocode[:results][0]).to have_key(:providedLocation)
            expect(geocode[:results][0][:providedLocation]).to be_a(Hash)
            expect(geocode[:results][0][:providedLocation]).to have_key(:location)
            expect(geocode[:results][0][:providedLocation][:location]).to eq("#{location}")

            expect(geocode[:results][0]).to have_key(:locations)
            expect(geocode[:results][0][:locations][0]).to be_a(Hash)

            expect(geocode[:results][0][:locations][0]).to have_key(:latLng)
            expect(geocode[:results][0][:locations][0][:latLng]).to be_a(Hash)
            expect(geocode[:results][0][:locations][0][:latLng]).to have_key(:lat)
            expect(geocode[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
            expect(geocode[:results][0][:locations][0][:latLng]).to have_key(:lng)
            expect(geocode[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
          end
        end

      end
    end  # end of get_geocoding

    describe ':: get_direction' do
      context 'when I provide valid coordinates', :vcr do
        subject(:directions) { MapQuestService.get_directions(from, to) }

        let(:from) { 'Denver, CO' }
        let(:to) { 'Estes Park, CO' }

        it 'provides valid route info' do
          aggregate_failures 'test directions' do
            expect(directions).to be_a(Hash)

            expect(directions).to have_key(:route)

            expect(directions[:route]).to have_key(:formattedTime)
            expect(directions[:route][:formattedTime]).to be_a(String)
            expect(directions[:route][:formattedTime].length).to eq(8)
          end
        end
      end

      context 'when I provide bad coordinates', :vcr do
        subject(:directions) { MapQuestService.get_directions(from, to) }

        let(:from) { 'Denver, CO' }
        let(:to) { '214@!@$!@$' }

        it 'provides invalid route information' do
          aggregate_failures 'test directions' do
            expect(directions).to be_a(Hash)

            expect(directions).to have_key(:route)

            expect(directions[:route]).to_not have_key(:formattedTime)

            expect(directions[:route]).to have_key(:routeError)
            expect(directions[:route][:routeError]).to be_a(Hash)
            expect(directions[:route][:routeError]).to have_key(:errorCode)
            expect(directions[:route][:routeError][:errorCode]).to be_a(Integer)
          end
        end

      end

    end # End of get_direction

  end # end of class methods
end
