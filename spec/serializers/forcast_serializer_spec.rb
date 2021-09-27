require 'rails_helper'
  describe 'ForcastSerializer', type: :serializer do
    describe 'instance methods' do
      describe '#serializeabble_hash' do
        context 'when I provide a valid forecast' do
          let!(:forcast) {create{:forcast}}
        end
      end
    end
  end
