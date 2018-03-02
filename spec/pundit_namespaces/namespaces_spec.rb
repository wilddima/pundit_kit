require 'spec_helper'

RSpec.describe PunditNamespaces::Namespaces do
  let(:namespaces) { PunditNamespaces.namespaces }

  describe '#matches' do
    subject { namespaces.matches(matcher) }

    context 'when matcher is admin' do
      let(:matcher) { User.new(:admin) }

      it 'return staff admin route' do
        expect(subject.flatten.map(&:name)).to eq(%i[staff admin])
      end
    end

    context 'when matcher is user' do
      let(:matcher) { User.new(:user) }

      it 'return staff user route' do
        expect(subject.flatten.map(&:name)).to eq(%i[staff user])
      end
    end

    context 'when matcher is client' do
      let(:matcher) { User.new(:client) }

      it 'return client route' do
        expect(subject.flatten.map(&:name)).to eq(%i[client])
      end
    end
  end
end
