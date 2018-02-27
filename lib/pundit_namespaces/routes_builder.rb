module PunditNamespaces
  class RoutesBuilder
    attr_reader :namespaces

    def initialize(namespaces)
      @namespaces = namespaces
    end

    def build_by(block)
      namespaces.instance_eval(&block)
      namespaces
    end
  end
end
