module PunditNamespaces
  class Namespace
    attr_reader :name, :options, :match

    def initialize(name, options = {})
      @name = name
      @options = options
      @match = options.delete(:if) || ->(_) { true }
    end

    def match?(*args)
      match&.call(*args)
    end
  end
end
