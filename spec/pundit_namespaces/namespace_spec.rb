require 'spec_helper'

RSpec.describe PunditNamespaces::Namespace do
  subject { described_class.new(name, options) }

  let(:name) { 'test' }
  let(:options) { { if: if_block } }
  let(:if_block) { -> (arg) { arg } }

  describe '#match?' do
    it 'does return true' do
      expect(subject.match?(true)).to be_truthy
    end

    it 'does return false' do
      expect(subject.match?(false)).to be_falsey
    end
  end
end
