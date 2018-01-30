require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe '#GET index' do
    subject { get :index }

    it do
      expect(subject).to have_http_status(:success)
    end
  end
end
