require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { User }


  describe '#GET index' do
    before { sign_in current_user }

    context 'user is admin' do
      let(:current_user) { user.new(:admin) }
      subject { get :index }

      it do
        expect(subject).to have_http_status(:success)
      end
    end
  end
end
