require 'rails_helper'

RSpec.describe SpeakersController do
  describe 'POST #create' do
    context 'with valid attributes' do

      let(:expected_speaker) { Speaker.new(name: 'Obama') }
      before do
        allow(Speaker).to receive(:create!).and_return(expected_speaker)
        post :create, params: { speaker: { name: 'Obama' } }
      end
 
      it 'creates a new speaker' do
        expect(Speaker).to have_received(:create!).with(name: 'Obama')
      end

      it { should redirect_to(speakers_path) }
    end

    context 'with invalid attributes' do
      before do
        allow(Speaker).to receive(:create!) { fail ActiveRecord::ActiveRecordError }
        post :create, params: { speaker: { name: '' } }
      end

      it { is_expected.to set_flash[:alert].to('Failed to save speaker') }
      it { should redirect_to(new_speaker_path) }
    end
  end
end


