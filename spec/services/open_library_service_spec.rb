require 'rails_helper'

RSpec.describe OpenLibraryService, type: :service do
  describe 'class methods' do
    describe 'connection setup' do
      it 'succesfully establishes the connection and defines the headers', :vcr do
        setup = OpenLibraryService.conn

        expect(setup.params).to include('appid')
      end
    end

    describe ':: get_books' do
      context 'when I provide valid coordinates', :vcr do
        subject(:search) { OpenLibraryService.get_books(location, quantity) }

        # let(:coordinate) { {lat: 33.44, lon: -94.04} }
        let(:location) { 'Devner' }
        let(:quantity) { 5 }

        it 'provides valid books has' do
          aggregate_failures 'test search' do
            expect(search).to be_a(Hash)

            expect(search).to have_key(:numfound)
            expect(search[:numfound]).to be_a(Integer)

            expect(search).to have_key(:docs)
            expect(search[:docs][0]).to be_a(Hash)

            expect(search[:docs][0]).to have_key(:title)
            expect(search[:docs][0][:title]).to be_a(String)
            expect(search[:docs][0]).to have_key(:isbn)
            expect(search[:docs][0][:isbn]).to be_a(Array)
            expect(search[:docs][0]).to have_key(:author_name)
            expect(search[:docs][0][:author_name]).to be_a(String)

          end
        end

      end
    end  # end of get_books

  end # end of class methods
end
