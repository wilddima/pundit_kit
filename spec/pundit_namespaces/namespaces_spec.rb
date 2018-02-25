require 'spec_helper'

RSpec.describe PunditNamespaces::Namespaces do
  let(:namespaces) do
    PunditNamespaces.routes do
      namespace :first, if: -> (x) { x > 0 } do
        root_namespace
        namespace :one, if: -> (x) { x == 1 }
        namespace :two, if: -> (x) { x == 2 }
      end

      namespace :second, if: -> (x) { x < 0 } do
        root_namespace
        namespace :one, if: -> (x) { x == -1 }
        namespace :two, if: -> (x) { x == -2 }
      end
    end
  end

  describe '#matches' do
    subject { namespaces.matches(matcher) }

    let(:matcher) { 1 }

    it 'return correct route' do
      expect(subject.flatten.map(&:name)).to match_array(%i[first _root_namespace first one])
    end
  end
end
