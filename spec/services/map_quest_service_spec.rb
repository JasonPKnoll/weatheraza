require 'rails_helper'

RSpec.describe MapQuestService do
  describe 'class methods' do
    describe 'connection setup' do
      it 'succesfully establishes the connection and defines the headers', :vcr do
        setup = MapQuestService.conn

        expect(setup.headers).to include('key')
        expect(setup.headers.values).to include(ENV['map_quest_key'])
      end
    end
  end
end
