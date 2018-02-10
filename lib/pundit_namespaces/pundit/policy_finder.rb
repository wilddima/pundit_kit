module Pundit
  class PolicyFinder
    def initialize(object)
      @object = [PunditNamespaces.namespaces.matches(1), *object]
    end
  end
end
