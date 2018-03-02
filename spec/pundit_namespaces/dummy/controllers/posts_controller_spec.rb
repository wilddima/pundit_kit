require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:current_user) { User.new(user) }
  let(:user) { :client }

  describe '#GET index' do
    before { sign_in current_user }

    subject { get(:index) }

    context 'user is client' do
      it 'does return success' do
        expect(subject).to have_http_status(:success)
      end
    end

    context 'user is user' do
      let(:user) { :user }

      it 'does return success' do
        expect(subject).to have_http_status(:success)
      end
    end

    context 'user is admin' do
      let(:user) { :admin }

      it 'does return success' do
        expect(subject).to have_http_status(:success)
      end
    end
  end

  describe '#POST create' do
    before { sign_in current_user }

    subject { post(:create) }

    context 'user is client' do
      it 'does raise error' do
        expect{ subject }.to raise_error(ClientNotAllowedError)
      end
    end

    context 'user is user' do
      let(:user) { :user }

      it 'does return success' do
        expect(subject).to have_http_status(:success)
      end
    end

    context 'user is admin' do
      let(:user) { :admin }

      it 'does return success' do
        expect(subject).to have_http_status(:success)
      end
    end
  end

  describe '#DELETE destroy' do
    before { sign_in current_user }

    subject { delete(:destroy, params: { id: 1 }) }

    context 'user is client' do
      it 'does raise error' do
        expect{ subject }.to raise_error(ClientNotAllowedError)
      end
    end

    context 'user is user' do
      let(:user) { :user }

      it 'does raise error' do
        expect{ subject }.to raise_error(UserNotAllowedError)
      end
    end

    context 'user is admin' do
      let(:user) { :admin }

      it 'does return success' do
        expect(subject).to have_http_status(:success)
      end
    end
  end
end
